From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [QGIT4 PATCH 2/6] change size policy of the patch viewer to expanding
Date: Fri, 20 Jul 2007 22:50:10 +0200
Message-ID: <20070723204317.5A7F628ABA1@mail-in-07.arcor-online.net>
References: <200707232232.39546.kumbayo84@arcor.de>
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4lB-0008Sg-7K
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934690AbXGWUnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934619AbXGWUnY
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:43:24 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:55138 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934362AbXGWUnX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:43:23 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 9AA0F3029E1;
	Mon, 23 Jul 2007 22:43:22 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 89FC9100C3;
	Mon, 23 Jul 2007 22:43:22 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 5A7F628ABA1;
	Mon, 23 Jul 2007 22:43:17 +0200 (CEST)
X-Mailbox-Line: From fb6ffc2d8239cbd9748e546a8c1804e03fab57ed Mon Sep 17 00:00:00 2001
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53476>

else the diff to header will take up half of the vertical space

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
 src/patchview.ui |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/patchview.ui b/src/patchview.ui
index a599e09..6dbf53c 100644
--- a/src/patchview.ui
+++ b/src/patchview.ui
@@ -163,6 +163,12 @@
      </item>
      <item>
       <widget class="QSplitter" name="splitter_2" >
+       <property name="sizePolicy" >
+        <sizepolicy vsizetype="Expanding" hsizetype="Expanding" >
+         <horstretch>0</horstretch>
+         <verstretch>0</verstretch>
+        </sizepolicy>
+       </property>
        <property name="orientation" >
         <enum>Qt::Horizontal</enum>
        </property>
-- 
1.5.3.rc2.30.g1fe72
