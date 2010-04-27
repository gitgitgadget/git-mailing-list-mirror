From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Improve installation instructions in gitweb/INSTALL
Date: Tue, 27 Apr 2010 22:33:42 +0200
Message-ID: <20100427203341.31445.82930.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 22:34:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rU4-0007Kx-2s
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0D0UeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:34:14 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:65527 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab0D0UeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:34:13 -0400
Received: by ewy20 with SMTP id 20so4543742ewy.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=7h5afBfXFNQMmN/YRREV4WqofcxaYGBL/TK/B4+xSjc=;
        b=hxXucsv8Hz9tUCzcY42Md8eJBIji6bvQRIHtfaVTfKO/0IYuqsRnzk73ctyOZSxeaC
         WphAarct9yWYL5n4jukjNoQF7IHSNM7U7Rhg5Urr1gL6eQSjSQ83tXts2WZeV2+IC1uw
         jp0GjgvfCBi+h3lb0yzUf8txyYA24B/XjqkwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=CcVqkoLAdMmrER1Rng6m7U2/Pqg8zrDtv/4riAgg536L2cV6kBerU/hKpCNmx2Yp2J
         lgB/Re9qjrfPVYTW8GGqoK5zJ3AXBKGaumXeIIJl8Ki761RYQdMNVDPVG+Wg5QtvL+wi
         pCbUwcYujq3PUKbYyw49vLcdOhUjGKYpMcLQk=
Received: by 10.102.16.14 with SMTP id 14mr3487950mup.136.1272400451811;
        Tue, 27 Apr 2010 13:34:11 -0700 (PDT)
Received: from localhost.localdomain (abvy105.neoplus.adsl.tpnet.pl [83.8.222.105])
        by mx.google.com with ESMTPS id g1sm23774663muf.0.2010.04.27.13.34.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 13:34:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3RKXgqh031473;
	Tue, 27 Apr 2010 22:33:55 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145948>



Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/INSTALL |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)


diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index cbdc136..be965d2 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -7,7 +7,9 @@ gitweb.css, git-logo.png and git-favicon.png) to their destination.
 For example if git was (or is) installed with /usr prefix, you can do
 
 	$ make prefix=/usr gitweb             ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
+	# cp gitweb/*.cgi gitweb/*.css \
+       gitweb/*.js  gitweb/*.png \
+       /var/www/cgi-bin/                ;# as root
 
 Alternatively you can use autoconf generated ./configure script to
 set up path to git binaries (via config.mak.autogen), so you can write
@@ -16,7 +18,9 @@ instead
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=/usr          ;# as yourself
 	$ make gitweb                        ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
+	# cp gitweb/*.cgi gitweb/*.css \
+       gitweb/*.js  gitweb/*.png \
+       /var/www/cgi-bin/               ;# as root
 
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
