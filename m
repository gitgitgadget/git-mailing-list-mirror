From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit 2/2] Remove non-working shortcut key 'f' for "Toggle filter by tree"
Date: Fri, 12 Jun 2009 14:07:59 +0200
Message-ID: <8348b0b8496634626c558c8aed04e9720beadc97.1244808064.git.markus.heidelberg@web.de>
References: <5eda420491e42dbb85b86b688dd604f067d7136d.1244808064.git.markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5aF-0007v7-E8
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbZFLMJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 08:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754468AbZFLMJ5
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:09:57 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54690 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbZFLMJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:09:56 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6CA51FFA44FA;
	Fri, 12 Jun 2009 14:08:13 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF5YL-0007lD-00; Fri, 12 Jun 2009 14:08:13 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
In-Reply-To: <5eda420491e42dbb85b86b688dd604f067d7136d.1244808064.git.markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/vF7D93Fr00Y93Zyxp7EqpBWdNC3m16c9QSudH
	icaf9Iq27ZpR8ja6OQaBDnxcEJZRybCQCmnXuWz2hOVegup/oo
	8gLtCjGL1UeC7FOAIV7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121418>

It was introduced in commit cdb58c0 (Adding useful shortcuts,
2008-06-07), but didn't even work there, because the key 'f' was already
reserved for "Go to file page", which caused the following message on
stdout:

    QAction::eventFilter: Ambiguous shortcut overload: F

Now the shortcut works for jumping to the file view again.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainview.ui |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/mainview.ui b/src/mainview.ui
index b3a94a6..3a257be 100644
--- a/src/mainview.ui
+++ b/src/mainview.ui
@@ -462,9 +462,6 @@
    <property name="toolTip">
     <string>Filter by tree selection, multiple selections allowed</string>
    </property>
-   <property name="shortcut">
-    <string>F</string>
-   </property>
   </action>
   <action name="ActShowTree">
    <property name="checkable">
-- 
1.6.3.2.236.ge505d
