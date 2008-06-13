From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 13/24] Added constant REPOSITORY_DIRECTORY_NAME to Constants class.
Date: Fri, 13 Jun 2008 20:35:10 +0200
Message-ID: <1213382121-19786-13-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Cc: Florian Koeberle <florianskarten@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAT-0005zA-Mi
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYFMSgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYFMSgL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:11 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41966 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbYFMSfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:30 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 18F3DDFAF71F;
	Fri, 13 Jun 2008 20:35:30 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7V-0000eI-01; Fri, 13 Jun 2008 20:35:29 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19xhbjwvZSikRdHVahXlntJY/tqi+wi5Zb0vIyC
	XqrM8z7MujW4z4Jqe20/FYJxy0/61tH7z5Y8GQrRZydKkhLMPp
	1U7W0/SsjdEqmw+He7FA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84928>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Constants.java        |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 26b8c8e..744d4d8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -207,6 +207,12 @@ public final class Constants {
 	public static final String TAGS_PREFIX = "refs/tags";
 
 	/**
+	 * The name of the repository directory in the project directory. Project
+	 * directory means here the tree under version control.
+	 */
+	public static final String REPOSITORY_DIRECTORY_NAME = ".git";
+
+	/**
 	 * Create a new digest function for objects.
 	 * 
 	 * @return a new digest object.
-- 
1.5.4.3
