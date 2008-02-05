From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 6/6] Tighten requirements on javadoc.
Date: Tue,  5 Feb 2008 01:15:34 +0100
Message-ID: <1202170534-15788-7-git-send-email-robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-4-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-5-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-6-git-send-email-robin.rosenberg@dewire.com>
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 01:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBtt-0001DL-7m
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbYBEAmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756915AbYBEAmS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:42:18 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18396 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757386AbYBEAmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:42:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B197B800695;
	Tue,  5 Feb 2008 01:15:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9Y+h5ZcBH5S; Tue,  5 Feb 2008 01:15:43 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 5BB2E800693;
	Tue,  5 Feb 2008 01:15:34 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 57E01290FD; Tue,  5 Feb 2008 01:15:34 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202170534-15788-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72596>

All public and protected methods and members must be documented.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../.settings/org.eclipse.jdt.core.prefs           |    4 ++--
 .../.settings/org.eclipse.jdt.core.prefs           |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
index 322fe98..f94f9a8 100644
--- a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
-#Wed May 16 23:05:48 EDT 2007
+#Sun Feb 03 18:48:30 CET 2008
 eclipse.preferences.version=1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
@@ -34,7 +34,7 @@ org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
 org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
 org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
 org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
-org.eclipse.jdt.core.compiler.problem.missingJavadocComments=warning
+org.eclipse.jdt.core.compiler.problem.missingJavadocComments=error
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
 org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
diff --git a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
index 15190a0..8bfa5f1 100644
--- a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
-#Thu Dec 20 01:31:35 CET 2007
+#Tue Feb 05 00:01:29 CET 2008
 eclipse.preferences.version=1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
@@ -37,7 +37,7 @@ org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
 org.eclipse.jdt.core.compiler.problem.missingJavadocComments=ignore
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=public
-org.eclipse.jdt.core.compiler.problem.missingJavadocTags=ignore
+org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
 org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=private
 org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
-- 
1.5.4.rc4.25.g81cc
