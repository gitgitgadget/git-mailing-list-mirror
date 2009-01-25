From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/4] Add the keyword "Git" to the git preferences pages.
Date: Sun, 25 Jan 2009 19:52:17 +0100
Message-ID: <1232909538-3279-3-git-send-email-robin.rosenberg@dewire.com>
References: <1232909538-3279-1-git-send-email-robin.rosenberg@dewire.com>
 <1232909538-3279-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jan 25 19:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRA7D-0004Gp-0p
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbZAYSwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbZAYSw2
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:52:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:1478 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbZAYSwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:52:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 29DD3802664;
	Sun, 25 Jan 2009 19:52:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yggEUJF9Mzx8; Sun, 25 Jan 2009 19:52:20 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A84F1147E516;
	Sun, 25 Jan 2009 19:52:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1232909538-3279-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107082>

If the users searches for "Git" in the workspaces preferences, all
git related preferences pages will now be found.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/plugin.xml |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index e5c81e5..c2b82fd 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -187,11 +187,19 @@
       <page name="%GitPreferences_HistoryPreferencePage_name"
             category="org.eclipse.team.ui.TeamPreferences/org.spearce.egit.ui.GitPreferences"
             class="org.spearce.egit.ui.internal.preferences.HistoryPreferencePage"
-            id="org.spearce.egit.ui.internal.preferences.HistoryPreferencePage" />
+	    id="org.spearce.egit.ui.internal.preferences.HistoryPreferencePage" >
+	    <keywordReference
+		  id="org.spearce.egit.ui.keyword.git">
+	    </keywordReference>
+	    </page>
       <page name="%GitPreferences_WindowCachePreferencePage_name"
             category="org.eclipse.team.ui.TeamPreferences/org.spearce.egit.ui.GitPreferences"
             class="org.spearce.egit.ui.internal.preferences.WindowCachePreferencePage"
-            id="org.spearce.egit.ui.internal.preferences.WindowCachePreferencePage" />
+	    id="org.spearce.egit.ui.internal.preferences.WindowCachePreferencePage" >
+	    <keywordReference
+		  id="org.spearce.egit.ui.keyword.git">
+	    </keywordReference>
+      </page>
    </extension>
 
    <extension point="org.eclipse.ui.propertyPages">
@@ -212,6 +220,14 @@
          </filter>
       </page>
    </extension>
+
+   <extension point="org.eclipse.ui.keywords">
+	  <keyword
+			id="org.spearce.egit.ui.keyword.git"
+			label="git">
+	  </keyword>
+   </extension>
+
    <extension point="org.eclipse.ui.decorators">
       <decorator
             lightweight="true"
-- 
1.6.1.285.g35d8b
