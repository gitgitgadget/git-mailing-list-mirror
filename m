From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] glossary: Add definitions for dangling and unreachable objects
Date: Sun,  4 Mar 2007 16:59:16 -0500
Message-ID: <117304556139-git-send-email-bfields@citi.umich.edu>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu> <11730455591178-git-send-email-bfields@citi.umich.edu> <11730455592152-git-send-email-bfields@citi.umich.edu> <11730455602463-git-send-email-bfields@citi.umich.edu> <11730455601849-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, Yasushi SHOJI <yashi@atmark-techno.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:08:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNysn-00081f-FD
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbXCDWI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbXCDWI3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:08:29 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50417
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752667AbXCDWI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:08:26 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2007 17:08:19 EST
Received: from pad.fieldses.org (localhost [127.0.0.1] (may be forged))
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l24LxMPl006645;
	Sun, 4 Mar 2007 16:59:22 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l24LxLZh006642;
	Sun, 4 Mar 2007 16:59:21 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11730455601849-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41381>

From: Yasushi SHOJI <yashi@atmark-techno.com>

Define "dangling" and "unreachable" objects.  Modified from original
text proposed by Yasushi Shoji.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/glossary.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index d20eb62..9f44624 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -73,6 +73,11 @@ DAG::
 	objects is acyclic (there is no chain which begins and ends with the
 	same object).
 
+dangling object::
+	An unreachable object which is not reachable even from other
+	unreachable objects; a dangling object has no references to it
+	from any reference or object in the repository.
+
 dircache::
 	You are *waaaaay* behind.
 
@@ -350,6 +355,10 @@ tag::
 unmerged index::
 	An index which contains unmerged index entries.
 
+unreachable object::
+	An object which is not reachable from a branch, tag, or any
+	other reference.
+
 working tree::
 	The set of files and directories currently being worked on,
 	i.e. you can work in your working tree without using git at all.
-- 
1.5.0.gb75812-dirty
