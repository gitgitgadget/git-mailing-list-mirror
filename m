From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH 1/2] Fix a spelling mistake in a git-p4 console message
Date: Fri, 19 Mar 2010 00:39:10 -0400
Message-ID: <1268973551-28118-1-git-send-email-bmeyer@rim.com>
Cc: simon.hausmann@nokia.com, Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 05:45:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsU5u-0007jp-6l
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 05:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976Ab0CSEpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 00:45:43 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:34222
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750798Ab0CSEpm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 00:45:42 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 00:45:42 EDT
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id usc91d0061wpRvQ51sflaU; Fri, 19 Mar 2010 04:39:45 +0000
Received: from localhost.localdomain ([71.192.50.29])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id usiN1d0010dnthT3esiNWc; Fri, 19 Mar 2010 04:42:22 +0000
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142561>

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index cd96c6f..c1ea643 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -802,7 +802,7 @@ class P4Submit(Command):
         self.oldWorkingDirectory = os.getcwd()
 
         chdir(self.clientPath)
-        print "Syncronizing p4 checkout..."
+        print "Synchronizing p4 checkout..."
         p4_system("sync ...")
 
         self.check()
-- 
1.7.0.2
