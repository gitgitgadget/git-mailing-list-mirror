From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 4/9] checkin all eclipse project file changes
Date: Wed, 23 Sep 2009 23:16:05 +0200
Message-ID: <1253740570-10718-4-git-send-email-struberg@yahoo.de>
References: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
 <1253740570-10718-2-git-send-email-struberg@yahoo.de>
 <1253740570-10718-3-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCK-0004af-Rq
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZIWVQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZIWVP6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:15:58 -0400
Received: from n9.bullet.re3.yahoo.com ([68.142.237.94]:38273 "HELO
	n9.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752741AbZIWVP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:15:58 -0400
Received: from [68.142.237.89] by n9.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:01 -0000
Received: from [66.196.97.155] by t5.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:01 -0000
Received: from [127.0.0.1] by omp208.mail.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:00 -0000
X-Yahoo-Newman-Id: 970065.27549.bm@omp208.mail.re3.yahoo.com
Received: (qmail 22245 invoked from network); 23 Sep 2009 21:16:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=vmzWomoMq/2lmxSgQCWOwIc4FVpgwahbiKqFujTGMj+QOUyyiBMo2fVj36d+l7EDHSQVk4T1U98ScvzkD8pCtvdIHfz8o+pOyNb/pCdgfNEaNowiSuYYXWTjz+KOhrzj84D/AdGGNgPn/s/Nkm8F1Yj6sFWc5z7NWKUX7k4UFtI=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:16:00 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: eonvgJwVM1n5lrGcTBqL0YiKq63bnxGu_w_u5ND4pAP1C8HxpTiei9ggAu1s76NzsIUm3P1lCg6ulCL0WD3iJq0KH3fZnemBtckvGvIiG3h.u3hTjVE_us4QjegK3SUh.HFyc3hxtmljW9adZ_Dn5NbOLZ.ttbYg22tVkXh.1RwfkHo2C5QtAGhPnh1GlrLOSRbelef3hwsbEhNkQnKXVmXDB5AuuwfjrJNor.wSfL_5NaNnh.Pz07htTNIgELob.RK39NzM8DoprFakvYXySBlVF5OO6gQxXQsCTGdfvSyqb77Gfvu3L.NN68AbWkoDfavar9G4T46Zj4G0aGT3QNfpTRJMO2u.1Ls-
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1253740570-10718-3-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129003>

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 org.spearce.jgit/.classpath                        |    7 +++++--
 org.spearce.jgit/.project                          |    6 ++++++
 .../.settings/org.eclipse.jdt.core.prefs           |    4 ++--
 .../.settings/org.maven.ide.eclipse.prefs          |    9 +++++++++
 org.spearce.jgit/build.properties                  |    6 +++---
 5 files changed, 25 insertions(+), 7 deletions(-)
 create mode 100644 org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs

diff --git a/org.spearce.jgit/.classpath b/org.spearce.jgit/.classpath
index 304e861..c1c8f51 100644
--- a/org.spearce.jgit/.classpath
+++ b/org.spearce.jgit/.classpath
@@ -1,7 +1,10 @@
 <?xml version="1.0" encoding="UTF-8"?>
 <classpath>
-	<classpathentry kind="src" path="src"/>
+	<classpathentry kind="src" output="target/classes" path="src/main/java"/>
+	<classpathentry kind="src" output="target/test-classes" path="src/test/java"/>
+	<classpathentry excluding="**" kind="src" output="target/test-classes" path="src/test/resources"/>
 	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/J2SE-1.5"/>
 	<classpathentry kind="con" path="org.eclipse.pde.core.requiredPlugins"/>
-	<classpathentry kind="output" path="bin"/>
+	<classpathentry kind="con" path="org.maven.ide.eclipse.MAVEN2_CLASSPATH_CONTAINER"/>
+	<classpathentry kind="output" path="target/classes"/>
 </classpath>
diff --git a/org.spearce.jgit/.project b/org.spearce.jgit/.project
index 7d38455..da2f7cf 100644
--- a/org.spearce.jgit/.project
+++ b/org.spearce.jgit/.project
@@ -20,8 +20,14 @@
 			<arguments>
 			</arguments>
 		</buildCommand>
+		<buildCommand>
+			<name>org.maven.ide.eclipse.maven2Builder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
 	</buildSpec>
 	<natures>
+		<nature>org.maven.ide.eclipse.maven2Nature</nature>
 		<nature>org.eclipse.jdt.core.javanature</nature>
 		<nature>org.eclipse.pde.PluginNature</nature>
 	</natures>
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
index 8e8e172..22d560f 100644
--- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
+++ b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
@@ -1,4 +1,4 @@
-#Sun Mar 15 01:13:43 CET 2009
+#Fri Sep 04 16:53:41 CEST 2009
 eclipse.preferences.version=1
 org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
 org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
@@ -34,7 +34,7 @@ org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
 org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
 org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
 org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
-org.eclipse.jdt.core.compiler.problem.missingJavadocComments=error
+org.eclipse.jdt.core.compiler.problem.missingJavadocComments=warning
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
 org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
 org.eclipse.jdt.core.compiler.problem.missingJavadocTagDescription=return_tag
diff --git a/org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs b/org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs
new file mode 100644
index 0000000..1e219ee
--- /dev/null
+++ b/org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs
@@ -0,0 +1,9 @@
+#Fri Sep 04 16:35:48 CEST 2009
+activeProfiles=
+eclipse.preferences.version=1
+fullBuildGoals=process-test-resources
+includeModules=false
+resolveWorkspaceProjects=true
+resourceFilterGoals=process-resources resources\:testResources
+skipCompilerPlugin=true
+version=1
diff --git a/org.spearce.jgit/build.properties b/org.spearce.jgit/build.properties
index aa1a008..b686345 100644
--- a/org.spearce.jgit/build.properties
+++ b/org.spearce.jgit/build.properties
@@ -1,5 +1,5 @@
-source.. = src/
-output.. = bin/
-bin.includes = META-INF/,\
+source.. = src/main/java/
+output.. = target/classes/
+bin.includes = src/main/resources/,\
                .,\
                plugin.properties
-- 
1.6.2.5
