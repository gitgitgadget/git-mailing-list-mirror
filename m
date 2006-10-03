From: "Alan Chandler" <alan@chandlerfamily.org.uk>
Subject: [PATCH] Update the gitweb/README file to include setting the GITWEB_CONFIG environment
Date: Tue,  3 Oct 2006 22:48:46 +0100
Message-ID: <11599121262709-git-send-email-alan@chandlerfamily.org.uk>
Cc: git@vger.kernel.org, Alan Chandler <alan@chandlerfamily.org.uk>
X-From: git-owner@vger.kernel.org Tue Oct 03 23:49:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUs8J-0007BK-GZ
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 23:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbWJCVst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 17:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbWJCVst
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 17:48:49 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:31159
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1030570AbWJCVss (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 17:48:48 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with smtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GUs85-0003aW-Iw; Tue, 03 Oct 2006 22:48:46 +0100
Received: by kanger.home (sSMTP sendmail emulation); Tue,  3 Oct 2006 22:48:46 +0100
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28308>

From: Alan Chandler <alan@chandlerfamily.org.uk>

Signed-off-by: Alan Chandler <alan@chandlerfamily.org.uk>
---
 gitweb/README |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 61c7ab5..099cfae 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -43,6 +43,7 @@ repositories, you can configure apache l
     DocumentRoot /pub/git
     RewriteEngine on
     RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
+    SetEnv	GITWEB_CONFIG	/etc/gitweb.conf
 </VirtualHost>
 
 The above configuration expects your public repositories to live under
@@ -51,6 +52,12 @@ both as cloneable GIT URL and as browsea
 If you then start your git-daemon with --base-path=/pub/git --export-all
 then you can even use the git:// URL with exactly the same path.
 
+Setting the environment variable GITWEB_CONFIG will tell gitweb to use
+the named file (ie in this example /etc/gitweb.conf) as a
+configuration for gitweb.  Perl variables defined in here will
+override the defaults given at the head of the gitweb.perl (or
+gitweb.cgi).  Look at the comments in that file for information on
+which variables and what they mean.
 
 
 Originally written by:
-- 
1.4.2.1
