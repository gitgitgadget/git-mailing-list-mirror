From: c.shoemaker@cox.net
Subject: [PATCH] update usage string for git-commit.sh
Date: Sat, 29 Oct 2005 00:16:12 -0400
Message-ID: <E1EVi8a-0002Tb-1r@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:19:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi9C-0003wp-36
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVJ2EQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVJ2EQO
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:16:14 -0400
Received: from eastrmmtao01.cox.net ([68.230.240.38]:24969 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750985AbVJ2EQN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:16:13 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041542.RPVU13165.eastrmmtao01.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:15:42 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi8a-0002Tb-1r
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:16:12 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10784>

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

5cc74c9e41a5458e25917e16f01000faae8f4b13
diff --git a/git-commit.sh b/git-commit.sh
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -6,7 +6,7 @@
 . git-sh-setup || die "Not a git archive"
 
 usage () {
-	die 'git commit [-a] [-v | --no-verify]  [-m <message>] [-F <logfile>] [(-C|-c) <commit>] [<path>...]'
+	die 'git commit [-a] [-s] [-v | --no-verify]  [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [<path>...]'
 }
 
 all= logfile= use_commit= no_edit= log_given= log_message= verify=t signoff=
