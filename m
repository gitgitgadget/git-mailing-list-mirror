From: Vineet Kumar <vineet@doorstop.net>
Subject: [PATCH] Minor wording changes in the keyboard descriptions in git-add --interactive.
Date: Thu, 13 Mar 2008 11:32:16 -0700
Message-ID: <1205433136-32734-1-git-send-email-vineet@doorstop.net>
References: <1204928211-7168-1-git-send-email-vineet@doorstop.net> <7vk5ke14hp.fsf@gitster.siamese.dyndns.org> <20080310154719.GA11449@doorstop.net>
Cc: Vineet Kumar <vineet@doorstop.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 19:33:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZsEc-0001Pd-EM
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYCMScS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbYCMScS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:32:18 -0400
Received: from doorstop.net ([69.55.226.61]:56860 "EHLO philo.doorstop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816AbYCMScR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:32:17 -0400
Received: from vineet by philo.doorstop.net with local (Exim 4.63)
	(envelope-from <vineet@doorstop.net>)
	id 1JZsDw-0000Sw-Ns; Thu, 13 Mar 2008 11:32:16 -0700
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <20080310154719.GA11449@doorstop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77124>

The wording of the interactive help text from git-add--interactive.perl is
clearer.  Just duplicate that text here.

Signed-off-by: Vineet Kumar <vineet@doorstop.net>
---
 Documentation/git-add.txt |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 4779909..c751a17 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -207,16 +207,14 @@ patch::
   and the working tree file and asks you if you want to stage
   the change of each hunk.  You can say:
 
-       y - add the change from that hunk to index
-       n - do not add the change from that hunk to index
-       a - add the change from that hunk and all the rest to index
-       d - do not the change from that hunk nor any of the rest to index
-       j - do not decide on this hunk now, and view the next
-           undecided hunk
-       J - do not decide on this hunk now, and view the next hunk
-       k - do not decide on this hunk now, and view the previous
-           undecided hunk
-       K - do not decide on this hunk now, and view the previous hunk
+       y - stage this hunk
+       n - do not stage this hunk
+       a - stage this and all the remaining hunks in the file
+       d - do not stage this hunk nor any of the remaining hunks in the file
+       j - leave this hunk undecided, see next undecided hunk
+       J - leave this hunk undecided, see next hunk
+       k - leave this hunk undecided, see previous undecided hunk
+       K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
        ? - print help
 +
-- 
1.5.4.2
