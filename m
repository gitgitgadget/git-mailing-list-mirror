From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Grammar fixes to "merge" and "patch-id" docs
Date: Wed, 25 Mar 2009 19:23:42 +0100
Message-ID: <1238005422-7647-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 19:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXn1-0003jg-9p
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbZCYSXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbZCYSXu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:23:50 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:50342 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbZCYSXt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:23:49 -0400
Received: from localhost.localdomain (179.pool85-53-16.dynamic.orange.es [85.53.16.179])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2PINgaI020827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Mar 2009 14:23:43 -0400
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114637>

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
Just a few grammar glitches that caught my eye while
perusing some man pages.

 Documentation/git-merge.txt        |    2 +-
 Documentation/git-patch-id.txt     |    2 +-
 Documentation/merge-strategies.txt |   14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index cc0d30f..427ad90 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -41,7 +41,7 @@ include::merge-strategies.txt[]
 
 
 If you tried a merge which resulted in a complex conflicts and
-would want to start over, you can recover with 'git-reset'.
+want to start over, you can recover with 'git-reset'.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 477785e..253fc0f 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -20,7 +20,7 @@ IOW, you can use this thing to look for likely duplicate commits.
 
 When dealing with 'git-diff-tree' output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
-commit, and outputs two 40-byte hexadecimal string.  The first
+commit, and outputs two 40-byte hexadecimal strings.  The first
 string is the patch ID, and the second string is the commit ID.
 This can be used to make a mapping from patch ID to commit ID.
 
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 1276f85..ee7f754 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -3,15 +3,15 @@ MERGE STRATEGIES
 
 resolve::
 	This can only resolve two heads (i.e. the current branch
-	and another branch you pulled from) using 3-way merge
+	and another branch you pulled from) using a 3-way merge
 	algorithm.  It tries to carefully detect criss-cross
 	merge ambiguities and is considered generally safe and
 	fast.
 
 recursive::
-	This can only resolve two heads using 3-way merge
-	algorithm.  When there are more than one common
-	ancestors that can be used for 3-way merge, it creates a
+	This can only resolve two heads using a 3-way merge
+	algorithm.  When there is more than one common
+	ancestor that can be used for 3-way merge, it creates a
 	merged tree of the common ancestors and uses that as
 	the reference tree for the 3-way merge.  This has been
 	reported to result in fewer merge conflicts without
@@ -22,11 +22,11 @@ recursive::
 	pulling or merging one branch.
 
 octopus::
-	This resolves more than two-head case, but refuses to do
-	complex merge that needs manual resolution.  It is
+	This resolves the more than two-heads case, but refuses to do
+	a complex merge that needs manual resolution.  It is
 	primarily meant to be used for bundling topic branch
 	heads together.  This is the default merge strategy when
-	pulling or merging more than one branches.
+	pulling or merging more than one branch.
 
 ours::
 	This resolves any number of heads, but the result of the
-- 
1.6.2.1
