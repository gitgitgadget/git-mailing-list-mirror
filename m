From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 4/5] Documentation/reset: reorder examples to match description
Date: Fri, 16 Jul 2010 11:44:41 +0200
Message-ID: <4d6d6155927b8ec371a4898d89bbcccdb18af48f.1279273256.git.trast@student.ethz.ch>
References: <cover.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhTx-0000OW-FD
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866Ab0GPJpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:45:08 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:43493 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964795Ab0GPJpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:45:07 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Jul
 2010 11:45:03 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 16 Jul
 2010 11:44:43 +0200
X-Mailer: git-send-email 1.7.2.rc3.259.g43154
In-Reply-To: <cover.1279273256.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151141>

A previous commit moved the <paths> mode (undoes git-add) to the front
in the description, so make the examples follow the same order.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   46 +++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 41edf41..ce08581 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -85,6 +85,29 @@ OPTIONS
 EXAMPLES
 --------
 
+Undo add::
++
+------------
+$ edit                                     <1>
+$ git add frotz.c filfre.c
+$ mailx                                    <2>
+$ git reset                                <3>
+$ git pull git://info.example.com/ nitfol  <4>
+------------
++
+<1> You are happily working on something, and find the changes
+in these files are in good order.  You do not want to see them
+when you run "git diff", because you plan to work on other files
+and changes with these files are distracting.
+<2> Somebody asks you to pull, and the changes sounds worthy of merging.
+<3> However, you already dirtied the index (i.e. your index does
+not match the HEAD commit).  But you know the pull you are going
+to make does not affect frotz.c nor filfre.c, so you revert the
+index changes for these two files.  Your changes in working tree
+remain there.
+<4> Then you can pull and merge, leaving frotz.c and filfre.c
+changes still in the working tree.
+
 Undo a commit and redo::
 +
 ------------
@@ -132,29 +155,6 @@ current HEAD.
 <2> Rewind the master branch to get rid of those three commits.
 <3> Switch to "topic/wip" branch and keep working.
 
-Undo add::
-+
-------------
-$ edit                                     <1>
-$ git add frotz.c filfre.c
-$ mailx                                    <2>
-$ git reset                                <3>
-$ git pull git://info.example.com/ nitfol  <4>
-------------
-+
-<1> You are happily working on something, and find the changes
-in these files are in good order.  You do not want to see them
-when you run "git diff", because you plan to work on other files
-and changes with these files are distracting.
-<2> Somebody asks you to pull, and the changes sounds worthy of merging.
-<3> However, you already dirtied the index (i.e. your index does
-not match the HEAD commit).  But you know the pull you are going
-to make does not affect frotz.c nor filfre.c, so you revert the
-index changes for these two files.  Your changes in working tree
-remain there.
-<4> Then you can pull and merge, leaving frotz.c and filfre.c
-changes still in the working tree.
-
 Undo a merge or pull::
 +
 ------------
-- 
1.7.2.rc3.259.g43154
