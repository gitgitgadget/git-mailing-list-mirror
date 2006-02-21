From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Fix typo in git-rebase.sh.
Date: Tue, 21 Feb 2006 12:56:14 -0800
Message-ID: <4844.1140555374@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Feb 21 21:56:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBeYY-0003dT-9c
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 21:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWBUU4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 15:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbWBUU4R
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 15:56:17 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:2730 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932720AbWBUU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 15:56:17 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1LKuFxZ004957
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 12:56:16 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1LKuFZv004955
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 12:56:15 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16551>


s/upsteram/upstream in git-rebase.sh.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

92550b0b04236ec52d6bb573e79fa2b5fac21228
diff --git a/git-rebase.sh b/git-rebase.sh
index 21c3d83..c47aa70 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -71,7 +71,7 @@ esac
 # The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
 upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-    die "invalid upsteram $upstream_name"
+    die "invalid upstream $upstream_name"
 
 # If a hook exists, give it a chance to interrupt
 if test -x "$GIT_DIR/hooks/pre-rebase"
-- 
1.2.2.g972a
