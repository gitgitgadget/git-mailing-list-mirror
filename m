From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/6] Correct Javadoc of RawParseUtils next and nextLF methods
Date: Wed, 10 Dec 2008 14:05:48 -0800
Message-ID: <1228946751-12708-4-git-send-email-spearce@spearce.org>
References: <1228946751-12708-1-git-send-email-spearce@spearce.org>
 <1228946751-12708-2-git-send-email-spearce@spearce.org>
 <1228946751-12708-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXDM-00031R-EE
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbYLJWGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbYLJWGA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:06:00 -0500
Received: from george.spearce.org ([209.20.77.23]:39015 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbYLJWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:05:54 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id ABA3A38260; Wed, 10 Dec 2008 22:05:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8DA3838215;
	Wed, 10 Dec 2008 22:05:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228946751-12708-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102726>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/util/RawParseUtils.java   |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
index 5a40911..8896d38 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/RawParseUtils.java
@@ -213,10 +213,10 @@ public static final int parseTimeZoneOffset(final byte[] b, int ptr) {
 	 * @param b
 	 *            buffer to scan.
 	 * @param ptr
-	 *            position within buffer to start looking for LF at.
+	 *            position within buffer to start looking for chrA at.
 	 * @param chrA
 	 *            character to find.
-	 * @return new position just after chr.
+	 * @return new position just after chrA.
 	 */
 	public static final int next(final byte[] b, int ptr, final char chrA) {
 		final int sz = b.length;
@@ -250,10 +250,10 @@ public static final int nextLF(final byte[] b, int ptr) {
 	 * @param b
 	 *            buffer to scan.
 	 * @param ptr
-	 *            position within buffer to start looking for LF at.
+	 *            position within buffer to start looking for chrA or LF at.
 	 * @param chrA
 	 *            character to find.
-	 * @return new position just after the first chrA or chrB to be found.
+	 * @return new position just after the first chrA or LF to be found.
 	 */
 	public static final int nextLF(final byte[] b, int ptr, final char chrA) {
 		final int sz = b.length;
-- 
1.6.1.rc2.299.gead4c
