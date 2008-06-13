From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 12/24] Formatted Constants class.
Date: Fri, 13 Jun 2008 20:35:09 +0200
Message-ID: <1213382121-19786-12-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Cc: Florian Koeberle <florianskarten@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAU-0005zA-9p
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYFMSgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbYFMSgM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:12 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43439 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbYFMSfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:30 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id A50AAE184EFA;
	Fri, 13 Jun 2008 20:35:29 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7V-0000eI-00; Fri, 13 Jun 2008 20:35:29 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1+vxweePTqJCYcvI8wqTu4Tegebi57X/amiIwdT
	O1BHg1/ZW2ddtdgd7768Ma5uYih6Gdd4j+NTXdLepduPEcvI0k
	hVaitimjgsjWb2Sv05tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84931>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Constants.java        |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index d1e8a41..26b8c8e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -226,8 +226,9 @@ public final class Constants {
 
 	/**
 	 * Convert an OBJ_* type constant to a TYPE_* type constant.
-	 *
-	 * @param typeCode the type code, from a pack representation.
+	 * 
+	 * @param typeCode
+	 *            the type code, from a pack representation.
 	 * @return the canonical string name of this type.
 	 */
 	public static String typeString(final int typeCode) {
@@ -248,10 +249,11 @@ public final class Constants {
 	/**
 	 * Convert an OBJ_* type constant to an ASCII encoded string constant.
 	 * <p>
-	 * The ASCII encoded string is often the canonical representation of
-	 * the type within a loose object header, or within a tag header.
-	 *
-	 * @param typeCode the type code, from a pack representation.
+	 * The ASCII encoded string is often the canonical representation of the
+	 * type within a loose object header, or within a tag header.
+	 * 
+	 * @param typeCode
+	 *            the type code, from a pack representation.
 	 * @return the canonical ASCII encoded name of this type.
 	 */
 	public static byte[] encodedTypeString(final int typeCode) {
-- 
1.5.4.3
