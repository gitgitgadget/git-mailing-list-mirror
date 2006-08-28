From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Do not remove signoff lines in git_print_simplified_log
Date: Mon, 28 Aug 2006 14:48:11 +0200
Message-ID: <11567692953763-git-send-email-jnareb@gmail.com>
References: <11567692943154-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 14:48:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgXQ-0005XD-Qj
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 14:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWH1MsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 08:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWH1MsW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 08:48:22 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:7858 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750716AbWH1MsV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 08:48:21 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SCl2w5031909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 14:47:02 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SCmFfw017614;
	Mon, 28 Aug 2006 14:48:15 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SCmFpi017613;
	Mon, 28 Aug 2006 14:48:15 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11567692943154-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26150>

Remove '-remove_signoff => 1' option to git_print_log call in the
git_print_simplified_log subroutine.  This means that in "log" and
"commitdiff" views (git_log and git_commitdiff subroutines) signoff
lines will be shown.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e318f50..c2dcc6c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1419,7 +1419,6 @@ sub git_print_simplified_log {
 
 	git_print_log($log,
 		-final_empty_line=> 1,
-		-remove_signoff => 1,
 		-remove_title => $remove_title);
 }
 
-- 
1.4.1.1
