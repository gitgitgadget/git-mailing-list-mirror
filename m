From: Veres Lajos <vlajos@gmail.com>
Subject: [PATCH] misspellings fixes by
 https://github.com/vlajos/misspell_fixer
Date: Thu, 20 Jun 2013 00:37:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306200036230.8850@citymarket.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 00:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpR0B-0000ps-I7
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 00:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935294Ab3FSWhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 18:37:13 -0400
Received: from citymarket.hu ([188.227.225.139]:33238 "EHLO citymarket.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935252Ab3FSWhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 18:37:12 -0400
Received: from citymarket.hu (localhost [127.0.0.1])
	by citymarket.hu (Postfix) with ESMTP id 72D0C102118
	for <git@vger.kernel.org>; Thu, 20 Jun 2013 00:37:09 +0200 (CEST)
Received: by citymarket.hu (Postfix, from userid 1000)
	id 71EAB1023F1; Thu, 20 Jun 2013 00:37:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by citymarket.hu (Postfix) with ESMTP id 6AB6F102118
	for <git@vger.kernel.org>; Thu, 20 Jun 2013 00:37:09 +0200 (CEST)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228432>


Signed-off-by: Veres Lajos <vlajos@gmail.com>
---
 git-p4.py        |    2 +-
 git-svn.perl     |    2 +-
 t/t7600-merge.sh |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 911bbce..88fcf23 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3168,7 +3168,7 @@ class P4Rebase(Command):
         if os.system("git update-index --refresh") != 0:
             die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up-to-date or stash away all your changes with git stash.");
         if len(read_pipe("git diff-index HEAD --")) > 0:
-            die("You have uncommited changes. Please commit them before rebasing or stash them away with git stash.");
+            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");

         [upstream, settings] = findUpstreamBranchPoint()
         if len(upstream) == 0:
diff --git a/git-svn.perl b/git-svn.perl
index d070de0..4e8275f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1246,7 +1246,7 @@ sub cmd_rebase {
 		return;
 	}
 	if (command(qw/diff-index HEAD --/)) {
-		print STDERR "Cannot rebase with uncommited changes:\n";
+		print STDERR "Cannot rebase with uncommitted changes:\n";
 		command_noisy('status');
 		exit 1;
 	}
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2f70433..460d8eb 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -316,7 +316,7 @@ test_expect_success 'merge c1 with c2 (squash)' '

 test_debug 'git log --graph --decorate --oneline --all'

-test_expect_success 'unsuccesful merge of c1 with c2 (squash, ff-only)' '
+test_expect_success 'unsuccessful merge of c1 with c2 (squash, ff-only)' '
 	git reset --hard c1 &&
 	test_must_fail git merge --squash --ff-only c2
 '
-- 
1.7.10.4
