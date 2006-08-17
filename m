From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: [PATCH] Indentation fix.
Date: Thu, 17 Aug 2006 20:44:16 +0200
Message-ID: <1155841663.9504@hammerfest>
X-From: git-owner@vger.kernel.org Thu Aug 17 21:08:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDnDc-0007NO-9a
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 21:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWHQTHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 15:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWHQTHr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 15:07:47 -0400
Received: from code-monkey.de ([81.169.170.126]:9228 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S932568AbWHQTHq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 15:07:46 -0400
Received: from hammerfest (c-180-198-37.bi.dial.de.ignite.net [62.180.198.37])
	by code-monkey.de (Postfix) with ESMTP id 9558A781B
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 21:07:45 +0200 (CEST)
X-Mailbox-Line: From a885a93f5385b3f57a68c766feec8693ac91ed83 Mon Sep 17 00:00:00 2001
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25605>

Signed-off-by: Tilman Sauerbeck <tilman@code-monkey.de>
---

This trivial patch fixes some tab vs space mixup.

 commit.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 972d1b7..3b2f4a7 100644
--- a/commit.c
+++ b/commit.c
@@ -7,15 +7,15 @@ int save_commit_buffer = 1;
 struct sort_node
 {
 	/*
-         * the number of children of the associated commit
-         * that also occur in the list being sorted.
-         */
+	 * the number of children of the associated commit
+	 * that also occur in the list being sorted.
+	 */
 	unsigned int indegree;
 
 	/*
-         * reference to original list item that we will re-use
-         * on output.
-         */
+	 * reference to original list item that we will re-use
+	 * on output.
+	 */
 	struct commit_list * list_item;
 
 };
-- 
1.4.2
