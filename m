From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] gitk: add missing accelerators
Date: Wed, 30 Sep 2015 21:50:11 +0200
Message-ID: <1443642611-11827-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>, Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 21:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhNOV-0004zt-O5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbbI3TuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:50:24 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:60244 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581AbbI3TuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:50:22 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id BB14AC3448;
	Wed, 30 Sep 2015 21:50:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 9B51BC3447;
	Wed, 30 Sep 2015 21:50:18 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id 70D801FDF2; Wed, 30 Sep 2015 21:50:18 +0200 (CEST)
X-Mailer: git-send-email 2.6.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278863>

In d99b4b0de27a ("gitk: Accelerators for the main menu", 2015-09-09),
accelerators were added to allow efficient keyboard navigation. One
instance of the strings "Edit view..." and "Delete view" were left
without the ampersand.

Add the missing ampersand characters to unbreak our international
users.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Paul Mackerras <paulus@samba.org>
---
 gitk-git/gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 2028b55..fcc606e 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12452,8 +12452,8 @@ if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     set viewchanged(1) 0
     set vdatemode(1) 0
     addviewmenu 1
-    .bar.view entryconf [mca "Edit view..."] -state normal
-    .bar.view entryconf [mca "Delete view"] -state normal
+    .bar.view entryconf [mca "&Edit view..."] -state normal
+    .bar.view entryconf [mca "&Delete view"] -state normal
 }
 
 if {[info exists permviews]} {
-- 
2.6.0
