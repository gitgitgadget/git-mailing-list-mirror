From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v6 5a/7] Warn for unlocalized string literals in ui plugin.
Date: Sun, 14 Jun 2009 21:47:27 +0200
Message-ID: <1245008849-12132-1-git-send-email-robin.rosenberg@dewire.com>
References: <20090612200228.GR16497@spearce.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 14 21:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFvgM-0004ct-D4
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760847AbZFNTrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 15:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758002AbZFNTrf
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 15:47:35 -0400
Received: from mail.dewire.com ([83.140.172.130]:2882 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbZFNTrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 15:47:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8BDEF147D5BB;
	Sun, 14 Jun 2009 21:47:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1kFo5v++9Ur; Sun, 14 Jun 2009 21:47:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 37102146D006;
	Sun, 14 Jun 2009 21:47:31 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <20090612200228.GR16497@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121558>

Other changes are Eclipse 3.4 defaults.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../.settings/org.eclipse.jdt.core.prefs           |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
index 6b39a92..b52927e 100644
--- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
-#Sun Apr 06 22:05:18 CEST 2008
+#Sun Jun 14 18:21:07 CEST 2009
 eclipse.preferences.version=1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
@@ -18,6 +18,7 @@ org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
 org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
 org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
 org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
+org.eclipse.jdt.core.compiler.problem.fatalOptionalError=enabled
 org.eclipse.jdt.core.compiler.problem.fieldHiding=warning
 org.eclipse.jdt.core.compiler.problem.finalParameterBound=warning
 org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
@@ -44,7 +45,7 @@ org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
 org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
 org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
 org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
-org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
+org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=warning
 org.eclipse.jdt.core.compiler.problem.nullReference=error
 org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
 org.eclipse.jdt.core.compiler.problem.parameterAssignment=warning
@@ -52,24 +53,31 @@ org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
 org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
 org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
 org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
+org.eclipse.jdt.core.compiler.problem.redundantSuperinterface=ignore
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
+org.eclipse.jdt.core.compiler.problem.syntheticAccessEmulation=ignore
 org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
+org.eclipse.jdt.core.compiler.problem.unnecessaryElse=ignore
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
 org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionExemptExceptionAndThrowable=enabled
+org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionIncludeDocCommentReference=enabled
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.unusedImport=error
 org.eclipse.jdt.core.compiler.problem.unusedLabel=error
 org.eclipse.jdt.core.compiler.problem.unusedLocal=error
 org.eclipse.jdt.core.compiler.problem.unusedParameter=warning
+org.eclipse.jdt.core.compiler.problem.unusedParameterIncludeDocCommentReference=enabled
 org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=disabled
 org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
 org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
+org.eclipse.jdt.core.compiler.problem.unusedWarningToken=warning
 org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
 org.eclipse.jdt.core.compiler.source=1.5
 org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
-- 
1.6.3.2.199.g7340d
