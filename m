From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/3] Fix usagestring for git-branch
Date: Sun, 22 Oct 2006 13:30:24 +0200
Message-ID: <11615166272840-git-send-email-hjemli@gmail.com>
References: <1161516626749-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 13:30:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbbXE-0005Lw-QG
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 13:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWJVLa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 07:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWJVLa2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 07:30:28 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:39669 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S932390AbWJVLa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 07:30:27 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id k9MBUPPn003655
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:30:26 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1.g1688
In-Reply-To: <1161516626749-git-send-email-hjemli@gmail.com>
Message-Id: <5245bfe3982f5c23841229af9f548f982b9c60c3.1161516129.git.hjemli@gmail.com>
Date: Sun, 22 Oct 2006 11:54:12 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index 4379a07..b80bcda 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r'
+USAGE=' [-l] [-f] <branchname> [<start-point>] | (-d | -D) <branchname> | [-r]'
 LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
 If two arguments, create a new branch <branchname> based off of <start-point>.'
-- 
1.4.3.1.g1688
