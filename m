From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 17/24] Added path related constants to the Constants class.
Date: Fri, 13 Jun 2008 20:35:14 +0200
Message-ID: <1213382121-19786-17-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Cc: Florian Koeberle <florianskarten@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAQ-0005zA-4W
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbYFMSf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYFMSf5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:35:57 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33532 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbYFMSfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:32 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0BBC0E3F1982;
	Fri, 13 Jun 2008 20:35:32 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7X-0000eI-01; Fri, 13 Jun 2008 20:35:31 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18kBSRDnmQr4f8TNxPZb/usMK6sHl7YKcnrr5PT
	Sb06UDR1+SGCWuXt2kqMKz6t9kR2I9a4fEu9LZohlIsJR9534f
	sOoQmj5chw1Gt4NQndHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84914>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Constants.java        |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 744d4d8..ee85ded 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -213,6 +213,16 @@ public final class Constants {
 	public static final String REPOSITORY_DIRECTORY_NAME = ".git";
 
 	/**
+	 * Contains the name of the objects directory in the repository directory.
+	 */
+	public static final String OBJECTS_DIRECTORY_NAME = "objects";
+
+	/**
+	 * Contains the name of the refs directory in the repository directory.
+	 */
+	public static final String REFS_DIRECTORY_NAME = "refs";
+
+	/**
 	 * Create a new digest function for objects.
 	 * 
 	 * @return a new digest object.
-- 
1.5.4.3
