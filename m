From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/19] Delete incorrect Javadoc from Config's getRawString method
Date: Sat, 25 Jul 2009 11:52:45 -0700
Message-ID: <1248547982-4003-3-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:53:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmN6-0002D8-B8
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbZGYSxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbZGYSxF
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:05 -0400
Received: from george.spearce.org ([209.20.77.23]:35546 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZGYSxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:03 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 45FF53821F; Sat, 25 Jul 2009 18:53:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6D5CF38196;
	Sat, 25 Jul 2009 18:53:03 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124036>

I don't know how this Javadoc got here, but it predates the code
refactor done by Constantine Plotnikov in 2564768e63.

The documentation is incorrect, as the method returns a single string
but the summary line says a list.  Since we usually don't document
a private method I'm removing the documentation block rather than
correcting it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 258dba5..76f780f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -385,17 +385,6 @@ public String getString(final String section, String subsection,
 		return result;
 	}
 
-	/**
-	 * Get a list of string values
-	 *
-	 * @param section
-	 *            the section
-	 * @param subsection
-	 *            the subsection for the value
-	 * @param name
-	 *            the key name
-	 * @return a raw string value as it is stored in configuration file
-	 */
 	private String getRawString(final String section, final String subsection,
 			final String name) {
 		final Object o = getRawEntry(section, subsection, name);
-- 
1.6.4.rc2.216.g769fa
