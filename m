From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Comment private modifier to improve performace.
Date: Sun, 3 Feb 2008 03:26:39 +0100
Message-ID: <200802030326.40446.robin.rosenberg@dewire.com>
References: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br> <200802030201.10971.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gZSpH/aHjgq1Uss"
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Feb 03 03:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLUZf-0005iz-69
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 03:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbYBCC0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 21:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYBCC0k
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 21:26:40 -0500
Received: from [83.140.172.130] ([83.140.172.130]:25079 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbYBCC0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 21:26:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 05D8B800683;
	Sun,  3 Feb 2008 03:26:36 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ECbPFUVqOznH; Sun,  3 Feb 2008 03:26:31 +0100 (CET)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id A1F0B80019B;
	Sun,  3 Feb 2008 03:26:31 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200802030201.10971.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72317>

--Boundary-00=_gZSpH/aHjgq1Uss
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


We could drop these settings from the projects too. 

-- robin

--Boundary-00=_gZSpH/aHjgq1Uss
Content-Type: text/x-diff;
  charset="utf-8";
  name="0002-Make-it-possible-to-ignore-warnings-about-discourage.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Make-it-possible-to-ignore-warnings-about-discourage.patch"

=46rom a1aed72a122a05d01ed57db5d51b45debeb247b7 Mon Sep 17 00:00:00 2001
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sun, 3 Feb 2008 03:13:44 +0100
Subject: [PATCH] Make it possible to ignore warnings about discouraged acce=
ss

By removing the setting from the project the workspace settings
will be applied (default: Warning)

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
=2D--
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.pref=
s b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
index 7a0fbe4..1c978ca 100644
=2D-- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
@@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=3Ddisabl=
ed
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedM=
ethod=3Ddisabled
=2Dorg.eclipse.jdt.core.compiler.problem.discouragedReference=3Dwarning
 org.eclipse.jdt.core.compiler.problem.emptyStatement=3Dwarning
 org.eclipse.jdt.core.compiler.problem.enumIdentifier=3Derror
 org.eclipse.jdt.core.compiler.problem.fallthroughCase=3Dwarning
diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs b/o=
rg.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
index bcde160..2afc050 100644
=2D-- a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
@@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=3Ddisabl=
ed
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedM=
ethod=3Ddisabled
=2Dorg.eclipse.jdt.core.compiler.problem.discouragedReference=3Dwarning
 org.eclipse.jdt.core.compiler.problem.emptyStatement=3Dwarning
 org.eclipse.jdt.core.compiler.problem.enumIdentifier=3Derror
 org.eclipse.jdt.core.compiler.problem.fallthroughCase=3Dwarning
diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs b/org=
=2Espearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
index 0a89f52..0da92c7 100644
=2D-- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
@@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=3Ddisabl=
ed
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedM=
ethod=3Ddisabled
=2Dorg.eclipse.jdt.core.compiler.problem.discouragedReference=3Dwarning
 org.eclipse.jdt.core.compiler.problem.emptyStatement=3Dwarning
 org.eclipse.jdt.core.compiler.problem.enumIdentifier=3Derror
 org.eclipse.jdt.core.compiler.problem.fallthroughCase=3Dwarning
diff --git a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs b/o=
rg.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
index c203c20..9adf651 100644
=2D-- a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
@@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=3Ddisabl=
ed
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedM=
ethod=3Ddisabled
=2Dorg.eclipse.jdt.core.compiler.problem.discouragedReference=3Dwarning
 org.eclipse.jdt.core.compiler.problem.emptyStatement=3Dwarning
 org.eclipse.jdt.core.compiler.problem.enumIdentifier=3Derror
 org.eclipse.jdt.core.compiler.problem.fallthroughCase=3Dwarning
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.sp=
earce.jgit/.settings/org.eclipse.jdt.core.prefs
index b0c694c..faecf76 100644
=2D-- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
@@ -14,7 +14,6 @@ org.eclipse.jdt.core.compiler.problem.autoboxing=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=3Ddisabl=
ed
 org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedM=
ethod=3Ddisabled
=2Dorg.eclipse.jdt.core.compiler.problem.discouragedReference=3Dwarning
 org.eclipse.jdt.core.compiler.problem.emptyStatement=3Dwarning
 org.eclipse.jdt.core.compiler.problem.enumIdentifier=3Derror
 org.eclipse.jdt.core.compiler.problem.fallthroughCase=3Dwarning
=2D-=20
1.5.4.rc4.25.g81cc


--Boundary-00=_gZSpH/aHjgq1Uss
Content-Type: text/x-diff;
  charset="utf-8";
  name="0003-Drop-warnings-about-unnecessary-else.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-Drop-warnings-about-unnecessary-else.patch"

=46rom e9f312599eb5941a7bf1acd70c6f0ac9fb1ea889 Mon Sep 17 00:00:00 2001
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sun, 3 Feb 2008 03:19:09 +0100
Subject: [PATCH] Drop warnings about unnecessary else

Use workspace setting, default ignore.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
=2D--
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    1 -
 .../.settings/org.eclipse.jdt.core.prefs           |    3 +--
 5 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.pref=
s b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
index 1c978ca..7279d81 100644
=2D-- a/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core.test/.settings/org.eclipse.jdt.core.prefs
@@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=
=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=3Dwarning
=2Dorg.eclipse.jdt.core.compiler.problem.unnecessaryElse=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=3Derror
 org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=3Dignore
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=3Derror
diff --git a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs b/o=
rg.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
index 2afc050..2d94530 100644
=2D-- a/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.core/.settings/org.eclipse.jdt.core.prefs
@@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=
=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=3Dwarning
=2Dorg.eclipse.jdt.core.compiler.problem.unnecessaryElse=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=3Derror
 org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=3Dignore
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=3Derror
diff --git a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs b/org=
=2Espearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
index 0da92c7..ff09222 100644
=2D-- a/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.egit.ui/.settings/org.eclipse.jdt.core.prefs
@@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=
=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=3Dwarning
=2Dorg.eclipse.jdt.core.compiler.problem.unnecessaryElse=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=3Derror
 org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=3Dignore
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=3Derror
diff --git a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs b/o=
rg.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
index 9adf651..b93093f 100644
=2D-- a/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit.test/.settings/org.eclipse.jdt.core.prefs
@@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=
=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=3Dwarning
=2Dorg.eclipse.jdt.core.compiler.problem.unnecessaryElse=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=3Derror
 org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=3Dignore
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=3Derror
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.sp=
earce.jgit/.settings/org.eclipse.jdt.core.prefs
index faecf76..4a5d15f 100644
=2D-- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
=2D#Tue Dec 18 01:35:52 CET 2007
+#Sun Feb 03 03:16:45 CET 2008
 eclipse.preferences.version=3D1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=3Denabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=3D1.5
@@ -58,7 +58,6 @@ org.eclipse.jdt.core.compiler.problem.typeParameterHiding=
=3Dwarning
 org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=3Dwarning
 org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=3Dwarning
=2Dorg.eclipse.jdt.core.compiler.problem.unnecessaryElse=3Dwarning
 org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=3Derror
 org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=3Dignore
 org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=3Derror
=2D-=20
1.5.4.rc4.25.g81cc


--Boundary-00=_gZSpH/aHjgq1Uss--
