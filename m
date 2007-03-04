From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] Documentation: mention module option to git-cvsimport
Date: Sun,  4 Mar 2007 16:59:10 -0500
Message-ID: <11730455574115-git-send-email-bfields@citi.umich.edu>
References: <1173045556191-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:08:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNysR-0007sf-OI
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbXCDWIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbXCDWIV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:08:21 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50417
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751962AbXCDWIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:08:20 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2007 17:08:19 EST
Received: from pad.fieldses.org (localhost [127.0.0.1] (may be forged))
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l24LxIM6006619;
	Sun, 4 Mar 2007 16:59:18 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l24LxIEH006618;
	Sun, 4 Mar 2007 16:59:18 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <1173045556191-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41377>

From: J. Bruce Fields <bfields@citi.umich.edu>

The git-cvsimport argument that specifies a cvs module to import should
probably be included in the default example.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/cvs-migration.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 764cc56..3b6b494 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -109,7 +109,7 @@ sure it is in your path.  Then cd to a checked out CVS working directory
 of the project you are interested in and run gitlink:git-cvsimport[1]:
 
 -------------------------------------------
-$ git cvsimport -C <destination>
+$ git cvsimport -C <destination> <module>
 -------------------------------------------
 
 This puts a git archive of the named CVS module in the directory
-- 
1.5.0.gb75812-dirty
