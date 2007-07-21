From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [QGIT4 PATCH 3/6] update patchview.ui with new qt designer
Date: Sat, 21 Jul 2007 15:24:13 +0200
Message-ID: <20070723204322.A12C028ABA1@mail-in-07.arcor-online.net>
References: <200707232232.39546.kumbayo84@arcor.de>
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4lC-0008Sg-R0
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934606AbXGWUna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934726AbXGWUn3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:43:29 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:52394 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934606AbXGWUnY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:43:24 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 359FA17F41D;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id E86FB13ED37;
	Mon, 23 Jul 2007 22:43:22 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id A12C028ABA1;
	Mon, 23 Jul 2007 22:43:22 +0200 (CEST)
X-Mailbox-Line: From a4ad379c69f1134cebd28182850f3658edb08744 Mon Sep 17 00:00:00 2001
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53479>

---
 src/customaction.ui |  154 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 121 insertions(+), 33 deletions(-)

diff --git a/src/customaction.ui b/src/customaction.ui
index fc2ceba..59004ca 100644
--- a/src/customaction.ui
+++ b/src/customaction.ui
@@ -16,26 +16,42 @@
    <iconset resource="icons.qrc" >:/icons/resources/bookmark.png</iconset>
   </property>
   <layout class="QHBoxLayout" >
-   <property name="margin" >
-    <number>5</number>
-   </property>
    <property name="spacing" >
     <number>0</number>
    </property>
+   <property name="leftMargin" >
+    <number>5</number>
+   </property>
+   <property name="topMargin" >
+    <number>5</number>
+   </property>
+   <property name="rightMargin" >
+    <number>5</number>
+   </property>
+   <property name="bottomMargin" >
+    <number>5</number>
+   </property>
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
       <widget class="QFrame" name="frame" >
        <property name="sizePolicy" >
-        <sizepolicy>
-         <hsizetype>5</hsizetype>
-         <vsizetype>0</vsizetype>
+        <sizepolicy vsizetype="Fixed" hsizetype="Preferred" >
          <horstretch>0</horstretch>
          <verstretch>0</verstretch>
         </sizepolicy>
@@ -47,20 +63,38 @@
         <enum>QFrame::Raised</enum>
        </property>
        <layout class="QHBoxLayout" >
-        <property name="margin" >
-         <number>9</number>
-        </property>
         <property name="spacing" >
          <number>6</number>
         </property>
+        <property name="leftMargin" >
+         <number>9</number>
+        </property>
+        <property name="topMargin" >
+         <number>9</number>
+        </property>
+        <property name="rightMargin" >
+         <number>9</number>
+        </property>
+        <property name="bottomMargin" >
+         <number>9</number>
+        </property>
         <item>
          <layout class="QHBoxLayout" >
-          <property name="margin" >
-           <number>0</number>
-          </property>
           <property name="spacing" >
            <number>15</number>
           </property>
+          <property name="leftMargin" >
+           <number>0</number>
+          </property>
+          <property name="topMargin" >
+           <number>0</number>
+          </property>
+          <property name="rightMargin" >
+           <number>0</number>
+          </property>
+          <property name="bottomMargin" >
+           <number>0</number>
+          </property>
           <item>
            <widget class="QPushButton" name="pushButtonNew" >
             <property name="text" >
@@ -147,20 +181,38 @@
          <enum>QFrame::Raised</enum>
         </property>
         <layout class="QHBoxLayout" >
-         <property name="margin" >
-          <number>9</number>
-         </property>
          <property name="spacing" >
           <number>6</number>
          </property>
+         <property name="leftMargin" >
+          <number>9</number>
+         </property>
+         <property name="topMargin" >
+          <number>9</number>
+         </property>
+         <property name="rightMargin" >
+          <number>9</number>
+         </property>
+         <property name="bottomMargin" >
+          <number>9</number>
+         </property>
          <item>
           <layout class="QVBoxLayout" >
-           <property name="margin" >
-            <number>0</number>
-           </property>
            <property name="spacing" >
             <number>6</number>
            </property>
+           <property name="leftMargin" >
+            <number>0</number>
+           </property>
+           <property name="topMargin" >
+            <number>0</number>
+           </property>
+           <property name="rightMargin" >
+            <number>0</number>
+           </property>
+           <property name="bottomMargin" >
+            <number>0</number>
+           </property>
            <item>
             <widget class="QLabel" name="labelActionName" >
              <property name="text" >
@@ -186,20 +238,38 @@
          <enum>QFrame::Raised</enum>
         </property>
         <layout class="QHBoxLayout" >
-         <property name="margin" >
-          <number>9</number>
-         </property>
          <property name="spacing" >
           <number>6</number>
          </property>
+         <property name="leftMargin" >
+          <number>9</number>
+         </property>
+         <property name="topMargin" >
+          <number>9</number>
+         </property>
+         <property name="rightMargin" >
+          <number>9</number>
+         </property>
+         <property name="bottomMargin" >
+          <number>9</number>
+         </property>
          <item>
           <layout class="QVBoxLayout" >
-           <property name="margin" >
-            <number>0</number>
-           </property>
            <property name="spacing" >
             <number>6</number>
            </property>
+           <property name="leftMargin" >
+            <number>0</number>
+           </property>
+           <property name="topMargin" >
+            <number>0</number>
+           </property>
+           <property name="rightMargin" >
+            <number>0</number>
+           </property>
+           <property name="bottomMargin" >
+            <number>0</number>
+           </property>
            <item>
             <widget class="QLabel" name="textLabel1" >
              <property name="text" >
@@ -219,12 +289,21 @@
            </item>
            <item>
             <layout class="QHBoxLayout" >
-             <property name="margin" >
-              <number>0</number>
-             </property>
              <property name="spacing" >
               <number>6</number>
              </property>
+             <property name="leftMargin" >
+              <number>0</number>
+             </property>
+             <property name="topMargin" >
+              <number>0</number>
+             </property>
+             <property name="rightMargin" >
+              <number>0</number>
+             </property>
+             <property name="bottomMargin" >
+              <number>0</number>
+             </property>
              <item>
               <widget class="QCheckBox" name="checkBoxRefreshAfterAction" >
                <property name="toolTip" >
@@ -261,12 +340,21 @@
      </item>
      <item>
       <layout class="QHBoxLayout" >
-       <property name="margin" >
-        <number>0</number>
-       </property>
        <property name="spacing" >
         <number>6</number>
        </property>
+       <property name="leftMargin" >
+        <number>0</number>
+       </property>
+       <property name="topMargin" >
+        <number>0</number>
+       </property>
+       <property name="rightMargin" >
+        <number>0</number>
+       </property>
+       <property name="bottomMargin" >
+        <number>0</number>
+       </property>
        <item>
         <spacer>
          <property name="orientation" >
-- 
1.5.3.rc2.30.g1fe72
