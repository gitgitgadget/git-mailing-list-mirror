From: Vineet Kumar <vineet@doorstop.net>
Subject: [PATCH] Minor wording changes in the keyboard descriptions in git-add --interactive.
Date: Fri,  7 Mar 2008 14:16:51 -0800
Message-ID: <1204928211-7168-1-git-send-email-vineet@doorstop.net>
Cc: Vineet Kumar <vineet@doorstop.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 23:48:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXlMk-0003iM-Fm
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 23:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbYCGWru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 17:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754959AbYCGWrt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 17:47:49 -0500
Received: from doorstop.net ([69.55.226.61]:55724 "EHLO philo.doorstop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbYCGWrt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 17:47:49 -0500
X-Greylist: delayed 1856 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Mar 2008 17:47:49 EST
Received: from vineet by philo.doorstop.net with local (Exim 4.63)
	(envelope-from <vineet@doorstop.net>)
	id 1JXkrz-000231-F3; Fri, 07 Mar 2008 14:16:51 -0800
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76530>

There were some inconsistent mixing of "this hunk" and "that hunk" referring
to the same hunk; I switched them all to "this".  There was also a missing
"the".
---
 Documentation/git-add.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 4779909..bc74fc0 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -207,10 +207,10 @@ patch::
   and the working tree file and asks you if you want to stage
   the change of each hunk.  You can say:
 
-       y - add the change from that hunk to index
-       n - do not add the change from that hunk to index
-       a - add the change from that hunk and all the rest to index
-       d - do not the change from that hunk nor any of the rest to index
+       y - add the change from this hunk to index
+       n - do not add the change from this hunk to index
+       a - add the change from this hunk and all the rest to index
+       d - do not add the change from this hunk nor any of the rest to index
        j - do not decide on this hunk now, and view the next
            undecided hunk
        J - do not decide on this hunk now, and view the next hunk
-- 
1.5.3.7

