From: c.shoemaker@cox.net
Subject: [PATCH] git-push.sh: Retain cuteness, add helpfulness.
Date: Sat, 29 Oct 2005 00:17:17 -0400
Message-ID: <E1EVi9d-0002U0-0k@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:19:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi9y-0003wp-5I
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVJ2ERS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJ2ERS
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:17:18 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:15049 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751093AbVJ2ERS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:17:18 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041715.THST28234.eastrmmtao05.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:17:15 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi9d-0002U0-0k
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:17:17 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10783>

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 git-push.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

a20e79837771edccdfae495983a9538a76c6ada8
diff --git a/git-push.sh b/git-push.sh
--- a/git-push.sh
+++ b/git-push.sh
@@ -33,7 +33,8 @@ do
 done
 case "$#" in
 0)
-	die "Where would you want to push today?" ;;
+	echo "Where would you want to push today?"
+        usage ;;
 esac
 
 . git-parse-remote
