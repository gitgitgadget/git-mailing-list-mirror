From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 1/5] user-manual: update for new default --track behavior
Date: Mon,  6 Aug 2007 00:33:58 -0400
Message-ID: <24774.838719941$1186374891@news.gmane.org>
References: 20070805222527.GB12168@fieldses.org
 <11863748422001-git-send-email->
Cc: git@vger.kernel.org,
	"J. Bruce Fields" <bfields@pig.linuxdev.us.dell.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 06 06:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHuIl-00086f-Sr
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 06:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbXHFEeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 00:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbXHFEeZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 00:34:25 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38243 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbXHFEeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 00:34:24 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHuI6-0001mK-N5; Mon, 06 Aug 2007 00:34:02 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11863748422001-git-send-email->
Message-Id: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55111>

From: J. Bruce Fields <bfields@pig.linuxdev.us.dell.com>

Update documentation to reflect the --track default.

That change seems to have happened in the 1.5.3 -rc's, so bump the "for
version x.y.z or newer" warning as well.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0071cd0..c0820e9 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,4 +1,4 @@
-Git User's Manual (for version 1.5.1 or newer)
+Git User's Manual (for version 1.5.3 or newer)
 ______________________________________________
 
 
@@ -1667,24 +1667,19 @@ one step:
 $ git pull origin master
 -------------------------------------------------
 
-In fact, "origin" is normally the default repository to pull from,
-and the default branch is normally the HEAD of the remote repository,
-so often you can accomplish the above with just
+In fact, if you have "master" checked out, then by default "git pull"
+merges from the HEAD branch of the origin repository.  So often you can
+accomplish the above with just a simple
 
 -------------------------------------------------
 $ git pull
 -------------------------------------------------
 
-See the descriptions of the branch.<name>.remote and branch.<name>.merge
-options in gitlink:git-config[1] to learn how to control these defaults
-depending on the current branch.  Also note that the --track option to
-gitlink:git-branch[1] and gitlink:git-checkout[1] can be used to
-automatically set the default remote branch to pull from at the time
-that a branch is created:
-
--------------------------------------------------
-$ git checkout --track -b maint origin/maint
--------------------------------------------------
+More generally, a branch that is created from a remote branch will pull
+by default from that branch.  See the descriptions of the
+branch.<name>.remote and branch.<name>.merge options in
+gitlink:git-config[1], and the discussion of the --track option in
+gitlink:git-checkout[1], to learn how to control these defaults.
 
 In addition to saving you keystrokes, "git pull" also helps you by
 producing a default commit message documenting the branch and
-- 
1.5.3.GIT
