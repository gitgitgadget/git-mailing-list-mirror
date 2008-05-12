From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 04/24] Added path related constats to Constats class.
Date: Mon, 12 May 2008 22:13:22 +0200
Message-ID: <1210623222-24908-5-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSp-00086f-94
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbYELUOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbYELUOx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:53 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40145 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYELUNo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:44 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5772CDECFCF8
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:43 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP0-00016x-01; Mon, 12 May 2008 22:13:43 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18J+b//Q5WF60u4bXdYVR5Zx/QseAhjTT9mK/Gd
	prujFpZUawrpeHIaUV3AGp5MXdcnqYFznwTmDwEvGQcLj2vinS
	xcdUUbGIgp49brRhQCIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81939>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Constants.java        |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 169c615..13e09d8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -171,6 +171,26 @@ public final class Constants {
 	public static String REMOTES_PREFIX = "refs/remotes";
 
 	/**
+	 * The name of the repository directory in the project directory.
+	 */
+	public static final String REPOSITORY_DIRECTORY_NAME = ".git";
+
+	/**
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
+	 * Contains the name of the HEAD file in the repository directory.
+	 */
+	public static final String HEAD_FILE_NAME = "HEAD";
+
+	/**
 	 * Create a new digest function for objects.
 	 * 
 	 * @return a new digest object.
-- 
1.5.4.3
