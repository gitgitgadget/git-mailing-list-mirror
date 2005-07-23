From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 7/9] Install git-verify-tag-script
Date: Fri, 22 Jul 2005 17:30:02 -0700
Message-ID: <7v8xzybbzp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 02:32:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7vw-0000qH-Qu
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 02:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVGWAbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 20:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVGWAa5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 20:30:57 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26840 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262252AbVGWAaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 20:30:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723003001.KFU1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 20:30:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>
Date: 1121545164 -0600

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

858d9f99d6ff1946c82e0dd191c4bb6a0d737d39
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
