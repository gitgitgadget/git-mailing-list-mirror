From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs-* microformat
Date: Fri, 09 Jan 2009 16:52:20 -0800 (PST)
Message-ID: <m3bpug0ypn.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
	<gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net>
	<cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
	<20090107184515.GB31795@gnu.kitenet.net>
	<20090107190238.GA3909@gnu.kitenet.net>
	<20090107232427.GA18958@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 01:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLS6s-0005TM-Mv
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 01:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbZAJAwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 19:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZAJAwa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 19:52:30 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:48973 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbZAJAw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 19:52:29 -0500
Received: by ewy10 with SMTP id 10so10520895ewy.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 16:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CWK65z+K/9pvIWJpUFENZijMPe+eoA9i4x3YcYcy9E4=;
        b=TD07Wzae2haZR9kPJvDmMHl/91L5PF/Oj36h/FLIxt5hdYtQIdfIb1oLwV95KGL8/m
         r8EGHQu6fFPmn28V+gr33OCkYI4yN/V+Ynm9jRharRuoTP1/CoOfq+GBe0QUDvloLwtz
         WDI6OwmalhJvda8y4Rs5s38bYE3sXeSRmVj98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=rw55AF+JnzW+a+uzOFwlTrOJ9vERT6eAZuwyptvlkN81kF95bBAglHMXGIFBO52fCf
         HbEvaW5kNpPv8pChkWvvtrB8uODU5wrvuhL7q25FIdDJfkMSJq9VO/nDj1Sf86y2A3E+
         YNDbdvQh9XB0iy1Ypqn7JGgwjgdYiwDPQijmY=
Received: by 10.210.57.5 with SMTP id f5mr5443895eba.57.1231548746138;
        Fri, 09 Jan 2009 16:52:26 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id 5sm4742642eyh.18.2009.01.09.16.52.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 16:52:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0A0qL64028554;
	Sat, 10 Jan 2009 01:52:21 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0A0qKBO028551;
	Sat, 10 Jan 2009 01:52:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090107232427.GA18958@gnu.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105051>

Joey Hess <joey@kitenet.net> writes:

> The rel=vcs-* microformat allows a web page to indicate the locations of
> repositories related to it in a machine-parseable manner.
> (See http://kitenet.net/~joey/rfc/rel-vcs/)
> 
> Make gitweb use the microformat if it has been configured with project url
> information in any of the usual ways. On the project summary page, the
> repository URL display is simply marked up using the microformat. On the
> project list page and forks list page, the microformat is embedded in the
> header, since the URLs do not appear on the page.

I think having LINK elements also for 'summary' page would be a good
idea. This microformat is I think mainly for machines, and machines
can I guess read better a few LINK elements in fairly small HEAD of
page, than scan all of many link (A) elements on the page for those
matching vcs-* microformat.

Beside I am not sure if for example hyperlinking SCP-style repository
URL makes sense at all; I am also not sure if hyperlinking links on
which you cannot click on makes good sense (unless you use SPAN or
ABBR instead of A to mark repo links...)

> 
> The microformat could be included on other pages too, but I've skipped
> doing so for now, since it would mean reading another file for every page
> displayed.

Also it is not necessary: if some tool want to get repo links for
given project, it can get 'summary' page; if some tool want to get
list of all repos, it can access one of projects list actions.

> 
> There is a small overhead in including the microformat on project list
> and forks list pages, but getting the project descriptions for those pages
> already incurs a similar overhead, and the ability to get every repo url
> in one place seems worthwhile.

By the way, do you have any benchmarks for that?

> 
> This changes git_get_project_url_list() to not check wantarray, and only
> return in list context -- the only way it is used AFAICS. It memoizes
> both that function and git_get_project_description(), to avoid redundant
> file reads.

I would also add that, from what I understand, you have made
git_get_project_url_list() subroutine to be self-sufficient: it now
considers both per-repository configuration (gitweb.url in config,
cloneurl file in $GIT_DIR) and global gitweb configuration
(@git_base_url_list variable).

Simplification of code so it always return list and does nto check
contents is a side issue, orthogonal to issue mentioned above.

> 
> Signed-off-by: Joey Hess <joey@gnu.kitenet.net>
> ---
>  gitweb/gitweb.perl |   78 +++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 62 insertions(+), 16 deletions(-)
> 
> This incorporates Giuseppe Bilotta's feedback, and uses new features
> of the microformat. You can see this version running at
> http://git.ikiwiki.info/
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 99f71b4..c238717 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2020,9 +2020,14 @@ sub git_get_path_by_hash {
>  ## ......................................................................
>  ## git utility functions, directly accessing git repository
>  
> +{
> +my %project_descriptions; # cache
> +

Won't we get warnings (and perhaps errors) from mod_perl? Shouldn't
this be "our %project_descriptions;"?

>  sub git_get_project_description {
>  	my $path = shift;
>  
> +	return $project_descriptions{$path} if exists $project_descriptions{$path};
> +
>  	$git_dir = "$projectroot/$path";
>  	open my $fd, "$git_dir/description"
>  		or return git_get_project_config('description');
> @@ -2031,7 +2036,9 @@ sub git_get_project_description {
>  	if (defined $descr) {
>  		chomp $descr;
>  	}
> -	return $descr;
> +	return $project_descriptions{$path}=$descr;
> +}
> +
>  }

If we use 'title="$project git repository" for 'rel="vcs-git"' links,
is it still worth it extra complication to avoid double calculation of
project description in the case of 'summary' view for a project?
Because IIRC for 'projects_list' view it is already cached in
@projects list as 'descr' key...

>  
>  sub git_get_project_ctags {
> @@ -2099,18 +2106,30 @@ sub git_show_project_tagcloud {
>  	}
>  }
>  
> +{
> +my %project_url_lists; # cache
> +

Same question: would it work correctly for mod_perl?

>  sub git_get_project_url_list {
> +	# use per project git URL list in $projectroot/$path/cloneurl
> +	# or make project git URL from git base URL and project name
>  	my $path = shift;
>  
> +	return @{$project_url_lists{$path}} if exists $project_url_lists{$path};
> +
> +	my @ret;
>  	$git_dir = "$projectroot/$path";
> -	open my $fd, "$git_dir/cloneurl"
> -		or return wantarray ?
> -		@{ config_to_multi(git_get_project_config('url')) } :
> -		   config_to_multi(git_get_project_config('url'));
> -	my @git_project_url_list = map { chomp; $_ } <$fd>;
> -	close $fd;
> +	if (open my $fd, "$git_dir/cloneurl") {
> +		@ret = map { chomp; $_ } <$fd>;
> +		close $fd;
> +	} else {
> +	       @ret = @{ config_to_multi(git_get_project_config('url')) };
> +	}
> +	@ret=map { "$_/$project" } @git_base_url_list if ! @ret;

Style: 

+	@ret = map { "$_/$project" } @git_base_url_list if !@ret;

or even

+	@ret = map { "$_/$project" } @git_base_url_list unless @ret;

> +
> +	$project_url_lists{$path}=\@ret;
> +	return @ret;
> +}
>  
> -	return wantarray ? @git_project_url_list : \@git_project_url_list;
>  }

Again: is it worth caching? It is only for 'summary'; for
'projects_list' it might be better to extend @projects list instead

>  
>  sub git_get_projects_list {
> @@ -2856,6 +2875,7 @@ sub blob_contenttype {
>  sub git_header_html {
>  	my $status = shift || "200 OK";
>  	my $expires = shift;
> +	my $extraheader = shift;
>  
>  	my $title = "$site_name";
>  	if (defined $project) {
> @@ -2953,6 +2973,8 @@ EOF
>  		print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
>  	}
>  
> +	print $extraheader if defined $extraheader;
> +
>  	print "</head>\n" .
>  	      "<body>\n";
>  

Good solution, but shouldn't this be better put into separate commit,
simply extending git_header_html to allow to add extra data (no need
to name it $extraheader I think, $extra would be enough) to the HTML
header (HEAD element contents)?

> @@ -4365,6 +4387,26 @@ sub git_search_grep_body {
>  	print "</table>\n";
>  }
>  
> +sub git_link_title {
> +	my $project=shift;
> +	
> +	my $description=git_get_project_description($project);
> +	return $project.(length $description ? " - $description" : "");
> +}

Style (whitespace around '='), and the fact that IMHO "$project git
repository" is better than "$project - $description", also because of
  "Unnamed repository; edit this file to name it for gitweb." 
default template

> +
> +# generates header with links to the specified projects
> +sub git_links_header {

Good abstraction, but I'm not so sure about subroutine name.

> +	my $ret='';
> +	foreach my $project (@_) {

Style: I'd rather use named variables, like "my @projects = @_";
also everywhere else we use spaces around '=' usually.

> +		# rel=vcs-* microformat
> +		my $title=git_link_title($project);

Good abstraction.

> +		foreach my $url git_get_project_url_list($project) {
> +			$ret.=qq{<link rel="vcs-git" href="$url" title="$title"/>\n}

To be HTML compatibile, it is better to use 

> +			$ret.=qq{<link rel="vcs-git" href="$url" title="$title" />\n}

(note the space before "/>").

> +		}
> +	}
> +	return $ret;
> +}
> +
>  ## ======================================================================
>  ## ======================================================================
>  ## actions
> @@ -4380,7 +4422,9 @@ sub git_project_list {
>  		die_error(404, "No projects found");
>  	}
>  
> -	git_header_html();
> +	my $extraheader=git_links_header(map { $_->{path} } @list);
> +
> +	git_header_html(undef, undef, $extraheader);
>  	if (-f $home_text) {
>  		print "<div class=\"index_include\">\n";
>  		insert_file($home_text);
> @@ -4405,8 +4449,10 @@ sub git_forks {
>  	if (!@list) {
>  		die_error(404, "No forks found");
>  	}
> +	
> +	my $extraheader=git_links_header(map { $_->{path} } @list);
>  
> -	git_header_html();
> +	git_header_html(undef, undef, $extraheader);
>  	git_print_page_nav('','');
>  	git_print_header_div('summary', "$project forks");
>  	git_project_list_body(\@list, $order);
> @@ -4468,14 +4514,14 @@ sub git_summary {
>  		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
>  	}
>  
> -	# use per project git URL list in $projectroot/$project/cloneurl
> -	# or make project git URL from git base URL and project name
>  	my $url_tag = "URL";
> -	my @url_list = git_get_project_url_list($project);
> -	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
> -	foreach my $git_url (@url_list) {
> +	my $title=git_link_title($project);
> +	foreach my $git_url (git_get_project_url_list($project)) {
>  		next unless $git_url;
> -		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
> +		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>".
> +		      # rel=vcs-* microformat
> +		      "<a rel=\"vcs-git\" href=\"$git_url\" title=\"$title\">$git_url</a>".
> +		      "</td></tr>\n";
>  		$url_tag = "";
>  	}

Non clickable hyperlink... hmmm...

>  
> -- 
> 1.5.6.5
> 
> 
> 
> -- 
> see shy jo

-- 
Jakub Narebski
Poland
ShadeHawk on #git
