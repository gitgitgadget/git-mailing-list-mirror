From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Give the context menu for disabling the toolbar a title
Date: Fri, 12 Jun 2009 14:08:00 +0200
Message-ID: <1244808481-13012-4-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5aG-0007v7-MX
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbZFLMKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 08:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbZFLMKB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:10:01 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54702 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbZFLMJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:09:56 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id C59FBFFA254B;
	Fri, 12 Jun 2009 14:08:13 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF5YL-0007lD-01; Fri, 12 Jun 2009 14:08:13 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18kSDKghLgDlAG4Ux9UHqHUXTO+w0HRos90Z2/0
	ekSNR4Nxrm47DGNixNnNGjl2fDKZACSmT2Ou5yQdVvsRTaXgui
	FEQpLkK0XXrNqaVpthPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121416>

Previously it only showed a checkbox, now there is the word "Toolbar"
beside it.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainview.ui |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/mainview.ui b/src/mainview.ui
index 4ddf43d..69dcdf0 100644
--- a/src/mainview.ui
+++ b/src/mainview.ui
@@ -64,6 +64,9 @@
    </layout>
   </widget>
   <widget class="QToolBar" name="toolBar">
+   <property name="windowTitle">
+    <string>Toolbar</string>
+   </property>
    <property name="orientation">
     <enum>Qt::Horizontal</enum>
    </property>
-- 
1.6.3.2.236.ge505d
