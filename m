From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Add markers for extracting shortlog into build description.
Date: Thu, 19 Feb 2009 21:25:24 +0100
Message-ID: <1235075124-18281-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Feb 19 21:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFU5-0002Hl-J2
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbZBSUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbZBSUZc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:25:32 -0500
Received: from mail.dewire.com ([83.140.172.130]:6564 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbZBSUZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:25:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DE225147E9D2;
	Thu, 19 Feb 2009 21:25:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1r4EA2eXjYN; Thu, 19 Feb 2009 21:25:24 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C2899147E9CD;
	Thu, 19 Feb 2009 21:25:24 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110744>

Manual builds from Eclipse will unfortunately contain these markers
verbatim in the feature description.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit-feature/feature.xml |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

This together with some fixes to the PDE build makes a shortlog available
in the description of the new downloads at the update site. Sry, didn't wait
for approval and pushed this change anyway.

-- robin

diff --git a/org.spearce.egit-feature/feature.xml b/org.spearce.egit-feature/feature.xml
index 6669cd4..1fcda7b 100644
--- a/org.spearce.egit-feature/feature.xml
+++ b/org.spearce.egit-feature/feature.xml
@@ -7,7 +7,14 @@
       plugin="org.spearce.egit">
 
    <description url="http://www.jgit.org">
-      An Eclipse Git Plugin in pure Java.
+An Eclipse Git Plugin in pure Java.
+
+@buildId@
+
+Changes on @branch@ since @refversion@:
+
+<![CDATA[@shortlog@]]>
+
    </description>
 
    <copyright>
-- 
1.6.1.285.g35d8b
