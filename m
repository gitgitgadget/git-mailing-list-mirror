From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Make file tree to tab widget ratio 1:5
Date: Wed, 7 Feb 2007 21:39:35 +0000
Message-ID: <200702072139.35393.andyparkins@gmail.com>
References: <75ebbfaed42a61c54ec6a38bc60d5e777a074dc5.1170884269.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 22:42:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEuYu-0003fn-9Q
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbXBGVml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161440AbXBGVmk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:42:40 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:28457 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161439AbXBGVmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:42:40 -0500
Received: by nz-out-0506.google.com with SMTP id s1so297211nze
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 13:42:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition;
        b=ui0mQQZVOqttQKo7JgfidgOTtw18oUIh7hlBsxZGOerzf27gBe/vv7/k3t0C4M8SoqtR3nO/9HesG/ef433h/4UHpb0SEBQWGC79R/IwD8Ga4BricL0DtGzuq9AQPrS1cUbdoVwGR5pN1eKf8HSUXANKYtXM5OKcRBo2kLPFVrw=
Received: by 10.114.208.8 with SMTP id f8mr1448301wag.1170884559257;
        Wed, 07 Feb 2007 13:42:39 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id z21sm1290574qbc.2007.02.07.13.42.36;
        Wed, 07 Feb 2007 13:42:37 -0800 (PST)
In-Reply-To: <75ebbfaed42a61c54ec6a38bc60d5e777a074dc5.1170884269.git.andyparkins@gmail.com>
X-TUID: 0e772fce686286e5
X-UID: 225
X-Length: 1968
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38976>

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 src/mainview.ui |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/src/mainview.ui b/src/mainview.ui
index 5376291..7919b5d 100644
--- a/src/mainview.ui
+++ b/src/mainview.ui
@@ -29,6 +29,14 @@
        <enum>Qt::Horizontal</enum>
       </property>
       <widget class="TreeView" name="treeView" >
+       <property name="sizePolicy" >
+        <sizepolicy>
+         <hsizetype>7</hsizetype>
+         <vsizetype>13</vsizetype>
+         <horstretch>1</horstretch>
+         <verstretch>0</verstretch>
+        </sizepolicy>
+       </property>
        <property name="contextMenuPolicy" >
         <enum>Qt::CustomContextMenu</enum>
        </property>
@@ -48,6 +56,14 @@
        </column>
       </widget>
       <widget class="QTabWidget" name="tabWdg" >
+       <property name="sizePolicy" >
+        <sizepolicy>
+         <hsizetype>7</hsizetype>
+         <vsizetype>7</vsizetype>
+         <horstretch>5</horstretch>
+         <verstretch>0</verstretch>
+        </sizepolicy>
+       </property>
        <widget class="QWidget" name="TabWdg" >
         <attribute name="title" >
          <string>Tab&amp;Wdg</string>
@@ -90,7 +106,7 @@
      <x>0</x>
      <y>0</y>
      <width>975</width>
-     <height>32</height>
+     <height>31</height>
     </rect>
    </property>
    <widget class="QMenu" name="Edit" >
-- 
1.5.0.rc1.gf4b6c
