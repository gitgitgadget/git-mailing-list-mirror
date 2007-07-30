From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Mon, 30 Jul 2007 18:11:20 +0200
Message-ID: <11858118802945-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 18:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFXqe-0006jL-ED
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 18:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761489AbXG3QL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 12:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761392AbXG3QL1
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 12:11:27 -0400
Received: from mailer.zib.de ([130.73.108.11]:59863 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758591AbXG3QL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 12:11:26 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6UGBLwP017449
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 18:11:21 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6UGBKnp004015;
	Mon, 30 Jul 2007 18:11:21 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54234>

git gui is especially useful because it allows to select diff hunks.
Now it is at least mentioned in the user-manual.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/user-manual.txt |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0071cd0..de4ec0b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1079,6 +1079,24 @@ $ git diff HEAD	    # difference between HEAD and working tree; what
 $ git status	    # a brief per-file summary of the above.
 -------------------------------------------------
 
+Another approach for creating commits is git gui:
+
+-------------------------------------------------
+$ git gui citool
+-------------------------------------------------
+
+starts the commit tool (Note, "`git gui`" starts the full gui, which
+provides more options).
+
+Beyond the basic operation of staging and unstaging complete files,
+git gui can also selectively stage diff hunks.  You can do so by
+selecting a modified or staged file and right-click on the diff view
+in the lower part of the gui. A pop-up will appear that lets you
+select a specific hunk and stage or unstage it for the next commit.
+This is particular useful for slicing large, ugly commits into smaller
+pieces, for example when cherry-picking (see
+<<reordering-patch-series>>).
+
 [[creating-good-commit-messages]]
 Creating good commit messages
 -----------------------------
@@ -2480,7 +2498,8 @@ $ gitk origin..mywork &
 And browse through the list of patches in the mywork branch using gitk,
 applying them (possibly in a different order) to mywork-new using
 cherry-pick, and possibly modifying them as you go using commit
---amend.
+--amend. git gui may be especially useful to amend commits as it
+lets you selectively stage and unstage single diff hunks.
 
 Another technique is to use git-format-patch to create a series of
 patches, then reset the state to before the patches:
-- 
1.5.3.rc3.122.g4978
