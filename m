From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [QGIT4 PATCH 4/6] change size policy of splitter which contains the list and the textbox
Date: Sat, 21 Jul 2007 15:31:03 +0200
Message-ID: <20070723204323.0DE8828ABA2@mail-in-07.arcor-online.net>
References: <200707232232.39546.kumbayo84@arcor.de>
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 22:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4lC-0008Sg-9k
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934683AbXGWUn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934394AbXGWUn1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:43:27 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:54317 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934617AbXGWUnY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:43:24 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 5C5B815BD0E;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 4A468279445;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 0DE8828ABA2;
	Mon, 23 Jul 2007 22:43:23 +0200 (CEST)
X-Mailbox-Line: From 519d597858198628a4e547f27bda3a372c85d490 Mon Sep 17 00:00:00 2001
In-Reply-To: <200707232232.39546.kumbayo84@arcor.de>
X-Virus-Scanned: ClamAV 0.91.1/3744/Mon Jul 23 21:05:34 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53478>

in action setup dialog to expanding
else the empty space with the button below takes up half of the vertical space

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
 src/customaction.ui |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/customaction.ui b/src/customaction.ui
index 59004ca..49bb6c7 100644
--- a/src/customaction.ui
+++ b/src/customaction.ui
@@ -170,6 +170,12 @@
      </item>
      <item>
       <widget class="QSplitter" name="splitter" >
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
