From: Veres Lajos <vlajos@gmail.com>
Subject: small misspellings fixes
Date: Wed, 19 Jun 2013 01:04:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306190100190.8850@citymarket.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 19 01:04:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up4xB-0005cc-D6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 01:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835Ab3FRXEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 19:04:41 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:36006 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855Ab3FRXEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 19:04:40 -0400
Received: by mail-ee0-f43.google.com with SMTP id l10so2843797eei.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:user-agent:mime-version
         :content-type;
        bh=FNCldrGKa988yV4GWWE5Ii76lVWlsQbgn/Ho+GFNCJc=;
        b=JIWhwRmHNMTqkMMbVFa8+gF7M2tWzWWfERNwbOQCXYZiNuGhFThFDRd4puqyZXK4VU
         gQ89AXrgodQiLNpwZagMAJj/SAY2Pe2qIJ8VBIz55oJ5x20NGsGFzXM21tvKu5bwuwDn
         BFWlS2mP8wFQzvIqN7PtPlg30XsI0fkCr/3YYefYtntva2k6i4rSsfXAduEf3imucSxu
         dsqlDHSG3snm36RlgXVpZudbH/t46cIHNgTaSVz1jaa+4Ce5yW2Cuvk1IxESScEVaLsv
         JDK2eDnE/pwsRRVCNkRr3RkGIGDCHj+yGI30N/z3pfomX5WGPbmq+1yU6lVD3UZpXHl9
         mDxQ==
X-Received: by 10.14.38.14 with SMTP id z14mr79333eea.49.1371596679610;
        Tue, 18 Jun 2013 16:04:39 -0700 (PDT)
Received: from citymarket.hu ([188.227.225.139])
        by mx.google.com with ESMTPSA id m1sm33347915eex.17.2013.06.18.16.04.38
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 16:04:38 -0700 (PDT)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228322>

Hi,

I am trying to convert this pull request:
https://github.com/git/git/pull/42
to a proper patch email
(Sorry If I miss something about the process.)

I found a few trivial misspellings.

Signed-off-by: Veres Lajos <vlajos@gmail.com>
---
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
