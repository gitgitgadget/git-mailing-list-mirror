From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Require JDK1.5
Date: Mon, 14 May 2007 01:48:54 +0200
Message-ID: <11791001343234-git-send-email-robin.rosenberg@dewire.com>
References: <11790995571082-git-send-email-robin.rosenberg@dewire.com>
 <1179100134893-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 14 02:16:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOEK-00082a-9T
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbXENAP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757916AbXENAP5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:15:57 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23588 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbXENAP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:15:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0BFC082758E;
	Mon, 14 May 2007 01:42:37 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06109-02; Mon, 14 May 2007 01:42:35 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 4F2E68028BD;
	Mon, 14 May 2007 01:42:35 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 800B42815D; Mon, 14 May 2007 01:48:54 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <1179100134893-git-send-email-robin.rosenberg@dewire.com>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47202>

This changes project settings to requre Java 5 and
also tightens some compiler settings.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
 .../.settings/org.eclipse.jdt.ui.prefs             |    5 +--
 .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
 .../.settings/org.eclipse.jdt.ui.prefs             |    5 +--
 .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
 .../.settings/org.eclipse.jdt.ui.prefs             |    5 +--
 .../.settings/org.eclipse.jdt.core.prefs           |   22 ++++++++++---------
 .../.settings/org.eclipse.jdt.ui.prefs             |    3 +-
 .../src/org/spearce/jgit/lib/ObjectIdMap.java      |    4 +-
 9 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
index 16fbddc..261f937 100644
--- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
@@ -1,16 +1,16 @@
-#Mon Jan 29 20:50:25 EST 2007
+#Wed May 09 00:26:39 CEST 2007
 eclipse.preferences.version=1
-org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=disabled
-org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.4
+org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
+org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
 org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
-org.eclipse.jdt.core.compiler.compliance=1.4
+org.eclipse.jdt.core.compiler.compliance=1.5
 org.eclipse.jdt.core.compiler.debug.lineNumber=generate
 org.eclipse.jdt.core.compiler.debug.localVariable=generate
 org.eclipse.jdt.core.compiler.debug.sourceFile=generate
 org.eclipse.jdt.core.compiler.doc.comment.support=enabled
 org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
 org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
-org.eclipse.jdt.core.compiler.problem.autoboxing=ignore
+org.eclipse.jdt.core.compiler.problem.autoboxing=warning
 org.eclipse.jdt.core.compiler.problem.deprecation=warning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
@@ -24,7 +24,7 @@ org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
 org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
 org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
 org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
-org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=ignore
+org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
 org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
@@ -45,11 +45,13 @@ org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
 org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
 org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
 org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
-org.eclipse.jdt.core.compiler.problem.nullReference=warning
+org.eclipse.jdt.core.compiler.problem.nullReference=error
 org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
-org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
+org.eclipse.jdt.core.compiler.problem.parameterAssignment=warning
 org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
+org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
 org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
+org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
@@ -60,7 +62,7 @@ org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
-org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
+org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=warning
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.unusedImport=error
@@ -71,7 +73,7 @@ org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=di
 org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
 org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
 org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
-org.eclipse.jdt.core.compiler.source=1.4
+org.eclipse.jdt.core.compiler.source=1.5
 org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.ui.prefs
index 273e64b..709a440 100644
--- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.ui.prefs
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.ui.prefs
@@ -1,8 +1,7 @@
-#Mon Jan 29 20:38:19 EST 2007
+#Wed May 09 00:20:24 CEST 2007
 eclipse.preferences.version=1
-formatter_profile=_EGit
+formatter_profile=_JGit
 formatter_settings_version=10
-internal.default.compliance=user
 org.eclipse.jdt.ui.ignorelowercasenames=true
 org.eclipse.jdt.ui.importorder=java;javax;org;com;
 org.eclipse.jdt.ui.ondemandthreshold=99
diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
index 16fbddc..261f937 100644
--- a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
@@ -1,16 +1,16 @@
-#Mon Jan 29 20:50:25 EST 2007
+#Wed May 09 00:26:39 CEST 2007
 eclipse.preferences.version=1
-org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=disabled
-org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.4
+org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
+org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
 org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
-org.eclipse.jdt.core.compiler.compliance=1.4
+org.eclipse.jdt.core.compiler.compliance=1.5
 org.eclipse.jdt.core.compiler.debug.lineNumber=generate
 org.eclipse.jdt.core.compiler.debug.localVariable=generate
 org.eclipse.jdt.core.compiler.debug.sourceFile=generate
 org.eclipse.jdt.core.compiler.doc.comment.support=enabled
 org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
 org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
-org.eclipse.jdt.core.compiler.problem.autoboxing=ignore
+org.eclipse.jdt.core.compiler.problem.autoboxing=warning
 org.eclipse.jdt.core.compiler.problem.deprecation=warning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
@@ -24,7 +24,7 @@ org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
 org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
 org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
 org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
-org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=ignore
+org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
 org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
@@ -45,11 +45,13 @@ org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
 org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
 org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
 org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
-org.eclipse.jdt.core.compiler.problem.nullReference=warning
+org.eclipse.jdt.core.compiler.problem.nullReference=error
 org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
-org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
+org.eclipse.jdt.core.compiler.problem.parameterAssignment=warning
 org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
+org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
 org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
+org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
@@ -60,7 +62,7 @@ org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
-org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
+org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=warning
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.unusedImport=error
@@ -71,7 +73,7 @@ org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=di
 org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
 org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
 org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
-org.eclipse.jdt.core.compiler.source=1.4
+org.eclipse.jdt.core.compiler.source=1.5
 org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.egit.core/.settings/org.eclipse.jdt.ui.prefs
index 273e64b..709a440 100644
--- a/org.spearce.egit.core/.settings/org.eclipse.jdt.ui.prefs
+++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.ui.prefs
@@ -1,8 +1,7 @@
-#Mon Jan 29 20:38:19 EST 2007
+#Wed May 09 00:20:24 CEST 2007
 eclipse.preferences.version=1
-formatter_profile=_EGit
+formatter_profile=_JGit
 formatter_settings_version=10
-internal.default.compliance=user
 org.eclipse.jdt.ui.ignorelowercasenames=true
 org.eclipse.jdt.ui.importorder=java;javax;org;com;
 org.eclipse.jdt.ui.ondemandthreshold=99
diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
index 71b6be1..261f937 100644
--- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
@@ -1,16 +1,16 @@
-#Mon Jan 29 20:50:36 EST 2007
+#Wed May 09 00:26:39 CEST 2007
 eclipse.preferences.version=1
-org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=disabled
-org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.4
+org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
+org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
 org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
-org.eclipse.jdt.core.compiler.compliance=1.4
+org.eclipse.jdt.core.compiler.compliance=1.5
 org.eclipse.jdt.core.compiler.debug.lineNumber=generate
 org.eclipse.jdt.core.compiler.debug.localVariable=generate
 org.eclipse.jdt.core.compiler.debug.sourceFile=generate
 org.eclipse.jdt.core.compiler.doc.comment.support=enabled
 org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
 org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
-org.eclipse.jdt.core.compiler.problem.autoboxing=ignore
+org.eclipse.jdt.core.compiler.problem.autoboxing=warning
 org.eclipse.jdt.core.compiler.problem.deprecation=warning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
@@ -24,7 +24,7 @@ org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
 org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
 org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
 org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
-org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=ignore
+org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
 org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
@@ -45,11 +45,13 @@ org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
 org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
 org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
 org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
-org.eclipse.jdt.core.compiler.problem.nullReference=warning
+org.eclipse.jdt.core.compiler.problem.nullReference=error
 org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
-org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
+org.eclipse.jdt.core.compiler.problem.parameterAssignment=warning
 org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
+org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
 org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
+org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
@@ -60,7 +62,7 @@ org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
-org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
+org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=warning
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.unusedImport=error
@@ -71,7 +73,7 @@ org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=di
 org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
 org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
 org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
-org.eclipse.jdt.core.compiler.source=1.4
+org.eclipse.jdt.core.compiler.source=1.5
 org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.egit.ui/.settings/org.eclipse.jdt.ui.prefs
index e6430e9..709a440 100644
--- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.ui.prefs
+++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.ui.prefs
@@ -1,8 +1,7 @@
-#Mon Jan 29 20:38:13 EST 2007
+#Wed May 09 00:20:24 CEST 2007
 eclipse.preferences.version=1
-formatter_profile=_EGit
+formatter_profile=_JGit
 formatter_settings_version=10
-internal.default.compliance=user
 org.eclipse.jdt.ui.ignorelowercasenames=true
 org.eclipse.jdt.ui.importorder=java;javax;org;com;
 org.eclipse.jdt.ui.ondemandthreshold=99
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
index bfbc85d..261f937 100644
--- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
@@ -1,16 +1,16 @@
-#Mon Jan 29 20:50:45 EST 2007
+#Wed May 09 00:26:39 CEST 2007
 eclipse.preferences.version=1
-org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=disabled
-org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.4
+org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
+org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
 org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
-org.eclipse.jdt.core.compiler.compliance=1.4
+org.eclipse.jdt.core.compiler.compliance=1.5
 org.eclipse.jdt.core.compiler.debug.lineNumber=generate
 org.eclipse.jdt.core.compiler.debug.localVariable=generate
 org.eclipse.jdt.core.compiler.debug.sourceFile=generate
 org.eclipse.jdt.core.compiler.doc.comment.support=enabled
 org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
 org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
-org.eclipse.jdt.core.compiler.problem.autoboxing=ignore
+org.eclipse.jdt.core.compiler.problem.autoboxing=warning
 org.eclipse.jdt.core.compiler.problem.deprecation=warning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
@@ -24,7 +24,7 @@ org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
 org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
 org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
 org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
-org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=ignore
+org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
 org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
 org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
@@ -45,11 +45,13 @@ org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
 org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
 org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
 org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
-org.eclipse.jdt.core.compiler.problem.nullReference=warning
+org.eclipse.jdt.core.compiler.problem.nullReference=error
 org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
-org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
+org.eclipse.jdt.core.compiler.problem.parameterAssignment=warning
 org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
+org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
 org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
+org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
 org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
 org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
 org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
@@ -60,7 +62,7 @@ org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryElse=warning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
-org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
+org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=warning
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=error
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.unusedImport=error
@@ -71,7 +73,7 @@ org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=di
 org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
 org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
 org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
-org.eclipse.jdt.core.compiler.source=1.4
+org.eclipse.jdt.core.compiler.source=1.5
 org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
 org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
index 126418a..709a440 100644
--- a/org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
+++ b/org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
@@ -1,8 +1,7 @@
-#Mon Jan 29 20:38:06 EST 2007
+#Wed May 09 00:20:24 CEST 2007
 eclipse.preferences.version=1
 formatter_profile=_JGit
 formatter_settings_version=10
-internal.default.compliance=user
 org.eclipse.jdt.ui.ignorelowercasenames=true
 org.eclipse.jdt.ui.importorder=java;javax;org;com;
 org.eclipse.jdt.ui.ondemandthreshold=99
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
index c397a0d..63796fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectIdMap.java
@@ -50,9 +50,9 @@ public class ObjectIdMap implements Map {
 
 	public ObjectIdMap(Map sample) {
 		try {
-			Method m=sample.getClass().getMethod("clone", null);
+			Method m=sample.getClass().getMethod("clone", (Class[])null);
 			for (int i=0; i<256; ++i) {
-				level0[i] = (Map)m.invoke(sample, null);
+				level0[i] = (Map)m.invoke(sample, (Object[])null);
 			}
 		} catch (IllegalAccessException e) {
 			throw new IllegalArgumentException(e);
-- 
1.5.1.1
