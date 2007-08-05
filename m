From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Sun,  5 Aug 2007 14:59:45 +0200
Message-ID: <1186318785677-git-send-email-prohaska@zib.de>
References: <20070803125634.GB28323@fieldses.org>
Cc: Steffen Prohaska <prohaska@zib.de>
To: bfields@fieldses.org, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 15:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHfii-0005xn-KP
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXHENA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbXHENA3
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:00:29 -0400
Received: from mailer.zib.de ([130.73.108.11]:56202 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbXHENA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:00:29 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75D00Be017098;
	Sun, 5 Aug 2007 15:00:00 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75CxjK4008287;
	Sun, 5 Aug 2007 14:59:45 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <20070803125634.GB28323@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55012>

git gui is especially useful because it allows to select diff hunks.
Now it is briefly mentioned in the user-manual.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/user-manual.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0071cd0..6865d21 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1079,6 +1079,17 @@ $ git diff HEAD	    # difference between HEAD and working tree; what
 $ git status	    # a brief per-file summary of the above.
 -------------------------------------------------
 
+Another approach for creating commits is git gui:
+
+-------------------------------------------------
+$ git gui citool
+-------------------------------------------------
+
+starts the commit tool, which lets you add files (use menu
+'Commit > Stage to Commit') or individually diff hunks (use
+'Stage Hunk For Commit' in the context menu of the diff view)
+to the index.
+
 [[creating-good-commit-messages]]
 Creating good commit messages
 -----------------------------
@@ -2482,6 +2493,10 @@ applying them (possibly in a different order) to mywork-new using
 cherry-pick, and possibly modifying them as you go using commit
 --amend.
 
+git gui is especially useful to rework commits as it lets you
+selectively add single diff hunks to the index (use
+'Stage Hunk For Commit' in the context menu of the diff view).
+
 Another technique is to use git-format-patch to create a series of
 patches, then reset the state to before the patches:
 
-- 
1.5.3.rc3.151.g8d6306
