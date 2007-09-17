From: Ben Konrath <bkonrath@redhat.com>
Subject: [EGIT PATCH] Add feature and plugin.
Date: Mon, 17 Sep 2007 14:53:11 -0400
Message-ID: <20070917185310.GA6042@toast.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 20:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXLiq-0007ej-GR
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 20:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbXIQSxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 14:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXIQSxQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 14:53:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46013 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbXIQSxO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 14:53:14 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8HIrDER030407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 14:53:13 -0400
Received: from pobox.toronto.redhat.com (pobox.toronto.redhat.com [172.16.14.4])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HIrCpd023407
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 14:53:12 -0400
Received: from touchme.toronto.redhat.com (IDENT:postfix@touchme.toronto.redhat.com [172.16.14.9])
	by pobox.toronto.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l8HIrBkC003147
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 14:53:12 -0400
Received: from toast.toronto.redhat.com (toast.toronto.redhat.com [172.16.14.221])
	by touchme.toronto.redhat.com (Postfix) with ESMTP id DBDB68001FF
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 14:53:11 -0400 (EDT)
Received: from toast.toronto.redhat.com (localhost.localdomain [127.0.0.1])
	by toast.toronto.redhat.com (8.14.1/8.13.0) with ESMTP id l8HIrBRX006248
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 14:53:11 -0400
Received: (from bkonrath@localhost)
	by toast.toronto.redhat.com (8.14.1/8.14.1/Submit) id l8HIrBYH006247
	for git@vger.kernel.org; Mon, 17 Sep 2007 14:53:11 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58468>

Hi,

I made a feature and associated branding plugin for Egit. Including
these two plugins allows us to build Egit for Fedora but it also makes
it easy to create an update site for Egit. These two plugins also add an
entry for Egit in Help -> About Eclipse -> Feature Details. 

This is an updated version of the patch that I originally sent privately to 
Robin Rosenberg. Comments are appreciated.

Cheers, Ben

Signed-off-by: Ben Konrath <bkonrath@redhat.com>

---
 org.spearce.egit-feature/.project         |   17 +++++++++
 org.spearce.egit-feature/build.properties |    1 +
 org.spearce.egit-feature/feature.xml      |   51 +++++++++++++++++++++++++++++
 org.spearce.egit/.classpath               |    6 +++
 org.spearce.egit/.project                 |   28 ++++++++++++++++
 org.spearce.egit/META-INF/MANIFEST.MF     |    7 ++++
 org.spearce.egit/about.ini                |   28 ++++++++++++++++
 org.spearce.egit/build.properties         |    3 ++
 org.spearce.egit/egit.png                 |  Bin 0 -> 226 bytes
 9 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit-feature/.project
 create mode 100644 org.spearce.egit-feature/build.properties
 create mode 100644 org.spearce.egit-feature/feature.xml
 create mode 100644 org.spearce.egit/.classpath
 create mode 100644 org.spearce.egit/.project
 create mode 100644 org.spearce.egit/META-INF/MANIFEST.MF
 create mode 100644 org.spearce.egit/about.ini
 create mode 100644 org.spearce.egit/build.properties
 create mode 100644 org.spearce.egit/egit.png

diff --git a/org.spearce.egit-feature/.project b/org.spearce.egit-feature/.project
new file mode 100644
index 0000000..dac8f65
--- /dev/null
+++ b/org.spearce.egit-feature/.project
@@ -0,0 +1,17 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<projectDescription>
+	<name>org.spearce.egit-feature</name>
+	<comment></comment>
+	<projects>
+	</projects>
+	<buildSpec>
+		<buildCommand>
+			<name>org.eclipse.pde.FeatureBuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+	</buildSpec>
+	<natures>
+		<nature>org.eclipse.pde.FeatureNature</nature>
+	</natures>
+</projectDescription>
diff --git a/org.spearce.egit-feature/build.properties b/org.spearce.egit-feature/build.properties
new file mode 100644
index 0000000..64f93a9
--- /dev/null
+++ b/org.spearce.egit-feature/build.properties
@@ -0,0 +1 @@
+bin.includes = feature.xml
diff --git a/org.spearce.egit-feature/feature.xml b/org.spearce.egit-feature/feature.xml
new file mode 100644
index 0000000..8c98143
--- /dev/null
+++ b/org.spearce.egit-feature/feature.xml
@@ -0,0 +1,51 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<feature
+      id="org.spearce.egit"
+      label="Eclipse Git Feature"
+      version="0.2.2"
+      provider-name="spearce.org"
+      plugin="org.spearce.egit">
+
+   <requires>
+      <import plugin="org.eclipse.core.runtime"/>
+      <import plugin="org.eclipse.team.core"/>
+      <import plugin="org.eclipse.core.resources"/>
+      <import plugin="org.eclipse.core.filesystem"/>
+      <import plugin="org.eclipse.ui"/>
+      <import plugin="org.eclipse.team.ui"/>
+      <import plugin="org.eclipse.jface.text"/>
+      <import plugin="org.eclipse.ui.ide"/>
+      <import plugin="org.eclipse.ui.workbench.texteditor"/>
+      <import plugin="org.eclipse.compare"/>
+      <import plugin="org.junit"/>
+   </requires>
+
+   <plugin
+         id="org.spearce.egit.core"
+         download-size="0"
+         install-size="0"
+         version="0.0.0"
+         unpack="false"/>
+
+   <plugin
+         id="org.spearce.egit.ui"
+         download-size="0"
+         install-size="0"
+         version="0.0.0"
+         unpack="false"/>
+
+   <plugin
+         id="org.spearce.egit"
+         download-size="0"
+         install-size="0"
+         version="0.0.0"
+         unpack="false"/>
+
+   <plugin
+         id="org.spearce.jgit"
+         download-size="0"
+         install-size="0"
+         version="0.0.0"
+         unpack="false"/>
+
+</feature>
diff --git a/org.spearce.egit/.classpath b/org.spearce.egit/.classpath
new file mode 100644
index 0000000..acad1c2
--- /dev/null
+++ b/org.spearce.egit/.classpath
@@ -0,0 +1,6 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<classpath>
+	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
+	<classpathentry kind="con" path="org.eclipse.pde.core.requiredPlugins"/>
+	<classpathentry kind="output" path="bin"/>
+</classpath>
diff --git a/org.spearce.egit/.project b/org.spearce.egit/.project
new file mode 100644
index 0000000..bbdc4e3
--- /dev/null
+++ b/org.spearce.egit/.project
@@ -0,0 +1,28 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<projectDescription>
+	<name>org.spearce.egit</name>
+	<comment></comment>
+	<projects>
+	</projects>
+	<buildSpec>
+		<buildCommand>
+			<name>org.eclipse.jdt.core.javabuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+		<buildCommand>
+			<name>org.eclipse.pde.ManifestBuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+		<buildCommand>
+			<name>org.eclipse.pde.SchemaBuilder</name>
+			<arguments>
+			</arguments>
+		</buildCommand>
+	</buildSpec>
+	<natures>
+		<nature>org.eclipse.pde.PluginNature</nature>
+		<nature>org.eclipse.jdt.core.javanature</nature>
+	</natures>
+</projectDescription>
diff --git a/org.spearce.egit/META-INF/MANIFEST.MF b/org.spearce.egit/META-INF/MANIFEST.MF
new file mode 100644
index 0000000..40da4e0
--- /dev/null
+++ b/org.spearce.egit/META-INF/MANIFEST.MF
@@ -0,0 +1,7 @@
+Manifest-Version: 1.0
+Bundle-ManifestVersion: 2
+Bundle-Name: Java Git / Eclipse Git
+Bundle-SymbolicName: org.spearce.egit
+Bundle-Version: 0.2.2
+Bundle-Vendor: spearce.org
+Bundle-RequiredExecutionEnvironment: J2SE-1.5
diff --git a/org.spearce.egit/about.ini b/org.spearce.egit/about.ini
new file mode 100644
index 0000000..dcab31a
--- /dev/null
+++ b/org.spearce.egit/about.ini
@@ -0,0 +1,28 @@
+# about.ini
+# contains information about a feature
+# java.io.Properties file (ISO 8859-1 with "\" escapes)
+# "%key" are externalized strings defined in about.properties
+# This file does not need to be translated.
+
+# Property "aboutText" contains blurb for "About" dialog (translated)
+aboutText=Java Git / Eclipse Git (by Shawn Pearce) is a Java Git library and plugin for the Eclipse IDE.
+
+# Property "windowImage" contains path to window icon (16x16)
+# needed for primary features only
+
+# Property "featureImage" contains path to feature image (32x32)
+featureImage=egit.png
+
+# Property "aboutImage" contains path to product image (500x330 or 115x164)
+# needed for primary features only
+
+# Property "appName" contains name of the application (not translated)
+# needed for primary features only
+
+# Property "welcomePerspective" contains the id of the perspective in which the
+# welcome page is to be opened.
+# optional
+
+# Property "tipsAndTricksHref" contains the Help topic href to a tips and tricks page 
+# optional
+# tipsAndTricksHref=/org.eclipse.jdt.doc.user/tips/jdt_tips.html
\ No newline at end of file
diff --git a/org.spearce.egit/build.properties b/org.spearce.egit/build.properties
new file mode 100644
index 0000000..22d4e45
--- /dev/null
+++ b/org.spearce.egit/build.properties
@@ -0,0 +1,3 @@
+bin.includes = META-INF/,\
+               egit.png,\
+               about.ini
diff --git a/org.spearce.egit/egit.png b/org.spearce.egit/egit.png
new file mode 100644
index 0000000000000000000000000000000000000000..6782d4ab9b757aaa2c3d5edad42215ea02456836
GIT binary patch
literal 226
zc%17D@N?(olHy`uVBq!ia0vp^3LwnE1SJ1Ryj={WI14-?iy0XB6G519h5hnOpdfpR
zr>`sfbxuJ+YqhJ4<#s?J*%H@?66gHf+|;}h2Ir#G#FEq$h4Rdj426)4R0VfW-+=ci
zs(C<#5uPrNAs)xyPT9%JpuoeNd?c=?O``XtkE8f5g?WeG?ReJX!Qg2<Go@X*kws`m
zYWcec<yM{#)#eTV7R_Mb&A9PgU#?R3&?$y`+hv=lzZQBBWx}a4;eqf$hBiiBN4x4B
Rwm>@=JYD@<);T3K0RS$@N4)?5

literal 0
Hc$@<O00001

-- 
1.5.2.4
