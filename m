From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 3/5] user-manual: mention git-gui
Date: Mon,  6 Aug 2007 00:34:00 -0400
Message-ID: <37994.1480620348$1186374889@news.gmane.org>
References: 20070805222527.GB12168@fieldses.org
 <11863748422001-git-send-email->
 <1186374842108-git-send-email->
 <11863748422754-git-send-email->
Cc: git@vger.kernel.org,
	"J. Bruce Fields" <bfields@pig.linuxdev.us.dell.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 06 06:34:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHuIm-00086f-Dj
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 06:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbXHFEe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 00:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbXHFEe0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 00:34:26 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38245 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbXHFEeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 00:34:24 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHuI6-0001mO-Rt; Mon, 06 Aug 2007 00:34:02 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11863748422754-git-send-email->
Message-Id: <407c0c87e15b3cf60347f4fc0bcdb4d239de4163.1186373089.git.bfields@pig.linuxdev.us.dell.com>
In-Reply-To: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
References: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55110>

From: J. Bruce Fields <bfields@pig.linuxdev.us.dell.com>

The git gui project seems to be still in early stages, but at a point
where it's worth mentioning as an alternative way of creating commits.

One feature of interest is the ability to manipulate individual diff
hunks.  However, people have found that feature not to be easily
discoverable from the user-interface.  Pending some ui improvements, a
parenthetical hint here may help.

(Thanks to Steffen Prohask and Junio Hamano for suggesting the
language.)

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 9efe85c..f89952a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1079,6 +1079,11 @@ $ git diff HEAD	    # difference between HEAD and working tree; what
 $ git status	    # a brief per-file summary of the above.
 -------------------------------------------------
 
+You can also use gitlink:git-gui[1] to create commits, view changes in
+the index and the working tree files, and individually select diff hunks
+for inclusion in the index (by right-clicking on the diff hunk and
+choosing "Stage Hunk For Commit").
+
 [[creating-good-commit-messages]]
 Creating good commit messages
 -----------------------------
@@ -2506,8 +2511,10 @@ $ gitk origin..mywork &
 
 And browse through the list of patches in the mywork branch using gitk,
 applying them (possibly in a different order) to mywork-new using
-cherry-pick, and possibly modifying them as you go using commit
---amend.
+cherry-pick, and possibly modifying them as you go using commit --amend.
+The git-gui[1] command may also help as it allows you to individually
+select diff hunks for inclusion in the index (by right-clicking on the
+diff hunk and choosing "Stage Hunk for Commit").
 
 Another technique is to use git-format-patch to create a series of
 patches, then reset the state to before the patches:
-- 
1.5.3.GIT
