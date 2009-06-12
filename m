From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Remove the extra margin from the revision view
Date: Fri, 12 Jun 2009 14:08:01 +0200
Message-ID: <1244808481-13012-5-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5Yb-0007Cm-Kw
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbZFLMIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 08:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754708AbZFLMIO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:08:14 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33391 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbZFLMIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:08:11 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 38CF410541619;
	Fri, 12 Jun 2009 14:08:14 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF5YM-0007lD-00; Fri, 12 Jun 2009 14:08:14 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19bICs+QxDnG8Y6CH7JZFi4xHosenVQejzqHA6k
	naGQMqSDKG1ZZNNUSSCotTUv58DAG3l070HRqVO2JY/LmkWHOc
	aAh5FgUOPSwdrvCdDntw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121413>

The patch and file views don't have such a margin, so this is for
consistency and saving screen space.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/revsview.ui |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/revsview.ui b/src/revsview.ui
index 81851b7..520415c 100644
--- a/src/revsview.ui
+++ b/src/revsview.ui
@@ -13,6 +13,12 @@
    <string>Rev list</string>
   </property>
   <layout class="QHBoxLayout" >
+   <property name="spacing" >
+    <number>0</number>
+   </property>
+   <property name="margin" >
+    <number>0</number>
+   </property>
    <item>
     <widget class="QSplitter" name="horizontalSplitter" >
      <property name="orientation" >
-- 
1.6.3.2.236.ge505d
