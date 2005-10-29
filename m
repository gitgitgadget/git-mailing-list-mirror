From: c.shoemaker@cox.net
Subject: [PATCH] Actually, git-reset arguments are mutually exclusive.
Date: Sat, 29 Oct 2005 00:16:43 -0400
Message-ID: <E1EVi95-0002Ts-Aj@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:20:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi9q-0003wp-0T
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVJ2EQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVJ2EQp
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:16:45 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:5833 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751059AbVJ2EQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:16:44 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041641.THQR28234.eastrmmtao05.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:16:41 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi95-0002Ts-Aj
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:16:43 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10788>

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 git-reset.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7f1c4f07629a1e4328341415e9949d333c718cc8
diff --git a/git-reset.sh b/git-reset.sh
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -2,7 +2,7 @@
 . git-sh-setup || die "Not a git archive"
 
 usage () {
-	die 'Usage: git reset [--mixed] [--soft] [--hard]  [<commit-ish>]'
+	die 'Usage: git reset [--mixed | --soft | --hard]  [<commit-ish>]'
 }
 
 tmp=/var/tmp/reset.$$
