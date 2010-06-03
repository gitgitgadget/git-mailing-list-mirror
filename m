From: Jakub Narebski <jnareb@gmail.com>
Subject: About [PATCH 2/2] gitweb: Create a perl module to handle gitweb cgi params and vars
Date: Thu, 3 Jun 2010 10:55:28 +0200
Message-ID: <201006031055.28966.jnareb@gmail.com>
References: <201006022229.31593.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 10:55:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK6DL-0002Vy-Lk
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 10:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab0FCIzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 04:55:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45809 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0FCIzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 04:55:40 -0400
Received: by fxm8 with SMTP id 8so2516481fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=29rbH7E0Y2bWMFUeWfYK5+x2Y02usoK5wbJT5UsGxeI=;
        b=CWmR90HVUaZP4SsbEPZ+U2h9jnTo80D6tliKDB0kiyCcRqzc3DKo9SS9WmtLFuXKDD
         UtlF5xulCGpMMfligHvWY6l/pJTXiFUjD+QpstWKeaQcbKJHqC/bbqLfpTtgYMVU3VGl
         R3v6j8BgHYB4Q4mTwNVQotfBbGpWwpIYubagY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RdQF8bx7DGvLY1gVuqYekfHmiwmsdTDHMpQOc8VpacpsaSSWlTJsE1IMabaCXyfHbk
         FRywc3TMZQjxvUhoj08MjwyTfZlSBc2UAUdvejYiL2QATFXInlrjOCvqOH4GoWvnrklp
         I1CTTBltaqE7xB/UpEMox4VYSoKMqu5cUt4xU=
Received: by 10.204.10.134 with SMTP id p6mr2651349bkp.165.1275555338657;
        Thu, 03 Jun 2010 01:55:38 -0700 (PDT)
Received: from [192.168.1.15] (abvx149.neoplus.adsl.tpnet.pl [83.8.221.149])
        by mx.google.com with ESMTPS id v2sm12226434bkz.1.2010.06.03.01.55.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 01:55:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201006022229.31593.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148300>

This comment is about commit a6d54b3 (gitweb: Create a perl module to
handle gitweb cgi params and vars, 2010-06-02) on 'master' branch of
repository shown at http://repo.or.cz/w/git/gsoc2010-gitweb.git

> From a6d54b39cee3d8d39c7ffd993b23e7477d4b0eeb Mon Sep 17 00:00:00 2001
> From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Date: Wed, 2 Jun 2010 01:09:51 +0530
> Subject: [PATCH] gitweb: Create a perl module to handle gitweb cgi params and vars

I would probably say

  Subject: [PATCH] gitweb: Create Gitweb::Request module to handle gitweb cgi params and vars

or even

  Subject: [PATCH] gitweb: Create Gitweb::Request module

so that _name_ of this module is in commit subject (summary).

> 
> Create a perl module in path gitweb/lib/Gitweb/Request.pm
> to store and handle all the cgi params and global variables
> regarding the gitweb.perl script and change the scope of those
> variables in the main script.
> 
> Change Makefile accordingly to install the Perl Module.

Similar comment like for the previous patch.

You would probably want to list which subroutines were moved to
Gitweb::Request, I think.

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

This patch would be probably based on 'next', and this should be
mentioned in this area, in comment about patch.

>  gitweb/Makefile              |    1 +
>  gitweb/gitweb.perl           | 1245 ++++++++++++++++++++----------------------
>  gitweb/lib/Gitweb/Request.pm |   58 ++
>  3 files changed, 662 insertions(+), 642 deletions(-)
>  create mode 100644 gitweb/lib/Gitweb/Request.pm
> 
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 45e176e..15646b2 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -113,6 +113,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
>  
>  # Files: gitweb/lib/Gitweb
>  GITWEB_LIB_GITWEB += lib/Gitweb/Config.pm
> +GITWEB_LIB_GITWEB += lib/Gitweb/Request.pm

Nice.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 98a85f4..263af48 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -26,6 +26,7 @@ sub __DIR__ () {
>  use lib __DIR__ . "/lib";
>  
>  use Gitweb::Config;
> +use Gitweb::Request;

Nice.

> @@ -33,42 +34,6 @@ BEGIN {
>  
>  our $version = "++GIT_VERSION++";

The above context line changed wrt. original patch, to follow the idea
about exporting variables by default in Gitweb::Config, and not using
fully qualified variable names.

>  
> -our ($my_url, $my_uri, $base_url, $path_info, $home_link);
> -sub evaluate_uri {
> -	our $cgi;

I guess that $cgi is left for gitweb.perl, isn't it, because it
depends on FastCGI vs CGI?  [reads later part].  I guess not, only
$CGI is left in gitweb.perl.

[...]
> -}

O.K. these variables, and evaluate_uri() is moved to Gitweb::Request.

[removed changes related to introducing fully qualified variable
 names; it would make patch smaller without those]

> @@ -347,13 +312,11 @@ our %allowed_options = (
>  # build an array of parameters that can be multi-valued, but since for the time
>  # being it's only this one, we just single it out
>  sub evaluate_query_params {
> -	our $cgi;
[...]
>  }

> @@ -361,12 +324,12 @@ sub evaluate_query_params {
>  # now read PATH_INFO and update the parameter list for missing parameters
>  sub evaluate_path_info {
[...]
>  }

>  sub evaluate_and_validate_params {
[...]
>  }

Shouldn't evaluate_query_params(), evaluate_path_info(), and the
subroutine that ties them together evaluate_and_validate_params() be
in Gitweb::Request too?

>  
>  sub evaluate_git_dir {
[....]
>  }

Ditto with evaluate_git_dir()?

BTW. as I said in comment to previous patch, vriables such as $project
should be put in Gitweb::Request in my opinion, not in Gitweb::Config.
Perhaps they are, but it is not obvious from this patch.

>  
>  our (@snapshot_fmts, $git_avatar);
> @@ -643,32 +605,32 @@ set_message(\&handle_errors_html);
>  
>  # dispatch
>  sub dispatch {
[...]
>  }
>  
>  sub run_request {

Those two subroutines should not, I guess, be put in Gitweb::Request.
They would be in catch-all Gitweb module, I guess, or perhaps in the
later post-GSoC future in Gitweb::Dispatch or something.

> @@ -689,7 +651,6 @@ sub run_request {
>  our $is_last_request = sub { 1 };
>  our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
>  our $CGI = 'CGI';
> -our $cgi;
>  sub evaluate_argv {
>  	return unless (@ARGV);

Ah, so $CGI is left in gitweb.perl, $cgi is moved to Gitweb::Request.
  
[cut more than half of patch, which sould not be needed with exporting
 variables and not using fully qualified variable names]

> diff --git a/gitweb/lib/Gitweb/Request.pm b/gitweb/lib/Gitweb/Request.pm
> new file mode 100644
> index 0000000..91cc492
> --- /dev/null
> +++ b/gitweb/lib/Gitweb/Request.pm
> @@ -0,0 +1,58 @@
> +#!/usr/bin/perl
> +#
> +# Gitweb::Request -- gitweb request(cgi) package
> +#
> +# This program is licensed under the GPLv2

I don't remember what is git policy on copyright statements, and on
GPLv2 vs GPLv2+...

> +
> +package Gitweb::Request;
> +
> +use strict;
> +
> +BEGIN {
> +	use Exporter();
> +
> +	@Gitweb::Request::ISA = qw(Exporter);	
> +	@Gitweb::Request::EXPORT = qw();
> +}

Same comment as for previous patch.

   use Exporter qw(import);
   our @EXPORT = qw($cgi, $my_url, $my_uri, $base_url, ...);

BTW with exporting variables you can easily see here that
Gitweb::Request does not use any variable from Gitweb::Config.

> +
> +our ($cgi, $my_url, $my_uri, $base_url, $path_info, $home_link);
> +our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
> +     $hash_parent_base, @extra_options, $page, $git_dir);
> +our ($searchtype, $search_use_regexp, $searchtext, $search_regexp);
> +
> +sub evaluate_uri {
[...]
> +}

Straightforward code movement.  But see comment above on which
subroutines I feel should be also put in Gitweb::Request.

-- 
Jakub Narebski
Poland
