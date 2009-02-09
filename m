From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v3] git-rebase-interactive: you can also add new commits to the
 "work list"
Date: Tue, 10 Feb 2009 00:05:01 +0100
Message-ID: <1234220701-20652-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 00:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWfCy-00084w-M1
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 00:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbZBIXFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 18:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbZBIXFF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 18:05:05 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:40619 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbZBIXFE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 18:05:04 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00I03MSFPRE0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 10 Feb 2009 00:05:03 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET00CHFMSEG640@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 10 Feb 2009 00:05:03 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109159>

Add some lines to document that you can also use 'git rebase
--interactive' to add new commits to the rebased patch-series.  This
is sort of running multiple 'git cherry-pick' commands in one go.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 Documentation/git-rebase.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3d6d429..52c0778 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -318,8 +318,9 @@ Start it with the last commit you want to retain as-is:
 
 An editor will be fired up with all the commits in your current branch
 (ignoring merge commits), which come after the given commit.  You can
-reorder the commits in this list to your heart's content, and you can
-remove them.  The list looks more or less like this:
+reorder the commits in this list to your heart's content, you can
+remove them, and you can also add new commits.  The list looks more or
+less like this:
 
 -------------------------------------------
 pick deadbee The oneline of this commit
@@ -331,6 +332,9 @@ The oneline descriptions are purely for your pleasure; 'git-rebase' will
 not look at them but at the commit names ("deadbee" and "fa1afe1" in this
 example), so do not delete or edit the names.
 
+You can also introduce a new commit into the list, by finding the SHA1
+ref of that new commit, and place a command in front of it.
+
 By replacing the command "pick" with the command "edit", you can tell
 'git-rebase' to stop after applying that commit, so that you can edit
 the files and/or the commit message, amend the commit, and continue
-- 
1.6.1.349.g99fa5
