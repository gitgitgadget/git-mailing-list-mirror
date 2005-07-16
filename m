From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Install git-verify-tag-script
Date: Sat, 16 Jul 2005 14:19:24 -0600
Message-ID: <m1y886o65v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 22:19:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtt8V-0002zV-Qq
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 22:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVGPUTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 16:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVGPUTo
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 16:19:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32216 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261565AbVGPUTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 16:19:43 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6GKJOG2020639;
	Sat, 16 Jul 2005 14:19:24 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6GKJOMv020638;
	Sat, 16 Jul 2005 14:19:24 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b4ef59fcedf0855519fc23b58f9ec0c80e78221c
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-reset-script git-add-script git-checkout-script git-clone-script \
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
-	git-branch-script git-parse-remote
+	git-branch-script git-parse-remote git-verify-tag-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
