From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 08/10] user-manual: add a "counting commits" example
Date: Mon, 14 May 2007 11:21:27 -0400
Message-ID: <24838.6180530817$1179156134@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
 <11791560893022-git-send-email->
 <11791560891179-git-send-email->
 <1179156089470-git-send-email->
 <11791560892667-git-send-email->
 <11791560901-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNH-0006P0-A3
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbXENPVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756731AbXENPVi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:38 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54967 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756094AbXENPVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMc-0004zE-6F; Mon, 14 May 2007 11:21:30 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <11791560901-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47250>

From: J. Bruce Fields <bfields@citi.umich.edu>

This is partly just an excuse to mention --pretty= and rev-list.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3f51522..e86e46c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -690,6 +690,25 @@ may be any path to a file tracked by git.
 Examples
 --------
 
+[[counting-commits-on-a-branch]]
+Counting the number of commits on a branch
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Suppose you want to know how many commits you've made on "mybranch"
+since it diverged from "origin":
+
+-------------------------------------------------
+$ git log --pretty=oneline origin..maint | wc -l
+-------------------------------------------------
+
+Alternatively you may often see this sort of thing done with the
+lower-level command gitlink:git-rev-list[1], which just lists the SHA1's
+of all the given commits:
+
+-------------------------------------------------
+$ git rev-list origin..maint | wc -l
+-------------------------------------------------
+
 [[checking-for-equal-branches]]
 Check whether two branches point at the same history
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
1.5.1.4.19.g69e2
