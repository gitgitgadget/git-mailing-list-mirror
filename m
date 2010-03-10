From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH] gitweb readme fixed regarding per user project root repository
Date: Wed, 10 Mar 2010 19:55:29 +0100
Message-ID: <1268247329-8174-1-git-send-email-sylvain@abstraction.fr>
References: <1267488297-10415-1-git-send-email-sylvain@abstraction.fr>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 19:55:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpR4M-00017a-W4
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 19:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675Ab0CJSzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 13:55:42 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:53869 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab0CJSzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 13:55:41 -0500
Received: by bwz1 with SMTP id 1so5258405bwz.21
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 10:55:39 -0800 (PST)
Received: by 10.204.146.148 with SMTP id h20mr227564bkv.185.1268247338846;
        Wed, 10 Mar 2010 10:55:38 -0800 (PST)
Received: from localhost.localdomain (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id g18sm28760057bkw.7.2010.03.10.10.55.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 10:55:38 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267488297-10415-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141911>

the RewriteRule involving the '+' character is not working as it is
replaced by a space in urls when you click on links.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/README |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index ad6a04c..2acf595 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -347,18 +347,18 @@ something like the following in your gitweb.conf (or gitweb_config.perl) file:
   $home_link = "/";
 
 
-Webserver configuration with multiple projects' root
+Webserver configuration with multiple projects roots
 ----------------------------------------------------
 
-If you want to use gitweb with several project roots you can edit your apache
-virtual host and gitweb.conf configuration files like this :
+If you want to use gitweb with several projects roots then you can edit your
+apache virtual host and gitweb.conf configuration files like this :
 
 virtual host configuration :
 
 <VirtualHost *:80>
     ServerName			git.example.org
     DocumentRoot		/pub/git
-    SetEnv				GITWEB_CONFIG	/etc/gitweb.conf
+    SetEnv			GITWEB_CONFIG	/etc/gitweb.conf
 
     # turning on mod rewrite
     RewriteEngine on
@@ -370,8 +370,8 @@ virtual host configuration :
     # http://git.example.org/~<user>/
     RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
-    # http://git.example.org/+<user>/
-    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+    # http://git.example.org/u/<user>/
+    #RewriteRule ^/u/([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
     # http://git.example.org/user/<user>/
     #RewriteRule ^/user/([^\/]+)/(gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
-- 
1.7.0
