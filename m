From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 14/23] Added constant REPOSITORY_DIRECTORY_NAME to Constants class.
Date: Fri, 23 May 2008 22:34:23 +0200
Message-ID: <1211574872-23676-15-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze01-0006CA-Sj
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525AbYEWUfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757054AbYEWUe6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:58 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39661 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556AbYEWUem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:42 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6C570DE1A8A0
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:40 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyK-0005iq-00; Fri, 23 May 2008 22:34:40 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19aus7d2iwuUMaMdRG1C0Bg9t+y7dZKfpdgtqyf
	yaUUtWEhle0gbo7lCBZd2AbTgORLAIJPpvhRZBHtmL9OMPh97c
	ZW54GMKItB4YeAVDDj+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82735>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Constants.java        |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index febf469..7444d1d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -182,6 +182,12 @@ public final class Constants {
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
