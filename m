From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Patch 001/GSoC] Move static files into subdir
Date: Sun, 09 May 2010 15:13:26 -0700 (PDT)
Message-ID: <m3bpcoenci.fsf@localhost.localdomain>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 00:13:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBEkg-0008Tj-U4
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 00:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab0EIWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 18:13:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56736 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab0EIWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 18:13:28 -0400
Received: by fxm10 with SMTP id 10so1904192fxm.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NRpAeO1e6uBXxekP9BE1TbtrAuaZ9lMO0KNzMmigpwU=;
        b=uwrDR9OjT4cvEcsYywbQezDz9qDIOLQ0T1J6CnwqbYxJJEJ4V9kQOUoym8rfqHCQok
         uKuGZIVOe0UC/3dC9/0losaDVdgHlDLTCwHSoCWL1RoT0nvEC7PFSuIomqtSNaY9uBtk
         cMalLhjPfnJ+3cyRNKabYIyC2YhLn+rv0p9m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tdeOzAGYkuEd43Lr5mnQe8ril64RIWLlGXOzi/PaAIguNf/HmCB8pCj7NC8DEOYczc
         7Xi2pHJS8Pb1FS7MFevTakkz9QyUqZQknvxb7lVRG1DVab6EnBRchOwm7xTVlmnOGbtN
         WLK4ULBH3dAmM7u3qpiVRB48VXmyJ0TVxBom4=
Received: by 10.223.56.27 with SMTP id w27mr3396052fag.37.1273443206938;
        Sun, 09 May 2010 15:13:26 -0700 (PDT)
Received: from localhost.localdomain (abwi51.neoplus.adsl.tpnet.pl [83.8.232.51])
        by mx.google.com with ESMTPS id g10sm18331862fai.12.2010.05.09.15.13.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 15:13:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o49MCp2p022170;
	Mon, 10 May 2010 00:13:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o49MCUSw022149;
	Mon, 10 May 2010 00:12:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146751>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> Hi,
> 
> It's been a while I mail to this list since I got GSoC. But I have
> been in contact with Christian and Petr (mentors) everyday. As I am
> having my vacation, I decided to statrt the project earlier itself.
> Here's is my first patch in the process of my GSoC.
> 
> One of my project goals is to split gitweb. This patch initiates the splitting.
> 
> PATCH:
> 
> From e25db0b62b481e029354ad33af8f0615a8353633 Mon Sep 17 00:00:00 2001
> From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> Date: Wed, 5 May 2010 21:44:57 -0700
> Subject: [PATCH] Gitweb: Move all static files into a seperate directory

Almost all right.  Please read Documentation/SubmittingChanges first.

There are two ways of submitting a patch with some comment about patch
that should not be put in commit message.

The first is to put first line (summary) of a commit message, in your
case
  [PATCH GSoC] gitweb: Move all static files into a seperate directory
in *email* subject, and put comments about patch itself between "---\n"
line and diffstat (see also below).

The second, used for example if the patch is byproduct of an email, is
to write comment in the email, and add patch itself after a separator.
Commonly used separator is 'scissors' line (see git-mailinfo(1)), e.g.
"-- >8 --\n" line.  You need to write 'Subject:' line _only_ if the
subject of an email is different.

The first is more commonly used, as you can see by looking at emails
marked with '[PATCH]' in git mailing list; you can use mailing list
archive like MARC or GMane, or GMane NNTP (Usenet) interface reading
it with news reader.
 
> This commit creates a new subdirectory called 'static' in gitweb
> which will contain all the static files required by gitweb.cgi
> while executing. By doing so, the gitweb source will be more
> readable and maintainable.

A minor issue: commit messages are usually written in imperative;
also I'd rather avoid marketspeak-sounding "will be":

  Create a new subdirectory called 'static' in gitweb/, and move
  all static files required by gitweb.cgi when running, which means
  styles, images and Javascript code. This should make gitweb more
  readable and easier to maintain.


I also wonder how other project solve this issue. Well, Gitalist
uses 'root/static/'...

> 
> Also changed INSTALL, README, Makefile and test files
> according to this change.

A minor issue: "Also changed" doesn't look like correct English
grammar for me.  I am not a native English speaker either, but I would
personally write:

  Update t/gitweb-lib.sh to reflect this change.  The default is
  now to install static files also in 'static' subdirectory in target
  directory: update gitweb's INSTALL, README and Makefile accordingly.


Note that favicon.ico should be installed in top directory, but I
think it doesn't really matter where is git-favicon.png as long as
'<link rel="shortcut icon" ... />' points in correct place...

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---
>  gitweb/INSTALL                      |   20 ++++++++++----------
>  gitweb/Makefile                     |   20 ++++++++++----------
>  gitweb/README                       |    8 ++++----
>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
>  gitweb/{ => static}/gitweb.css      |    0
>  gitweb/{ => static}/gitweb.js       |    0
>  t/gitweb-lib.sh                     |    6 +++---
>  8 files changed, 27 insertions(+), 27 deletions(-)
>  rename gitweb/{ => static}/git-favicon.png (100%)
>  rename gitweb/{ => static}/git-logo.png (100%)
>  rename gitweb/{ => static}/gitweb.css (100%)
>  rename gitweb/{ => static}/gitweb.js (100%)

You might need to update also git-instaweb.sh and generating
git-instaweb in main Makefile.

> 
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index cbdc136..60c25ff 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -7,7 +7,8 @@ gitweb.css, git-logo.png and git-favicon.png) to their
> destination.
>  For example if git was (or is) installed with /usr prefix, you can do
> 
>  	$ make prefix=/usr gitweb             ;# as yourself
> -	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
> +	# cp gitweb/gitweb.cgi /var/www/cgi-bin/   ;# as root
> +	# cp -r gitweb/static  /var/www/cgi-bin/   ;# as root

This assumes that ones 'cp' support -r / --recursive option.
How portable is this?

But I think this might be all right in an example.

> @@ -79,17 +81,15 @@ Build example
>    we want to display are under /home/local/scm, you can do
> 
>  	make GITWEB_PROJECTROOT="/home/local/scm" \
> -	     GITWEB_JS="/gitweb/gitweb.js" \
> -	     GITWEB_CSS="/gitweb/gitweb.css" \
> -	     GITWEB_LOGO="/gitweb/git-logo.png" \
> -	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
> +	     GITWEB_JS="/gitweb/static/gitweb.js" \
> +	     GITWEB_CSS="/gitweb/static/gitweb.css" \
> +	     GITWEB_LOGO="/gitweb/static/git-logo.png" \
> +	     GITWEB_FAVICON="/gitweb/static/git-favicon.png" \
>  	     bindir=/usr/local/bin \
>  	     gitweb
> 
> -	cp -fv ~/git/gitweb/gitweb.{cgi,js,css} \
> -	       ~/git/gitweb/git-{favicon,logo}.png \
> -	     /var/www/cgi-bin/gitweb/
> -
> +	cp -fv gitweb/gitweb.cgi /var/www/cgi-bin/gitweb/
> +	cp -r gitweb/static /var/www/cgi-bin/gitweb/

Sidenote (something to think about in the future): we might want to
put static files in /var/www/html/gitweb/ (but not in 
/var/www/html/gitweb/static/), outside of where gitweb.cgi is put.
 
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index f2e1d92..c0d5da3 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -26,10 +26,10 @@ GITWEB_STRICT_EXPORT =
>  GITWEB_BASE_URL =
>  GITWEB_LIST =
>  GITWEB_HOMETEXT = indextext.html
> -GITWEB_CSS = gitweb.css
> -GITWEB_LOGO = git-logo.png
> -GITWEB_FAVICON = git-favicon.png
> -GITWEB_JS = gitweb.js
> +GITWEB_CSS = static/gitweb.css
> +GITWEB_LOGO = static/git-logo.png
> +GITWEB_FAVICON = static/git-favicon.png
> +GITWEB_JS = static/gitweb.js
>  GITWEB_SITE_HEADER =
>  GITWEB_SITE_FOOTER =
> 
> @@ -81,16 +81,16 @@ endif
>  all:: gitweb.cgi
> 
>  ifdef JSMIN
> -GITWEB_JS = gitweb.min.js
> -all:: gitweb.min.js
> -gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
> +GITWEB_JS = static/gitweb.min.js
> +all:: static/gitweb.min.js
> +static/gitweb.min.js: static/gitweb.js GITWEB-BUILD-OPTIONS
>  	$(QUIET_GEN)$(JSMIN) <$< >$@
>  endif
> 
>  ifdef CSSMIN
> -GITWEB_CSS = gitweb.min.css
> -all:: gitweb.min.css
> -gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
> +GITWEB_CSS = static/gitweb.min.css
> +all:: static/gitweb.min.css
> +static/gitweb.min.css: static/gitweb.css GITWEB-BUILD-OPTIONS
>  	$(QUIET_GEN)$(CSSMIN) <$ >$@
>  endif

You need to update 'clean' target in gitweb/Makefile too.
 
> diff --git a/gitweb/README b/gitweb/README
> index 71742b3..eeac204 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -80,23 +80,23 @@ You can specify the following configuration
> variables when building GIT:
>     Points to the location where you put gitweb.css on your web server
>     (or to be more generic, the URI of gitweb stylesheet).  Relative to the
>     base URI of gitweb.  Note that you can setup multiple stylesheets from
> -   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
> +   the gitweb config file.  [Default: static/gitweb.css (or
> gitweb.min.css if the
>     CSSMIN variable is defined / CSS minifier is used)]

Word wrapped patch. It should read:

  @@ -80,23 +80,23 @@ You can specify the following configuration
  variables when building GIT:
      Points to the location where you put gitweb.css on your web server
      (or to be more generic, the URI of gitweb stylesheet).  Relative to the
      base URI of gitweb.  Note that you can setup multiple stylesheets from
  -   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
  +   the gitweb config file.  [Default: static/gitweb.css (or gitweb.min.css if the
      CSSMIN variable is defined / CSS minifier is used)]

You need to turn off line wrapping in your email client when sending a
patch.  Here it is minor issue.

Also you forgot to update gitweb.min.css to static/gitweb.min.css...
in which case you should probably rewrap this line to:

  @@ -80,24 +80,24 @@ You can specify the following configuration
  variables when building GIT:
      Points to the location where you put gitweb.css on your web server
      (or to be more generic, the URI of gitweb stylesheet).  Relative to the
      base URI of gitweb.  Note that you can setup multiple stylesheets from
  -   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
  -   CSSMIN variable is defined / CSS minifier is used)]
  +   the gitweb config file.  [Default: static/gitweb.css (or static/gitweb.min.css
  +   if the CSSMIN variable is defined / CSS minifier is used)]

[...]

> -   Relative to base URI of gitweb.  [Default: gitweb.js (or gitweb.min.js
> +   Relative to base URI of gitweb.  [Default: static/gitweb.js (or
> gitweb.min.js

Word-wrapped.

> diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
> similarity index 100%
> rename from gitweb/gitweb.css
> rename to gitweb/static/gitweb.css

Good!

[...]
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

Thanks for thinking about this... although it doesn't really matter,
as it is not served to a web browser.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
