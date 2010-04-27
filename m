From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2] gitweb: Improve installation instructions in gitweb/INSTALL
Date: Tue, 27 Apr 2010 22:47:24 +0200
Message-ID: <201004272247.27566.jnareb@gmail.com>
References: <20100427203341.31445.82930.stgit@localhost.localdomain> <4BD74BAB.1040401@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:48:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rhO-0005xF-SK
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab0D0Urj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 16:47:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:11132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab0D0Uri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:47:38 -0400
Received: by fg-out-1718.google.com with SMTP id d23so3367911fga.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FYUYZxK3sRL8I5Y0BnaWLSeV/AvfKT8zfr5aKOWN8nM=;
        b=rgaA/h07NliBSfIEJIojsUqzsYBCMLQgiDtoRnthT+ADCKQVRFW08COrn+cxlSXYwd
         FQpsr7kzTkvh3nigvEs9t6Jb6oQUurPQSjOE+/gLrF2SC0zg0XpIY/wIkEouI7cGciWv
         1xvCQYTcczYt4Cw/+wAdUhCy60ze8GrCkG05I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oWROXdvQoxoxkcRgndmzCjhJdZJlkVF+KGJ9pNejigRg4bx/pdUb9+gtxA/ntYAs5u
         q3p5vhTU460YuOSbtnaQrZgZBUauH7ksUC9TMOBy/PQvs8vs650r2UUCe7rjBUp7ePUh
         1TMBkh1cojeTpXPT65CsUCuG7n9486Gnetm3Y=
Received: by 10.86.124.8 with SMTP id w8mr6102276fgc.8.1272401256840;
        Tue, 27 Apr 2010 13:47:36 -0700 (PDT)
Received: from [192.168.1.13] (abvy105.neoplus.adsl.tpnet.pl [83.8.222.105])
        by mx.google.com with ESMTPS id p17sm11675474fka.16.2010.04.27.13.47.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 13:47:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BD74BAB.1040401@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145952>

Dnia wtorek 27. kwietnia 2010 22:40, Mark Rada napisa=C5=82:
> On 10-04-27 4:33 PM, Jakub Narebski wrote:
> > +  The above instruction assumes that you didn't use JavaScript
> > +  minimizer or CSS minimizer.  If you use minimizers you need
> > +  to modify above instructions accordingly, which means pointing
> > +  GITWEB_CSS and GITWEB_JS to minified versions, and copying=20
> > +  minified files.
> > +
> > =20
>=20
> Hmm, I believe I already put a message like this in the INSTALL
> file. Perhaps that message should be updated, too, or removed in
> place of your patch.
>=20
> Looks like:
>  67=20
>  68 - You can optionally generate minified versions of gitweb.js and =
gitweb.css
>  69   by defining the JSMIN and CSSMIN build configuration variables.=
 By default
>  70   the non-minified versions will be used. NOTE: if you enable thi=
s option,
>  71   substitute gitweb.min.js and gitweb.min.css for all uses of git=
web.js and
>  72   gitweb.css in the help files.

How about this then:

-- >8 --
=46rom: Jakub Narebski <jnareb@gmail.com>
Date: Tue, 27 Apr 2010 22:45:19 +0200
Subject: [PATCHv2] gitweb: Improve installation instructions in gitweb/=
INSTALL

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/INSTALL |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index cbdc136..1bfd9aa 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -7,7 +7,9 @@ gitweb.css, git-logo.png and git-favicon.png) to their =
destination.
 For example if git was (or is) installed with /usr prefix, you can do
=20
 	$ make prefix=3D/usr gitweb             ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
+	# cp gitweb/*.cgi gitweb/*.css \
+	     gitweb/*.js  gitweb/*.png \
+	     /var/www/cgi-bin/                ;# as root
=20
 Alternatively you can use autoconf generated ./configure script to
 set up path to git binaries (via config.mak.autogen), so you can write
@@ -16,7 +18,9 @@ instead
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=3D/usr          ;# as yourself
 	$ make gitweb                        ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
+	# cp gitweb/*.cgi gitweb/*.css \
+	     gitweb/*.js  gitweb/*.png \
+	     /var/www/cgi-bin/               ;# as root
=20
 The above example assumes that your web server is configured to run
 [executable] files in /var/www/cgi-bin/ as server scripts (as CGI
@@ -74,9 +78,10 @@ file for gitweb (in gitweb/README).
 Build example
 ~~~~~~~~~~~~~
=20
-- To install gitweb to /var/www/cgi-bin/gitweb/ when git wrapper
-  is installed at /usr/local/bin/git and the repositories (projects)
-  we want to display are under /home/local/scm, you can do
+- To install gitweb to /var/www/cgi-bin/gitweb/, when git wrapper
+  is installed at /usr/local/bin/git, the repositories (projects)
+  we want to display are under /home/local/scm, and you do not use
+  minifiers, you can do
=20
 	make GITWEB_PROJECTROOT=3D"/home/local/scm" \
 	     GITWEB_JS=3D"/gitweb/gitweb.js" \
@@ -86,8 +91,8 @@ Build example
 	     bindir=3D/usr/local/bin \
 	     gitweb
=20
-	cp -fv ~/git/gitweb/gitweb.{cgi,js,css} \
-	       ~/git/gitweb/git-{favicon,logo}.png \
+	cp -fv gitweb/gitweb.{cgi,js,css} \
+	       gitweb/git-{favicon,logo}.png \
 	     /var/www/cgi-bin/gitweb/
=20
=20
--=20
1.7.0.1
