From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 4/5] Documentation/reset: reorder examples to match description
Date: Sun, 18 Jul 2010 20:23:25 +0200
Message-ID: <4d1facbcc99ee13068a00134d01c7f717369d3b9.1279477130.git.trast@student.ethz.ch>
References: <cover.1279477130.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYX1-0002SZ-J6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966Ab0GRSXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 14:23:47 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54309 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946Ab0GRSXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 14:23:40 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 18 Jul
 2010 20:23:39 +0200
Received: from localhost.localdomain (129.132.209.162) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 18 Jul
 2010 20:23:38 +0200
X-Mailer: git-send-email 1.7.2.rc3.317.gc287
In-Reply-To: <cover.1279477130.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151234>

A previous commit moved the <paths> mode (undoes git-add) to the front
in the description, so make the examples follow the same order.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   46 +++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 70198f9..1550ba2 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -86,6 +86,29 @@ OPTIONS
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
@@ -133,29 +156,6 @@ current HEAD.
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
1.7.2.rc3.317.gc287
