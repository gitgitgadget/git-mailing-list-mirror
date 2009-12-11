From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Fri, 11 Dec 2009 07:46:23 -0800 (PST)
Message-ID: <m3ljh9cy3b.fsf@localhost.localdomain>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
	<1260488743-25855-2-git-send-email-warthog9@kernel.org>
	<1260488743-25855-3-git-send-email-warthog9@kernel.org>
	<1260488743-25855-4-git-send-email-warthog9@kernel.org>
	<1260488743-25855-5-git-send-email-warthog9@kernel.org>
	<1260488743-25855-6-git-send-email-warthog9@kernel.org>
	<1260488743-25855-7-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 16:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ7hS-0000bL-9Y
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 16:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbZLKPqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 10:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758635AbZLKPqW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 10:46:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:59688 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758421AbZLKPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 10:46:21 -0500
Received: by ey-out-2122.google.com with SMTP id d26so334722eyd.19
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 07:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kwwr6iiP7j3cfr5zOPTOtSYjx+tW2Ps0RhL3MxjbwzA=;
        b=oPJAm6XDVsfQ5wmjuT56da6ERIBY8gUwIxpzLJIYIjYQxpiKXAVmNiH3nPbBSR/rD/
         xeIl6gNbvPKuylM2Gvl8+hQAfMTqEn98/MulkiIpFWL7G0gkftdVrhJsBvXv8jSiayAw
         LMDvUBPKXyFB3ZNSdOq9jOu+w2vjlMGUrgD20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cJ7zcFjKVqRx4I62Sd6q/7oBM+awtoaJaF6uz1ZWVYfVz6DbfyK/JYH9zwn8wBnw47
         sp8Xu2awwF3BGsxppatWAk3ByGZPSHQjbCFRJnAKqSe2NSfjI9o9VZpeTa9Y2nLnZOVf
         HfqqPxrLsIdFTulnJ34u96fuYqIKjs+dHhQFg=
Received: by 10.213.8.28 with SMTP id f28mr1676703ebf.39.1260546383790;
        Fri, 11 Dec 2009 07:46:23 -0800 (PST)
Received: from localhost.localdomain (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id 13sm1232857ewy.5.2009.12.11.07.46.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 07:46:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBBFlCrV006091;
	Fri, 11 Dec 2009 16:47:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBBFkm1d006086;
	Fri, 11 Dec 2009 16:46:48 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1260488743-25855-7-git-send-email-warthog9@kernel.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135092>

"John 'Warthog9' Hawley" <warthog9@kernel.org> writes:

> This is an attempt to break out the default values & associated
> documentation from the main gitweb file so that it's easier to
> browse / read and understand without the associated code involved.
> 
> This helps by making defaults self contained with their documentation
> making it easier for someone to read through things and find what
> they want
> 
> This is also a not-so-subtle start of trying to break up gitweb into
> separate files for easier maintainability, having everything in a
> single file is just a mess and makes the whole thing more complicated
> than it needs to be.  This is a bit of a baby step towards breaking it
> up for easier maintenance.

The question is if easier maintenance and development by spliting
gitweb for developers offsets ease of install for users.

> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

Signoff mismatch.

> ---
>  .gitignore                  |    1 +
>  Makefile                    |   15 +-
>  gitweb/Makefile             |    2 +-
>  gitweb/gitweb.perl          |  515 +++++--------------------------------------
>  gitweb/gitweb_defaults.perl |  468 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 537 insertions(+), 464 deletions(-)
>  create mode 100644 gitweb/gitweb_defaults.perl
> 
> 
> diff --git a/.gitignore b/.gitignore
> index ac02a58..5e48102 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -151,6 +151,7 @@
>  /git-core-*/?*
>  /gitk-git/gitk-wish
>  /gitweb/gitweb.cgi
> +/gitweb/gitweb_defaults.pl

Hmmm... gitweb/gitweb_defaults.perl as source file, and
gitweb/gitweb_defaults.pl as generated file?  Wouldn't it be better to
go with the convention used elsewhere in gitweb and use
gitweb/gitweb_defaults.perl.in or gitweb/gitweb_defaults.pl.in as
source file?

>  /test-chmtime
>  /test-ctype
>  /test-date
> diff --git a/Makefile b/Makefile
> index 8db9d01..2c5f139 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1510,14 +1510,16 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
>  	mv $@+ $@
>  
>  .PHONY: gitweb
> -gitweb: gitweb/gitweb.cgi
> +gitweb: gitweb/gitweb.cgi gitweb/gitweb_defaults.pl
>  ifdef JSMIN
> -OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
> -gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
> +OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js gitweb/gitweb_defaults.pl
> +gitweb/gitweb.cgi gitweb/gitweb_defaults.pl: gitweb/gitweb.perl gitweb/gitweb.min.js gitweb/gitweb_defaults.perl
>  else
> -OTHER_PROGRAMS += gitweb/gitweb.cgi
> -gitweb/gitweb.cgi: gitweb/gitweb.perl
> +OTHER_PROGRAMS += gitweb/gitweb.cgi gitweb/gitweb_defaults.pl
> +gitweb/gitweb.cgi: gitweb/gitweb_defaults.pl
> +gitweb/gitweb.cgi gitweb/gitweb_defaults.pl: gitweb/gitweb.perl gitweb/gitweb_defaults.perl
>  endif

> +	#$(QUIET_GEN)$(RM) $@ $@+ &&

What this line is about?

>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>  	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
> @@ -1539,7 +1541,7 @@ endif
>  	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
>  	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
>  	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
> -	    $(patsubst %.cgi,%.perl,$@) >$@+ && \
> +	    $(patsubst %.cgi,%.perl,$(patsubst %.pl, %.perl, $@)) >$@+ && \

Why the slightly inconsistent style ("%.cgi,%perl" vs "%.pl, %perl")?


Also wouldn't all replacements be in the new gitweb_defaults file, so
there would be no need then to do replacements for gitweb.cgi?

Oh, I see there is at least one that stayed in gitweb.perl: $version

>  	chmod +x $@+ && \
>  	mv $@+ $@
>  
> @@ -1913,6 +1915,7 @@ clean:
>  	$(MAKE) -C Documentation/ clean
>  ifndef NO_PERL
>  	$(RM) gitweb/gitweb.cgi
> +	$(RM) gitweb/gitweb_defaults.pl
>  	$(MAKE) -C perl clean
>  endif
>  	$(MAKE) -C templates/ clean
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 8d318b3..2bd421a 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -1,6 +1,6 @@
>  SHELL = /bin/bash
>  
> -FILES = gitweb.cgi
> +FILES = gitweb.cgi gitweb_defaults.pl
>  
>  .PHONY: $(FILES)
>  
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3b44371..fd41539 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -36,466 +36,67 @@ our $version = "++GIT_VERSION++";
>  our $my_url = $cgi->url();
>  our $my_uri = $cgi->url(-absolute => 1);
>  

[cut deletion]

> +# Define and than setup our configuration 
> +#
> +our(
> +	$VERSION,
> +	$path_info,
> +	$GIT,
> +	$projectroot,
> +	$project_maxdepth,
> +	$home_link,
> +	$home_link_str,
> +	$site_name,
> +	$site_header,
> +	$home_text,
> +	$site_footer,
> +	@stylesheets,
> +	$stylesheet,
> +	$logo,
> +	$favicon,
> +	$javascript,
> +	$logo_url,
> +	$logo_label,
> +	$projects_list,
> +	$projects_list_description_width,
> +	$default_projects_order,
> +	$export_ok,
> +	$export_auth_hook,
> +	$strict_export,
> +	@git_base_url_list,
> +	$default_blob_plain_mimetype,
> +	$default_text_plain_charset,
> +	$mimetypes_file,
> +	$missmatch_git,
> +	$gitlinkurl,
> +	$maxload,
> +	$cache_enable,
> +	$minCacheTime,
> +	$maxCacheTime,
> +	$cachedir,
> +	$backgroundCache,
> +	$nocachedata,
> +	$nocachedatabin,
> +	$fullhashpath,
> +	$fullhashbinpath,
> +	$export_auth_hook,
> +	%known_snapshot_format_aliases,
> +	%known_snapshot_formats,
> +	$path_info,
> +	$fallback_encoding,
> +	%avatar_size,
> +	$project_maxdepth,
> +	$headerRefresh,
> +	$base_url,
> +	$projects_list_description_width,
> +	$default_projects_order,
> +	$prevent_xss,
> +	@diff_opts,
> +	%feature
>  );

Why this block is required?  Why not have variables defined (using
"our") in gitweb_defaults file?

[cut deletion]  

> +do 'gitweb_defaults.pl';
>  
>  sub gitweb_get_feature {
>  	my ($name) = @_;
> diff --git a/gitweb/gitweb_defaults.perl b/gitweb/gitweb_defaults.perl
> new file mode 100644
> index 0000000..ede0daf
> --- /dev/null
> +++ b/gitweb/gitweb_defaults.perl
> @@ -0,0 +1,468 @@
> +# gitweb - simple web interface to track changes in git repositories
> +#
> +# (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>
> +# (C) 2005, Christian Gierke
> +#
> +# This program is licensed under the GPLv2
> +
> +# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
> +# needed and used only for URLs with nonempty PATH_INFO
> +$base_url = $my_url;

Why not "our $base_url = $my_url;"?

[cut]

> +1;

-- 
Jakub Narebski
Poland
ShadeHawk on #git
