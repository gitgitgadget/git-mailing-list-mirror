From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] git-branch: Mention -d and -D in man-page.
Date: Mon, 14 Nov 2005 17:53:42 +0100 (CET)
Message-ID: <20051114165342.3F8185BF92@nox.op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:54:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhaV-0004Av-EW
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVKNQxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKNQxn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:53:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38339 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751195AbVKNQxn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:53:43 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 6011C6BD08
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 17:53:42 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 3F8185BF92; Mon, 14 Nov 2005 17:53:42 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11826>


Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-branch.txt |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

applies-to: 963d67921d6f65c08d51a8c93811f03274c34703
f67747f6501aa0b8bd5e58a3933fd1a738f69441
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index a7121a4..98014f6 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -3,11 +3,11 @@ git-branch(1)
 
 NAME
 ----
-git-branch - Create a new branch.
+git-branch - Create a new branch, or remove an old one.
 
 SYNOPSIS
 --------
-'git-branch' [<branchname> [start-point]]
+'git-branch' [-d | -D] [<branchname> [start-point]]
 
 DESCRIPTION
 -----------
@@ -19,11 +19,18 @@ created, otherwise it will be created at
 
 OPTIONS
 -------
+-d::
+	Delete a branch. The branch must be fully merged.
+
+-D::
+	Delete a branch irrespective of its index status.
+
 <branchname>::
-	The name of the branch to create.
+	The name of the branch to create or delete.
 
 start-point::
-	Where to create the branch; defaults to HEAD.
+	Where to create the branch; defaults to HEAD. This
+	option has no meaning with -d and -D.
 
 Author
 ------
---
0.99.9.GIT
