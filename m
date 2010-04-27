From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: Improve installation instructions in
	gitweb/INSTALL
Date: Tue, 27 Apr 2010 22:40:18 +0200
Message-ID: <20100427203915.31579.6316.stgit@localhost.localdomain>
References: <20100427203341.31445.82930.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 22:41:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6raf-000272-UI
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449Ab0D0Ukn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:40:43 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:49823 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab0D0Ukm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:40:42 -0400
Received: by qyk9 with SMTP id 9so19962577qyk.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=/qGGOUYaTxZmX3TEss8dgotXuufFohXu0RKiR9rHmI8=;
        b=pNn/Ow3HiPI0B0mbGLKoe4PDZWtx+HjQbsGTeeH/RsE3mnmoM8Y2cinXsbZ1e+8Eob
         7isFZykwvXfvr7lZFGQ5JQRCiGLF9C0VrV6NMi1urSyzDHp4PhNOG2BgEYVBGmr693Sd
         v6gfXNhuGebKWOPQ89okPUhj+daxc/Zyr+4Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=elk0nValPMDhYHkjxE6hOvS663TDSYmwCAbSnd0gdhEqi1vfDSIOLCUkIULS/o29gd
         Hgqfb0VpMwKg2ka+uxZphJ4VXuqUGsrhm3J7s3/iS3PyqRG8REYPUXlsU23elyGxMo/K
         +P51sUMhs71ChQNXK0BJTrnIjbLSFHk4EyjXU=
Received: by 10.224.17.196 with SMTP id t4mr1929655qaa.254.1272400841157;
        Tue, 27 Apr 2010 13:40:41 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.8])
        by mx.google.com with ESMTPS id 5sm8794405qwg.10.2010.04.27.13.40.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 13:40:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3RKeICf031620;
	Tue, 27 Apr 2010 22:40:28 +0200
In-Reply-To: <20100427203341.31445.82930.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145951>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Fixed spaces instead of tab in one place.

 gitweb/INSTALL |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index cbdc136..94ec05f 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -7,7 +7,9 @@ gitweb.css, git-logo.png and git-favicon.png) to their destination.
 For example if git was (or is) installed with /usr prefix, you can do
 
 	$ make prefix=/usr gitweb             ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
+	# cp gitweb/*.cgi gitweb/*.css \
+	     gitweb/*.js  gitweb/*.png \
+	     /var/www/cgi-bin/                ;# as root
 
 Alternatively you can use autoconf generated ./configure script to
 set up path to git binaries (via config.mak.autogen), so you can write
@@ -16,7 +18,9 @@ instead
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=/usr          ;# as yourself
 	$ make gitweb                        ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
+	# cp gitweb/*.cgi gitweb/*.css \
+	     gitweb/*.js  gitweb/*.png \
+	     /var/www/cgi-bin/               ;# as root
 
 The above example assumes that your web server is configured to run
 [executable] files in /var/www/cgi-bin/ as server scripts (as CGI
@@ -74,7 +78,7 @@ file for gitweb (in gitweb/README).
 Build example
 ~~~~~~~~~~~~~
 
-- To install gitweb to /var/www/cgi-bin/gitweb/ when git wrapper
+- To install gitweb to /var/www/cgi-bin/gitweb/, when git wrapper
   is installed at /usr/local/bin/git and the repositories (projects)
   we want to display are under /home/local/scm, you can do
 
@@ -86,10 +90,16 @@ Build example
 	     bindir=/usr/local/bin \
 	     gitweb
 
-	cp -fv ~/git/gitweb/gitweb.{cgi,js,css} \
-	       ~/git/gitweb/git-{favicon,logo}.png \
+	cp -fv gitweb/gitweb.{cgi,js,css} \
+	       gitweb/git-{favicon,logo}.png \
 	     /var/www/cgi-bin/gitweb/
 
+  The above instruction assumes that you didn't use JavaScript
+  minimizer or CSS minimizer.  If you use minimizers you need
+  to modify above instructions accordingly, which means pointing
+  GITWEB_CSS and GITWEB_JS to minified versions, and copying 
+  minified files.
+
 
 Gitweb config file
 ------------------
