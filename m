From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 13/23] Formatted Constants class.
Date: Fri, 23 May 2008 22:34:22 +0200
Message-ID: <1211574872-23676-14-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze01-0006CA-8i
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556AbYEWUe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759016AbYEWUe4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45466 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809AbYEWUek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:40 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0DC4EDC4A2FE
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:40 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyJ-0005iq-01; Fri, 23 May 2008 22:34:39 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19X03UqzfutqLpoCYGbqVGKjk8S/1/3szCnzp0E
	H9VEIML5G9g/ERy6mpij6UcL4i55zp4PaKvavV1ciJ6qNecLaE
	cc0GU6v3lTCU8e44cT3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82734>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Constants.java        |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 0c83cf2..febf469 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -201,8 +201,9 @@ public final class Constants {
 
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
@@ -223,10 +224,11 @@ public final class Constants {
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
