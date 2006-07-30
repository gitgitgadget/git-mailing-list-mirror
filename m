From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 12] gitweb: Add "\n" after <br/> in git_page_nav
Date: Sun, 30 Jul 2006 16:14:43 +0200
Message-ID: <200607301614.43476.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 16:14:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7C40-00031n-UP
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 16:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWG3OOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 10:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWG3OOh
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 10:14:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:17687 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932322AbWG3OOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 10:14:36 -0400
Received: by ug-out-1314.google.com with SMTP id m3so372730ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 07:14:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l1BHLH8ae0KfTqOM9KgYPWrObOwVmvReHWit65Tw/Ql/xUxaFcO6xtpNf/XCPJBnvd3m/tmiqHVinvy3aolbK1GUGcTyUS+cwjDrfprE7o9BQmxNNIM3heVE0hQ7J4twskq+wXvmCRi0YXsBtXyGyhmrSAOTNnKRYeGjp3at0qk=
Received: by 10.67.119.13 with SMTP id w13mr1569080ugm;
        Sun, 30 Jul 2006 07:14:35 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k2sm2926808ugf.2006.07.30.07.14.35;
        Sun, 30 Jul 2006 07:14:35 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24457>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 7d52a2c..df152c3 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -416,7 +416,7 @@ sub git_page_nav {
 					 : $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$_$arg{$_}")}, "$_")
 				 }
 		 @navs);
-	print "<br/>$extra<br/>\n" .
+	print "<br/>\n$extra<br/>\n" .
 	      "</div>\n";
 }
 
-- 
1.4.0
