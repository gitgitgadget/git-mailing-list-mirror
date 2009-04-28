From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/13] Document the IllegalArgumentException thrown by WindowCache.reconfigure
Date: Tue, 28 Apr 2009 14:12:17 -0700
Message-ID: <1240953146-12878-5-git-send-email-spearce@spearce.org>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org>
 <1240953146-12878-2-git-send-email-spearce@spearce.org>
 <1240953146-12878-3-git-send-email-spearce@spearce.org>
 <1240953146-12878-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyubc-0004xr-1L
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814AbZD1VMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbZD1VMe
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:12:34 -0400
Received: from george.spearce.org ([209.20.77.23]:58319 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbZD1VMc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:12:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6D2CF3826E; Tue, 28 Apr 2009 21:12:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id EC7FF38221;
	Tue, 28 Apr 2009 21:12:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc1.205.g37f8
In-Reply-To: <1240953146-12878-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117811>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/WindowCache.java      |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
index 3eb1204..e4c88d2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
@@ -107,6 +107,9 @@ public static void reconfigure(final int packedGitLimit,
 	 *
 	 * @param cfg
 	 *            the new window cache configuration.
+	 * @throws IllegalArgumentException
+	 *             the cache configuration contains one or more invalid
+	 *             settings, usually too low of a limit.
 	 */
 	public static void reconfigure(final WindowCacheConfig cfg) {
 		final WindowCache c = cache;
-- 
1.6.3.rc1.205.g37f8
