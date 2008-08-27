From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [EGIT PATCH] Add some known version requirements to dependencies
Date: Thu, 28 Aug 2008 00:31:29 +0200
Message-ID: <200808280031.30189.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:34:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTb6-0000an-5k
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbYH0Wdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 18:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbYH0Wdf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:33:35 -0400
Received: from av11-1-sn2.hy.skanova.net ([81.228.8.183]:36828 "EHLO
	av11-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYH0Wdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:33:35 -0400
Received: by av11-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 9DFA637FBE; Thu, 28 Aug 2008 00:33:33 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av11-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 819C837F56; Thu, 28 Aug 2008 00:33:33 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 456C537E45;
	Thu, 28 Aug 2008 00:33:33 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93971>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit-feature/feature.xml     |    9 ++++++---
 org.spearce.egit.ui/META-INF/MANIFEST.MF |    4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/org.spearce.egit-feature/feature.xml b/org.spearce.egit-feature/feature.xml
index 3c9836e..9187ded 100644
--- a/org.spearce.egit-feature/feature.xml
+++ b/org.spearce.egit-feature/feature.xml
@@ -297,8 +297,7 @@ litigation.
    </url>
 
    <requires>
-      <import plugin="org.eclipse.core.runtime" version="3.2" match="greaterOrEqual"/>
-      <import plugin="org.eclipse.team.core"/>
+      <import plugin="org.eclipse.core.runtime" version="3.4" match="greaterOrEqual"/>
       <import plugin="org.eclipse.core.resources"/>
       <import plugin="org.eclipse.core.filesystem"/>
       <import plugin="org.eclipse.ui"/>
@@ -307,7 +306,11 @@ litigation.
       <import plugin="org.eclipse.ui.ide"/>
       <import plugin="org.eclipse.ui.workbench.texteditor"/>
       <import plugin="org.eclipse.compare"/>
-      <import plugin="org.junit"/>
+      <import plugin="org.eclipse.core.net"/>
+      <import plugin="org.eclipse.team.core" version="3.4.0" match="greaterOrEqual"/>
+      <import plugin="org.eclipse.jsch.ui" version="1.1.100" match="greaterOrEqual"/>
+      <import plugin="org.eclipse.jsch.core"/>
+      <import plugin="com.jcraft.jsch"/>
    </requires>
 
    <plugin
diff --git a/org.spearce.egit.ui/META-INF/MANIFEST.MF b/org.spearce.egit.ui/META-INF/MANIFEST.MF
index 62afd51..ec1df4d 100644
--- a/org.spearce.egit.ui/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.ui/META-INF/MANIFEST.MF
@@ -11,7 +11,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.core.filesystem,
  org.eclipse.core.net,
  org.eclipse.ui,
- org.eclipse.team.core,
+ org.eclipse.team.core;bundle-version="3.4.0",
  org.eclipse.team.ui,
  org.eclipse.jface.text,
  org.eclipse.ui.ide,
@@ -19,7 +19,7 @@ Require-Bundle: org.eclipse.core.runtime,
  org.eclipse.compare,
  org.spearce.jgit,
  org.spearce.egit.core,
- org.eclipse.jsch.ui
+ org.eclipse.jsch.ui;bundle-version="1.1.100"
 Eclipse-LazyStart: true
 Bundle-RequiredExecutionEnvironment: J2SE-1.5
 Import-Package: org.eclipse.jsch.core,
-- 
1.6.0.rc2.35.g04c6e9
