From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Drop an unused empty menu contribution.
Date: Tue, 10 Jun 2008 00:50:13 +0200
Message-ID: <1213051816-4046-5-git-send-email-robin.rosenberg.lists@dewire.com>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-3-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-4-git-send-email-robin.rosenberg.lists@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 00:54:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qGH-0001Eo-9q
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 00:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965AbYFIWxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757047AbYFIWxi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 18:53:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17243 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756763AbYFIWxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 18:53:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1835E1434D09;
	Tue, 10 Jun 2008 00:53:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0+GJmQ7Ytbxl; Tue, 10 Jun 2008 00:53:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 475231434DD8;
	Tue, 10 Jun 2008 00:53:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1213051816-4046-4-git-send-email-robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84438>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index c71c763..e47d75a 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -97,14 +97,6 @@
                menubarPath="team.main/group1"
                tooltip="%CommitAction_tooltip"/>
 	  </objectContribution>
-      <objectContribution
-            objectClass="org.eclipse.core.resources.IFile"
-            adaptable="true"
-            id="org.spearce.egit.ui.IFileContributions">
-         <filter name="projectPersistentProperty"
-               value="org.eclipse.team.core.repository=org.spearce.egit.core.GitProvider">
-         </filter>
-      </objectContribution>
    </extension>
 
    <extension
-- 
1.5.5.1.178.g1f811
