From: "Li Frank-B20596" <Frank.Li@freescale.com>
Subject: [QGit] [PATCH] Modify Highlight Color at File Context View.
Date: Sat, 27 Sep 2008 11:44:46 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE9607A217@zch01exm23.fsl.freescale.net>
References: <gbak2u$v9b$1@ger.gmane.org> <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net> <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net> <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net> <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com> <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net> <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 05:46:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjQkt-0005DO-8D
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 05:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbYI0Dox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 23:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYI0Dox
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 23:44:53 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:60115 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYI0Dow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2008 23:44:52 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m8R3in52024392
	for <git@vger.kernel.org>; Fri, 26 Sep 2008 20:44:50 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8R3imbM024635
	for <git@vger.kernel.org>; Fri, 26 Sep 2008 22:44:48 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [QGit] [PATCH] Modify Highlight Color at File Context View.
Thread-Index: Ackfw+qPedz+9lIWQDO9TR1nTh/RvwAIbFQgABtiaJA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96901>

>From 3507b3f0b13287c5a25a31b238527b5920555c5c Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.li@freescale.com>
Date: Sat, 27 Sep 2008 11:41:03 +0800
Subject: [PATCH] Modify Highlight Color at File Context View.
Author and line number can be easily found when choose special commit.

Signed-off-by: Frank Li <Frank.li@freescale.com>
---
 src/filecontent.cpp |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/filecontent.cpp b/src/filecontent.cpp
index 28e0f91..23c2e95 100644
--- a/src/filecontent.cpp
+++ b/src/filecontent.cpp
@@ -576,12 +576,14 @@ void FileContent::setAnnList() {
 	listWidgetAnn->clear();
 	listWidgetAnn->addItems(sl);
 
-	QBrush b(Qt::darkGray);
+	QBrush fore(Qt::darkRed);
+	QBrush back(Qt::lightGray);
 	QFont f(listWidgetAnn->font());
 	f.setBold(true);
 	FOREACH (QVector<int>, it, curIdLines) {
 		QListWidgetItem* item = listWidgetAnn->item(*it);
-		item->setForeground(b);
+		item->setForeground(fore);
+		item->setBackground(back);
 		item->setFont(f);
 	}
 	/* When listWidgetAnn get focus for the first time the current
-- 
1.6.0.2.1172.ga5ed0
