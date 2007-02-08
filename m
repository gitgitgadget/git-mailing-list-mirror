From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] qgit4: Set a 5:1 stretch ratio on the left and right halves of the patch viewer
Date: Thu, 8 Feb 2007 23:31:43 +0000
Message-ID: <200702082331.43424.andyparkins@gmail.com>
References: <200702082158.56463.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 00:34:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIn3-0004CG-2v
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965620AbXBHXew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965616AbXBHXew
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:34:52 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:40952 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965608AbXBHXev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:34:51 -0500
Received: by wx-out-0506.google.com with SMTP id h31so642402wxd
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 15:34:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=r+EqNjWhoZSWEWohr74fR+dSvL3yaGYs9wGTOv0EHw5pqoMDFsqkqDDWb7giOlEWlxPf4+fU/g7+A8lNU5RlaMG9doBZY4OO40dvkbMQFMkqgIb/r6o5o6ByZne1TupLATc/T0kSLU1C/TJv2/09EqypMbqN/gciSSICsDHMVSo=
Received: by 10.78.170.17 with SMTP id s17mr139133hue.1170977688071;
        Thu, 08 Feb 2007 15:34:48 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm3930739ugf.2007.02.08.15.34.44;
        Thu, 08 Feb 2007 15:34:45 -0800 (PST)
In-Reply-To: <200702082158.56463.andyparkins@gmail.com>
X-TUID: 8ef5ab6dfe88affd
X-UID: 233
X-Length: 1777
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39125>

This stops the file list taking up half the screen by default.  The
exact ratio is probably not to important, as long as it's not 1:1.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 src/patchview.ui |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/patchview.ui b/src/patchview.ui
index bd723e8..4537dd7 100644
--- a/src/patchview.ui
+++ b/src/patchview.ui
@@ -132,6 +132,14 @@
         <enum>Qt::Horizontal</enum>
        </property>
        <widget class="QSplitter" name="splitter" >
+        <property name="sizePolicy" >
+         <sizepolicy>
+          <hsizetype>5</hsizetype>
+          <vsizetype>7</vsizetype>
+          <horstretch>5</horstretch>
+          <verstretch>0</verstretch>
+         </sizepolicy>
+        </property>
         <property name="orientation" >
          <enum>Qt::Vertical</enum>
         </property>
@@ -156,6 +164,14 @@
         </widget>
        </widget>
        <widget class="FileList" name="fileList" >
+        <property name="sizePolicy" >
+         <sizepolicy>
+          <hsizetype>13</hsizetype>
+          <vsizetype>13</vsizetype>
+          <horstretch>1</horstretch>
+          <verstretch>0</verstretch>
+         </sizepolicy>
+        </property>
         <property name="contextMenuPolicy" >
          <enum>Qt::CustomContextMenu</enum>
         </property>
-- 
1.5.0.rc1.gf4b6c
