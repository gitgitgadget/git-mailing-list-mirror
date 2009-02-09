From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH] git-rebase-interactive: you can also add new commits to the
 "work list"
Date: Mon, 09 Feb 2009 22:25:01 +0100
Message-ID: <1234214701-20245-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 22:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdeB-0005e1-WD
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbZBIVZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbZBIVZE
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:25:04 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:37581 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZBIVZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:25:03 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IACI5QPRA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 22:25:02 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET006ZOI5PUW80@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 22:25:02 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109134>

Add 2 small lines to document that you can also use 'git rebase
--interactive' to add new commits to the rebased patch-series.  This
is sort of running multiple 'git cherry-pick' commands in one go.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

  If this is a good idea, soneone should correct my poor english.

  -- kjetil


 git-rebase--interactive.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3dc659d..aa2e53c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -734,6 +734,9 @@ first and then run 'git rebase --continue' again."
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
+# If you add a new line with a command followed by the SHA1 ref of the
+# patch, then that patch will be added to the list.
+#
 EOF
 
 		has_action "$TODO" ||
-- 
1.6.1.349.g99fa5
