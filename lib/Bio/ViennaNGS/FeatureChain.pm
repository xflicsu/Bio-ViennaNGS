# -*-CPerl-*-
# Last changed Time-stamp: <2015-10-27 14:43:29 mtw>

package Bio::ViennaNGS::FeatureChain;

use version; our $VERSION = qv('0.16');
use Moose;
with 'MooseX::Clone';
use MooseX::InstanceTracking;

has 'type' => (
	       is => 'rw',
	       isa => 'Str', # [exon,intron,SJ,promoter,TSS,...]
	      );

has 'chain' => (
		is => 'rw',
		traits => ['Array', 'Clone' => {to=>'ArrayRef'}],
		isa => 'ArrayRef[Bio::ViennaNGS::Feature]',
		required => '1',
		builder => 'build_chain',
		auto_deref => 1
		);

sub build_chain {
  my $self = shift;
  my $featurelist = shift; ## We expect features to be pre-sorted, So
                           ## I simply read in an arrayref of Feature
                           ## Objects
  return ($featurelist);
}

sub print_chain{
  my $self = shift;
  return 0 if (!$self->chain);
  my $out;
  foreach my $feature (@{$self->chain}){
    $out .= join("\t",
		 "chr".$feature->chromosome,
		 $feature->start,
		 $feature->end,
		 $feature->name,
		 $feature->score,
		 $feature->strand);
    $out .= "\n";
  }
  return $out;
}

#sub clone {
#  my ( $self, %params ) = @_;
#  $self->meta->clone_object($self, %params);
#  return $self;
#}

no Moose;

1;
