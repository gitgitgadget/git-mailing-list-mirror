From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Optional grouping of projects by category
Date: Wed, 3 Dec 2008 00:36:12 +0100
Message-ID: <200812030036.13562.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: Sebastien Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 00:37:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ena-0006a3-OC
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 00:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbYLBXfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838AbYLBXfk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 18:35:40 -0500
Received: from ik-out-1112.google.com ([66.249.90.178]:61382 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbYLBXfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 18:35:37 -0500
Received: by ik-out-1112.google.com with SMTP id c29so2712628ika.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 15:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZrF6A7hpbdlm6VXclpFUoVdZny14t+tg3LQKVtSOYrM=;
        b=v8n9IbtLxp1639hu7ieMCBIEp/fByxkxsUGoTsUGoWrcqKzXiIbAQlI7jfaq5E4Gcw
         3nzxjavacZWCmg8eITUmYuiFbcFQQcrP8o+gw8nLEBO+y2OfxtFizia5vm10SnH1ZsCP
         iatYXqDjtlZqSZ20/ma7WSCgklBPLYymaPOxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NtCn66cxqppKtJFwmyhzvv9kTNRiAjHsrvbIyIqauy9luMuUuNQxsb5iayiOxLCjrJ
         UFYSj+Wnb4lONkyjGkTubXcf+kuj0jImRfSutx21viSGtmRYKJXEDaWkbOOTRg4Zw0YW
         a4d3gSChCiinSFv3ZL+XuuEBqjxK6kLbGuVVs=
Received: by 10.210.66.1 with SMTP id o1mr14670130eba.174.1228260934838;
        Tue, 02 Dec 2008 15:35:34 -0800 (PST)
Received: from ?192.168.1.11? (abvk204.neoplus.adsl.tpnet.pl [83.8.208.204])
        by mx.google.com with ESMTPS id 3sm293740eyi.55.2008.12.02.15.35.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 15:35:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87wsei1uvp.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102188>

On Tue, 2 Dec 2008, Sebastien Cevey wrote:

> This adds the GITWEB_GROUP_CATEGORIES option which, if enabled, will
> result in grouping projects by category on the project list page.

Should this really be build time configuration (to set default value)?

> The category is specified for each project by the $GIT_DIR/category file
> or the 'category' variable in its configuration file.
> 
> The feature is inspired from Sham Chukoury's patch for the XMMS2
> gitweb, but has been rewritten for the current gitweb development
> HEAD.
> 
> Thanks to Florian Ragwitz for Perl tips.
> 
> Signed-off-by: Sebastien Cevey <seb@cine7.net>
> ---
> 
> I submitted a previous version of this patch on July 27, but was told
> to wait for the end of the feature freeze.  I submitted it again on
> September 5, but didn't get any reply.  Hope to be luckier this time!

Unfortunately it looks like you hit the edge of feature freeze again.
It is not announced yet, as far as I remember, but we are now at 
1.6.1-pre1.  I'll add this patch to my queue to resubmit after 1.6.1
is released, if it wouldn't be accepted in time.

By the way, there was alternate patch series by Gustavo Sverzut Barbieri
on 29 July 2008 adding categories support to gitweb:
  http://thread.gmane.org/gmane.comp.version-control.git/90553
with live demo at http://staff.get-e.org/
 
> This is a new version of the patch, which has been rebased onto the
> current HEAD of the master branch.
> 
>  Makefile           |    2 +
>  gitweb/README      |   11 +++
>  gitweb/gitweb.css  |    5 ++
>  gitweb/gitweb.perl |  173 +++++++++++++++++++++++++++++++++++-----------------
>  4 files changed, 135 insertions(+), 56 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 649cfb8..a8e8bbf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -211,6 +211,7 @@ GITWEB_EXPORT_OK =
>  GITWEB_STRICT_EXPORT =
>  GITWEB_BASE_URL =
>  GITWEB_LIST =
> +GITWEB_GROUP_CATEGORIES =
>  GITWEB_HOMETEXT = indextext.html
>  GITWEB_CSS = gitweb.css
>  GITWEB_LOGO = git-logo.png
> @@ -1189,6 +1190,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
>  	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
>  	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
>  	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
> +	    -e 's|++GITWEB_GROUP_CATEGORIES++|$(GITWEB_GROUP_CATEGORIES)|g' \
>  	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
>  	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
>  	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \

O.K. That is just support for build time configuration of default value
(default configuration).

> diff --git a/gitweb/README b/gitweb/README
> index 825162a..a6f82c5 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -38,6 +38,11 @@ You can specify the following configuration variables when building GIT:
>     using gitweb" in INSTALL file for gitweb to find out how to generate
>     such file from scan of a directory. [No default, which means use root
>     directory for projects]
> + * GITWEB_GROUP_CATEGORIES
> +   Groups projects by category on the main projects list page if set
> +   to true.  The category of a project is determined by the
> +   $GIT_DIR/category file or the 'category' variable in its
> +   configuration file.  [No default / Not set]
>   * GITWEB_EXPORT_OK
>     Show repository only if this file exists (in repository).  Only
>     effective if this variable evaluates to true.  [No default / Not set]
> @@ -188,6 +193,12 @@ not include variables usually directly set during build):
>     full description is available as 'title' attribute (usually shown on
>     mouseover).  By default set to 25, which might be too small if you
>     use long project descriptions.
> + * $projects_list_group_categories
> +   Enables the grouping of projects by category on the project list page.
> + * $project_list_default_category
> +   Default category for projects for which none is specified.  If set
> +   to the empty string, such projects will remain uncategorized and
> +   listed at the top, above categorized projects.
>   * @git_base_url_list
>     List of git base URLs used for URL to where fetch project from, shown
>     in project summary page.  Full URL is "$git_base_url/$project".

Nice documenting it, but I think you should also update "Per-repository
gitweb configuration" section in gitweb/README and mention category
(file) or gitweb.category repository configuration variable.

> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index a01eac8..2dd45d6 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -264,6 +264,11 @@ td.current_head {
>  	text-decoration: underline;
>  }
>  
> +td.category {
> +	padding-top: 1em;
> +	font-weight: bold;
> +}
> +
>  table.diff_tree span.file_status.new {
>  	color: #008000;
>  }
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 933e137..c1bcd96 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -87,6 +87,13 @@ our $projects_list = "++GITWEB_LIST++";
>  # the width (in characters) of the projects list "Description" column
>  our $projects_list_description_width = 25;
>  
> +# group projects by category on the projects list
> +our $projects_list_group_categories = "++GITWEB_GROUP_CATEGORIES++";
> +
> +# default category if none specified
> +# (leave the empty string for no category)
> +our $project_list_default_category = "";
> +
>  # default order of projects list
>  # valid values are none, project, descr, owner, and age
>  our $default_projects_order = "project";
> @@ -2001,18 +2008,28 @@ sub git_get_path_by_hash {
>  ## ......................................................................
>  ## git utility functions, directly accessing git repository
>  
> -sub git_get_project_description {
> -	my $path = shift;
> +sub git_get_project_config_from_file {
> +	my ($name, $path) = @_;
>  
>  	$git_dir = "$projectroot/$path";
> -	open my $fd, "$git_dir/description"
> -		or return git_get_project_config('description');
> -	my $descr = <$fd>;
> +	open my $fd, "$git_dir/$name"
> +		or return git_get_project_config($name);
> +	my $conf = <$fd>;
>  	close $fd;
> -	if (defined $descr) {
> -		chomp $descr;
> +	if (defined $conf) {
> +		chomp $conf;
>  	}
> -	return $descr;
> +	return $conf;
> +}
> +
> +sub git_get_project_description {
> +	my $path = shift;
> +	return git_get_project_config_from_file('description', $path);
> +}
> +
> +sub git_get_project_category {
> +	my $path = shift;
> +	return git_get_project_config_from_file('category', $path);
>  }

I see you have resurrected (?) here git_get_project_config_from_file.
But I don't think it is correct name for this subroutine: it gets
config from a file in GIT_DIR _or_ from repository config.

Nevertheless nice that you avoided code duplication here.

>  
>  sub git_get_project_ctags {
> @@ -3907,8 +3924,9 @@ sub git_patchset_body {
>  
>  # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
>  
> -# fills project list info (age, description, owner, forks) for each
> -# project in the list, removing invalid projects from returned list
> +# fills project list info (age, description, owner, category, forks)
> +# for each project in the list, removing invalid projects from
> +# returned list
>  # NOTE: modifies $projlist, but does not remove entries from it
>  sub fill_project_list_info {
>  	my ($projlist, $check_forks) = @_;
> @@ -3931,6 +3949,11 @@ sub fill_project_list_info {
>  		if (!defined $pr->{'owner'}) {
>  			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
>  		}
> +		if ($projects_list_group_categories && !defined $pr->{'cat'}) {
> +			my $cat = git_get_project_category($pr->{'path'}) ||
> +			                                   $project_list_default_category;
> +			$pr->{'cat'} = to_utf8($cat);
> +		}
>  		if ($check_forks) {
>  			my $pname = $pr->{'path'};
>  			if (($pname =~ s/\.git$//) &&

O.K., although I wonder if we wouldn't spell key name in full, i.e as
$pr->{'category'}. But I think you follow conventions established
earlier here...

> @@ -3948,6 +3971,19 @@ sub fill_project_list_info {
>  	return @projects;
>  }
>  
> +# returns a hash of categories, containing the list of project
> +# belonging to each category
> +sub build_category_list {

I'm not sure about the name of this subroutine...

> +	my ($projlist) = @_;

I would use 

	my $projlist = shift;

here (or even $projects).

> +	my %categories;
> +
> +	for my $pr (@{ $projlist }) {

I would use simpler

	for my $pr (@$projlist) {

here

> +		push @{$categories{ $pr->{'cat'} }}, $pr;
> +	}
> +
> +	return %categories;
> +}
> +
>  # print 'sort by' <th> element, generating 'sort by $name' replay link
>  # if that order is not selected
>  sub print_sort_th {
> @@ -3964,59 +4000,17 @@ sub print_sort_th {
>  	}
>  }
>  

This chunk looks worse that it really is by accident...

> -sub git_project_list_body {

It would be nice to have description what this subroutine does.

> +sub print_project_rows {
>  	# actually uses global variable $project
> -	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
> -
> -	my ($check_forks) = gitweb_check_feature('forks');
> -	my @projects = fill_project_list_info($projlist, $check_forks);
> +	my ($projects, $from, $to, $check_forks, $show_ctags) = @_;
>  
> -	$order ||= $default_projects_order;
>  	$from = 0 unless defined $from;
> -	$to = $#projects if (!defined $to || $#projects < $to);
> +	$to = $#$projects if (!defined $to || $#$projects < $to);
>  
> -	my %order_info = (
> -		project => { key => 'path', type => 'str' },
> -		descr => { key => 'descr_long', type => 'str' },
> -		owner => { key => 'owner', type => 'str' },
> -		age => { key => 'age', type => 'num' }
> -	);
> -	my $oi = $order_info{$order};
> -	if ($oi->{'type'} eq 'str') {
> -		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @projects;
> -	} else {
> -		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
> -	}
> -
> -	my $show_ctags = gitweb_check_feature('ctags');
> -	if ($show_ctags) {
> -		my %ctags;
> -		foreach my $p (@projects) {
> -			foreach my $ct (keys %{$p->{'ctags'}}) {
> -				$ctags{$ct} += $p->{'ctags'}->{$ct};
> -			}
> -		}
> -		my $cloud = git_populate_project_tagcloud(\%ctags);
> -		print git_show_project_tagcloud($cloud, 64);
> -	}
> -
> -	print "<table class=\"project_list\">\n";
> -	unless ($no_header) {
> -		print "<tr>\n";
> -		if ($check_forks) {
> -			print "<th></th>\n";
> -		}
> -		print_sort_th('project', $order, 'Project');
> -		print_sort_th('descr', $order, 'Description');
> -		print_sort_th('owner', $order, 'Owner');
> -		print_sort_th('age', $order, 'Last Change');
> -		print "<th></th>\n" . # for links
> -		      "</tr>\n";
> -	}
>  	my $alternate = 1;
>  	my $tagfilter = $cgi->param('by_tag');
>  	for (my $i = $from; $i <= $to; $i++) {
> -		my $pr = $projects[$i];
> +		my $pr = $projects->[$i];
>  
>  		next if $tagfilter and $show_ctags and not grep { lc $_ eq lc $tagfilter } keys %{$pr->{'ctags'}};
>  		next if $searchtext and not $pr->{'path'} =~ /$searchtext/
> @@ -4060,6 +4054,73 @@ sub git_project_list_body {
>  		      "</td>\n" .
>  		      "</tr>\n";
>  	}
> +}
> +
> +sub git_project_list_body {
> +	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
> +
> +	my ($check_forks) = gitweb_check_feature('forks');
> +	my @projects = fill_project_list_info($projlist, $check_forks);
> +
> +	$order ||= $default_projects_order;
> +
> +	my %order_info = (
> +		project => { key => 'path', type => 'str' },
> +		descr => { key => 'descr_long', type => 'str' },
> +		owner => { key => 'owner', type => 'str' },
> +		age => { key => 'age', type => 'num' }
> +	);
> +	my $oi = $order_info{$order};
> +	if ($oi->{'type'} eq 'str') {
> +		@projects = sort {$a->{$oi->{'key'}} cmp $b->{$oi->{'key'}}} @projects;
> +	} else {
> +		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
> +	}
> +
> +	my $show_ctags = gitweb_check_feature('ctags');
> +	if ($show_ctags) {
> +		my %ctags;
> +		foreach my $p (@projects) {
> +			foreach my $ct (keys %{$p->{'ctags'}}) {
> +				$ctags{$ct} += $p->{'ctags'}->{$ct};
> +			}
> +		}
> +		my $cloud = git_populate_project_tagcloud(\%ctags);
> +		print git_show_project_tagcloud($cloud, 64);
> +	}
> +
> +	print "<table class=\"project_list\">\n";
> +	unless ($no_header) {
> +		print "<tr>\n";
> +		if ($check_forks) {
> +			print "<th></th>\n";
> +		}
> +		print_sort_th('project', $order, 'Project');
> +		print_sort_th('descr', $order, 'Description');
> +		print_sort_th('owner', $order, 'Owner');
> +		print_sort_th('age', $order, 'Last Change');
> +		print "<th></th>\n" . # for links
> +		      "</tr>\n";
> +	}
> +
> +	if ($projects_list_group_categories) {
> +		my %categories = build_category_list(\@projects);
> +		foreach my $cat (sort keys %categories) {
> +			unless ($cat eq "") {
> +				print "<tr>\n";
> +				if ($check_forks) {
> +					print "<td></td>\n";
> +				}
> +				print "<td class=\"category\" colspan=\"5\">$cat</td>\n";
> +				print "</tr>\n";
> +			}
> +
> +			print_project_rows($categories{$cat}, $from, $to, $check_forks, $show_ctags);
> +		}

Here is and important issue when adding categories support: how division
into categories interplays with sorting of projects.  I see that you
choose to always sort categories alphabetically, and to sort projects
by given column within categories, instead of (more complicated) sorting
categories by first project (first by given order) in a category.

This I think should be mentioned (at least briefly) in commit message.


Another issue is how categories interplay with limiting number of
projects displayed. Currently it is no issue, because projects list
page is not divided into pages, but I think you didn't address this
in your patch.

> +	} else {
> +		print_project_rows(\@projects, $from, $to, $check_forks, $show_ctags);
> +	}
> +
>  	if (defined $extra) {
>  		print "<tr>\n";
>  		if ($check_forks) {
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
