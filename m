From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/6] Do not require javadoc in egit.core test project
Date: Tue,  5 Feb 2008 01:15:31 +0100
Message-ID: <1202170534-15788-4-git-send-email-robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-2-git-send-email-robin.rosenberg@dewire.com>
 <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
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
	id 1JMBts-0001DL-I0
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbYBEAmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757330AbYBEAmP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:42:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18377 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757961AbYBEAmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:42:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 98909800686;
	Tue,  5 Feb 2008 01:15:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 43CLxT91N0am; Tue,  5 Feb 2008 01:15:35 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 2BAA7800690;
	Tue,  5 Feb 2008 01:15:34 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 1EBC5290F2; Tue,  5 Feb 2008 01:15:34 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
In-Reply-To: <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72597>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../.settings/org.eclipse.jdt.core.prefs           |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
index fb1bc6e..fb77da2 100644
--- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
-#Wed May 16 23:05:36 EDT 2007
+#Sun Feb 03 03:52:00 CET 2008
 eclipse.preferences.version=1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
@@ -34,7 +34,7 @@ org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
 org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
 org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
 org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
-org.eclipse.jdt.core.compiler.problem.missingJavadocComments=warning
+org.eclipse.jdt.core.compiler.problem.missingJavadocComments=ignore
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
 org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
-- 
1.5.4.rc4.25.g81cc
