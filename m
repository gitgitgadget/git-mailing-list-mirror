From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/3] Update documentation for git-branch
Date: Sun, 22 Oct 2006 00:33:24 +0200
Message-ID: <1161470006965-git-send-email-hjemli@gmail.com>
References: <1161470004894-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 00:33:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbPPJ-0003AE-Jz
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 00:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWJUWda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWJUWd3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 18:33:29 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:7088 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S1422854AbWJUWd1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 18:33:27 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id k9LMXOmS026850
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 00:33:25 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1
In-Reply-To: <1161470004894-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29683>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-branch.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d43ef1d..dc6676e 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete bra
 SYNOPSIS
 --------
 [verse]
-'git-branch' [-r]
+'git-branch' [-r] [-v [-w <width>]]
 'git-branch' [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-d | -D) <branchname>...
 
@@ -47,6 +47,12 @@ OPTIONS
 -r::
 	List only the "remote" branches.
 
+-v::
+	Show sha1 and first line of commit message for each branch
+
+-w <width>::
+	Set columnwidth for branchname (default is 20)
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
-- 
1.4.3.1
