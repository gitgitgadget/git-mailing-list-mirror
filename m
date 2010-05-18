From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 GSoC] gitweb: Move static files into seperate  subdirectory
Date: Tue, 18 May 2010 02:06:05 +0200
Message-ID: <201005180206.07301.jnareb@gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> <201005142325.04747.jnareb@gmail.com> <AANLkTine2dUMI6zrbJzvoyqRbV5phLhjM1zSYvJ-BRek@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 02:04:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEAIb-0004vm-6o
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 02:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab0ERAEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 20:04:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51273 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab0ERAEe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 20:04:34 -0400
Received: by fxm10 with SMTP id 10so477994fxm.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Et/WgODp2uMhfCVIkYURr4BSZToDM82ukUUlKAHdhvo=;
        b=UfcnLOfuXbcclimdf5g9zJKhnDRze/KvpivvZ7LAVQ5N1/yqbHAOrK/NodeSN10zuk
         zUoJvEVVkzw2Wei0KkHLFJgyyzrYL2VT6ZoAlEtBJuXFnEltCSYIDo2vC2Ja1EPk4RsO
         Wm4MEBaZzBViz9MyNmsGGzyWAtLsGbxm8KPsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ns0AOI+Nifczyq061T4w+aeEFW9P/5ZOY08B86nxYGcr14xuKgfWbL68ZD5+YxpyD8
         wQs03Tr/QHYYiK8OptAuk0LzAUkRwRQWgvz9W+R4QQbBpi0O+Si8xX4SGI7RPl+QVCuE
         kb77LJInYykTXwwT1xRpiXD++ccV/R9YWNtYs=
Received: by 10.223.92.144 with SMTP id r16mr7165056fam.62.1274141071905;
        Mon, 17 May 2010 17:04:31 -0700 (PDT)
Received: from [192.168.1.13] (abwi27.neoplus.adsl.tpnet.pl [83.8.232.27])
        by mx.google.com with ESMTPS id 7sm28154685far.6.2010.05.17.17.04.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 May 2010 17:04:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTine2dUMI6zrbJzvoyqRbV5phLhjM1zSYvJ-BRek@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147267>

On Sat, 15 May 2010, Pavan Kumar Sunkara wrote:

> Here's the patch as an attachment.
>
> The file is not whitespace damaged. That is a problem with my mail client
> 
> PFA the patch.

If you cannot use ordinary email client configured to send email via SMTPS
(ports 465 or 587), or via git-send-email, you should consider attaching
patches (perhaps in addition to having them inline) as file with *.txt
extension (to force to use 'text/plain' mimetype, 8bit, no transfer
encoding).

-- >8 --
> From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Subject: [PATCH 4/5] gitweb: Move static files into seperate subdirectory
> 
> Create a new subdirectory called 'static' in gitweb/, and move
> all static files required by gitweb.cgi when running, which means
> styles, images and Javascript code. This should make gitweb more
> readable and easier to maintain.
> 
> Update t/gitweb-lib.sh to reflect this change. The install-gitweb
> now also include moving of static files into 'static' subdirectory
> in target directory: update Makefile, gitweb's INSTALL, README and
> Makefile accordingly.
> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Almost Acked-by: Jakub Narebski <jnareb@gmail.com>

You need to use 'install -d' instead of 'mkdir -p' for modified 'install'
target of gitweb/Makefile.

> ---

Here you should mention that you base your patch on 'next', or even better
on which commit / which branch you base your changes on.

See this fragment of Documentation/SubmittingPatches:

  If you are preparing a work based on "next" branch, that is fine, but
  please mark it as such.

>  Makefile                            |   20 ++++++++--------
>  gitweb/INSTALL                      |   19 +++++++--------
>  gitweb/Makefile                     |   41 ++++++++++++++++++----------------
>  gitweb/README                       |   14 ++++++-----
>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
>  gitweb/{ => static}/gitweb.css      |    0
>  gitweb/{ => static}/gitweb.js       |    0
>  t/gitweb-lib.sh                     |    6 ++--
>  9 files changed, 52 insertions(+), 48 deletions(-)
>  rename gitweb/{ => static}/git-favicon.png (100%)
>  rename gitweb/{ => static}/git-logo.png (100%)
>  rename gitweb/{ => static}/gitweb.css (100%)
>  rename gitweb/{ => static}/gitweb.js (100%)

[...]
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index d484d76..8230531 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -2,9 +2,10 @@ GIT web Interface (gitweb) Installation
>  =======================================
>  
>  First you have to generate gitweb.cgi from gitweb.perl using
> -"make gitweb", then copy appropriate files (gitweb.cgi, gitweb.js,
> -gitweb.css, git-logo.png and git-favicon.png) to their destination.
> -For example if git was (or is) installed with /usr prefix, you can do
> +"make gitweb", then "make install-gitweb" will copy appropriate files
> +(gitweb.cgi, gitweb.js, gitweb.css, git-logo.png and git-favicon.png)
> +to their destination. For example if git was (or is) installed with
> +/usr prefix and gitwebdir is /var/www/cgi-bin, you can do
>  
>  	$ make prefix=/usr gitweb                            ;# as yourself
>  	# make gitwebdir=/var/www/cgi-bin install-gitweb     ;# as root

Thanks for noticing of what I missed when updating gitweb/INSTALL in 152d943
(gitweb: Create install target for gitweb in Makefile, 2010-05-01)

> @@ -81,16 +82,14 @@ Build example
>    minifiers, you can do
>  
>  	make GITWEB_PROJECTROOT="/home/local/scm" \
> -	     GITWEB_JS="/gitweb/gitweb.js" \
> -	     GITWEB_CSS="/gitweb/gitweb.css" \
> -	     GITWEB_LOGO="/gitweb/git-logo.png" \
> -	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
> +	     GITWEB_JS="gitweb/static/gitweb.js" \
> +	     GITWEB_CSS="gitweb/static/gitweb.css" \
> +	     GITWEB_LOGO="gitweb/static/git-logo.png" \
> +	     GITWEB_FAVICON="gitweb/static/git-favicon.png" \
>  	     bindir=/usr/local/bin \
>  	     gitweb
>  
> -	cp -fv gitweb/gitweb.{cgi,js,css} \
> -	       gitweb/git-{favicon,logo}.png \
> -	     /var/www/cgi-bin/gitweb/
> +	make gitwebdir=/var/www/cgi-bin/gitweb install-gitweb

Here I am not sure of we should not leave an example how to copy files
manually... but I guess with this form we wouldn't have to update this part
if/when gitweb is split...

> diff --git a/gitweb/Makefile b/gitweb/Makefile

> @@ -16,6 +16,7 @@ gitwebdir ?= /var/www/cgi-bin
>  
>  RM ?= rm -f
>  INSTALL ?= install
> +MKDIR ?= mkdir

Is MKDIR really needed?  The main Makefile doesn't use it.  It is what
"$(INSTALL) -d ..." is for this (the '-d' / '--directory') option would
create each given directory and any missing parent directories).
  
> @@ -54,6 +55,7 @@ PERL_PATH  ?= /usr/bin/perl
>  # Shell quote;
>  bindir_SQ = $(subst ','\'',$(bindir))#'
>  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
> +gitwebfile_SQ = $(subst ','\'',$(gitwebdir)/static)#'
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
>  PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
>  DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'

I would name it gitwebstaticdir_SQ, but admittedly this is a matter of
taste.  It can be named gitwebfile_SQ... although truth to be said it is 
NOT strictly NECESSARY, as "$(gitwebdir_SQ)/static" would work as well.

> @@ -147,12 +149,13 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
>  install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
>  	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> -	$(INSTALL) -m 644 $(GITWEB_FILES)    '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> +	$(MKDIR) -p '$(DESTDIR_SQ)$(gitwebfile_SQ)'
> +	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebfile_SQ)'

Use

  +	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/static'
  +	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebdir_SQ)/static'

instead.

BTW. mkdir doesn't need to support '-p' option. See for example this part of
autoconf documentation:

 - Macro: AS_MKDIR_P (FILENAME)
     Make the directory FILENAME, including intervening directories as
     necessary.  This is equivalent to `mkdir -p FILENAME', except that
     it is portable to older versions of `mkdir' that lack support for
     the `-p' option.

> diff --git a/gitweb/README b/gitweb/README
> index 71742b3..5787260 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -80,24 +80,26 @@ You can specify the following configuration variables when building GIT:
>     Points to the location where you put gitweb.css on your web server
>     (or to be more generic, the URI of gitweb stylesheet).  Relative to the
>     base URI of gitweb.  Note that you can setup multiple stylesheets from
> -   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
> -   CSSMIN variable is defined / CSS minifier is used)]
> +   the gitweb config file.  [Default: static/gitweb.css (or
> +   static/gitweb.min.css if the CSSMIN variable is defined / CSS minifier
> +    is used)]
      ^----------------- stray space character?

> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index 5a734b1..b70b891 100644
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -19,9 +19,9 @@ our \$site_name = '[localhost]';
>  our \$site_header = '';
>  our \$site_footer = '';
>  our \$home_text = 'indextext.html';
> -our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/gitweb.css');
> -our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/git-logo.png';
> -our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/git-favicon.png';
> +our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/static/gitweb.css');
> +our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/static/git-logo.png';
> +our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/static/git-favicon.png';
>  our \$projects_list = '';
>  our \$export_ok = '';
>  our \$strict_export = '';

Thanks for updating that.

-- 
Jakub Narebski
Poland
