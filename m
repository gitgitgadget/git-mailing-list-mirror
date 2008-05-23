From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 18/23] Added path related constants to the Constants class.
Date: Fri, 23 May 2008 22:34:27 +0200
Message-ID: <1211574872-23676-19-git-send-email-florianskarten@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:37:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze03-0006CA-Va
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067AbYEWUfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759167AbYEWUfH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:35:07 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39671 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466AbYEWUen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:43 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3FFE2DE1A8B5
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:42 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyL-0005iq-01; Fri, 23 May 2008 22:34:41 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/niAqTdvphW2XvVw9hJ1qvcPTjPtvnwfsukkfn
	P6uwCwrP6qRGauJR8t/CP1jJA5nNu5LFKqE1AwAYBkbfnhXGPt
	CHBtnkM1YzGtwinclbjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82756>

---
 .../src/org/spearce/jgit/lib/Constants.java        |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 7444d1d..38b0626 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -188,6 +188,16 @@ public final class Constants {
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
