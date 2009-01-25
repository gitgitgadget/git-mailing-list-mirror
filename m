From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/4] Retain Eclipse Git preferences page hierarchy without warnings in plugin.xml
Date: Sun, 25 Jan 2009 19:52:18 +0100
Message-ID: <1232909538-3279-4-git-send-email-robin.rosenberg@dewire.com>
References: <1232909538-3279-1-git-send-email-robin.rosenberg@dewire.com>
 <1232909538-3279-2-git-send-email-robin.rosenberg@dewire.com>
 <1232909538-3279-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jan 25 19:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRA7S-0004K8-SU
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbZAYSwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbZAYSw3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:52:29 -0500
Received: from mail.dewire.com ([83.140.172.130]:1483 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbZAYSwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:52:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3FAC8802AB3;
	Sun, 25 Jan 2009 19:52:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHrc5nSvNLv7; Sun, 25 Jan 2009 19:52:21 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C4661147E62B;
	Sun, 25 Jan 2009 19:52:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1232909538-3279-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107083>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index c2b82fd..869108c 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -185,7 +185,7 @@
             id="org.spearce.egit.ui.GitPreferences" />
 
       <page name="%GitPreferences_HistoryPreferencePage_name"
-            category="org.eclipse.team.ui.TeamPreferences/org.spearce.egit.ui.GitPreferences"
+	    category="org.spearce.egit.ui.GitPreferences"
             class="org.spearce.egit.ui.internal.preferences.HistoryPreferencePage"
 	    id="org.spearce.egit.ui.internal.preferences.HistoryPreferencePage" >
 	    <keywordReference
@@ -193,7 +193,7 @@
 	    </keywordReference>
 	    </page>
       <page name="%GitPreferences_WindowCachePreferencePage_name"
-            category="org.eclipse.team.ui.TeamPreferences/org.spearce.egit.ui.GitPreferences"
+	    category="org.spearce.egit.ui.GitPreferences"
             class="org.spearce.egit.ui.internal.preferences.WindowCachePreferencePage"
 	    id="org.spearce.egit.ui.internal.preferences.WindowCachePreferencePage" >
 	    <keywordReference
-- 
1.6.1.285.g35d8b
