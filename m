From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: reset to ORIG_HEAD not HEAD to undo merge
Date: Sun,  4 Mar 2007 16:59:11 -0500
Message-ID: <1173045558959-git-send-email-bfields@citi.umich.edu>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNysk-00081f-P3
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXCDWIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbXCDWIW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:08:22 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50417
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751998AbXCDWIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:08:21 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2007 17:08:19 EST
Received: from pad.fieldses.org (localhost [127.0.0.1] (may be forged))
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l24LxIfw006623;
	Sun, 4 Mar 2007 16:59:19 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l24LxIP1006622;
	Sun, 4 Mar 2007 16:59:18 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11730455574115-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41380>

From: J. Bruce Fields <bfields@citi.umich.edu>

As Linus pointed out recently on the mailing list,

	git reset --hard HEAD^

doesn't undo a merge in the case where the merge did a fast-forward.  So
the rcommendation here is a little dangerous.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 34e9651..0979211 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1255,7 +1255,7 @@ $ git reset --hard HEAD
 Or, if you've already commited the merge that you want to throw away,
 
 -------------------------------------------------
-$ git reset --hard HEAD^
+$ git reset --hard ORIG_HEAD
 -------------------------------------------------
 
 However, this last command can be dangerous in some cases--never
-- 
1.5.0.gb75812-dirty
