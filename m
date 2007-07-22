From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [QGIT4 PATCH 1/6] update patchview.ui with new qt designer
Date: Sun, 22 Jul 2007 14:50:47 +0200
Message-ID: <20070723204317.074D528ABA1@mail-in-07.arcor-online.net>
References: <200707232232.39546.kumbayo84@arcor.de>
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4kX-0008HW-Bo
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765029AbXGWUnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXGWUnU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:43:20 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52950 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756791AbXGWUnS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:43:18 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 559651BB226;
	Mon, 23 Jul 2007 22:43:17 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 3DABF114336;
	Mon, 23 Jul 2007 22:43:17 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 074D528ABA1;
	Mon, 23 Jul 2007 22:43:17 +0200 (CEST)
X-Mailbox-Line: From 6f740d2af1e938ffe5072b9d7ca57b80fc8f3899 Mon Sep 17 00:00:00 2001
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53475>

---
 src/patchview.ui |   57 ++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/src/patchview.ui b/src/patchview.ui
index 1539242..a599e09 100644
--- a/src/patchview.ui
+++ b/src/patchview.ui
@@ -13,28 +13,55 @@
    <string>Patch</string>
   </property>
   <layout class="QHBoxLayout" >
-   <property name="margin" >
+   <property name="spacing" >
     <number>0</number>
    </property>
-   <property name="spacing" >
+   <property name="leftMargin" >
+    <number>0</number>
+   </property>
+   <property name="topMargin" >
+    <number>0</number>
+   </property>
+   <property name="rightMargin" >
+    <number>0</number>
+   </property>
+   <property name="bottomMargin" >
     <number>0</number>
    </property>
    <item>
     <layout class="QVBoxLayout" >
-     <property name="margin" >
-      <number>0</number>
-     </property>
      <property name="spacing" >
       <number>6</number>
      </property>
+     <property name="leftMargin" >
+      <number>0</number>
+     </property>
+     <property name="topMargin" >
+      <number>0</number>
+     </property>
+     <property name="rightMargin" >
+      <number>0</number>
+     </property>
+     <property name="bottomMargin" >
+      <number>0</number>
+     </property>
      <item>
       <layout class="QHBoxLayout" >
-       <property name="margin" >
-        <number>2</number>
-       </property>
        <property name="spacing" >
         <number>6</number>
        </property>
+       <property name="leftMargin" >
+        <number>2</number>
+       </property>
+       <property name="topMargin" >
+        <number>2</number>
+       </property>
+       <property name="rightMargin" >
+        <number>2</number>
+       </property>
+       <property name="bottomMargin" >
+        <number>2</number>
+       </property>
        <item>
         <widget class="QLabel" name="textLabel" >
          <property name="text" >
@@ -112,9 +139,7 @@
        <item>
         <widget class="QLineEdit" name="lineEditDiff" >
          <property name="sizePolicy" >
-          <sizepolicy>
-           <hsizetype>7</hsizetype>
-           <vsizetype>0</vsizetype>
+          <sizepolicy vsizetype="Fixed" hsizetype="Expanding" >
            <horstretch>1</horstretch>
            <verstretch>0</verstretch>
           </sizepolicy>
@@ -143,9 +168,7 @@
        </property>
        <widget class="QSplitter" name="splitter" >
         <property name="sizePolicy" >
-         <sizepolicy>
-          <hsizetype>5</hsizetype>
-          <vsizetype>7</vsizetype>
+         <sizepolicy vsizetype="Expanding" hsizetype="Preferred" >
           <horstretch>5</horstretch>
           <verstretch>0</verstretch>
          </sizepolicy>
@@ -169,15 +192,13 @@
           <bool>true</bool>
          </property>
          <property name="textInteractionFlags" >
-          <enum>Qt::TextSelectableByMouse</enum>
+          <set>Qt::TextSelectableByMouse</set>
          </property>
         </widget>
        </widget>
        <widget class="FileList" name="fileList" >
         <property name="sizePolicy" >
-         <sizepolicy>
-          <hsizetype>13</hsizetype>
-          <vsizetype>13</vsizetype>
+         <sizepolicy vsizetype="Ignored" hsizetype="Ignored" >
           <horstretch>1</horstretch>
           <verstretch>0</verstretch>
          </sizepolicy>
-- 
1.5.3.rc2.30.g1fe72
