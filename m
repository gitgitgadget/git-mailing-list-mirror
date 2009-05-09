From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Sat,  9 May 2009 23:57:34 +0100
Message-ID: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com>
Cc: git@vger.kernel.org, Alex Blewitt <alex.blewitt@gmail.com>
To: spearce@spearce.org, robin.rosenberg@dewire.com
X-From: git-owner@vger.kernel.org Sun May 10 00:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2vUJ-0005fP-5g
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 00:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbZEIW5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 18:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbZEIW5i
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 18:57:38 -0400
Received: from server.bandlem.com ([217.155.97.60]:46673 "EHLO
	apple.int.bandlem.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753270AbZEIW5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 18:57:37 -0400
Received: by apple.int.bandlem.com (Postfix, from userid 1000)
	id C40A7E5A2B; Sat,  9 May 2009 23:57:34 +0100 (BST)
X-Mailer: git-send-email 1.6.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118688>

---
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index acb3cb5..015042a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -448,6 +448,12 @@ public final String name() {
 	}
 
 	/**
+	 * @return string form of the SHA-1, in lower case hexadecimal.
+	 */
+	public final String getName() {
+		return name();
+	}
+	/**
 	 * Return unique abbreviation (prefix) of this object SHA-1.
 	 * <p>
 	 * This method is a utility for <code>abbreviate(repo, 8)</code>.
-- 
1.6.2.2
