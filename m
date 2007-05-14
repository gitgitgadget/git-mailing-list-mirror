From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Set required execution enviroment
Date: Mon, 14 May 2007 22:56:43 +0200
Message-ID: <11791762032532-git-send-email-robin.rosenberg@dewire.com>
References: <11791001343234-git-send-email-robin.rosenberg@dewire.com>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 22:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnhe4-0002QP-8s
	for gcvg-git@gmane.org; Mon, 14 May 2007 22:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759300AbXENU7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 16:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758878AbXENU7n
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 16:59:43 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4677 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759300AbXENU7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 16:59:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 02293802C04;
	Mon, 14 May 2007 22:53:29 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17173-10; Mon, 14 May 2007 22:53:28 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 188048028AB;
	Mon, 14 May 2007 22:53:28 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id AF3C628F0B; Mon, 14 May 2007 22:56:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11791001343234-git-send-email-robin.rosenberg@dewire.com>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47290>

This is required to be able to export the plugin to jar
files, at least using Eclipse 3.3 M7, otherwise the compiler
assumes 1.4 syntax and compilation fails.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.core.test/META-INF/MANIFEST.MF |    1 +
 org.spearce.egit.core/META-INF/MANIFEST.MF      |    1 +
 org.spearce.egit.ui/META-INF/MANIFEST.MF        |    1 +
 org.spearce.jgit/META-INF/MANIFEST.MF           |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core.test/META-INF/MANIFEST.MF b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
index e553c1e..b0f365d 100644
--- a/org.spearce.egit.core.test/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
@@ -17,3 +17,4 @@ Import-Package: org.eclipse.core.resources,
  org.eclipse.jdt.junit,
  org.eclipse.jdt.launching
 Export-Package: org.spearce.egit.core.internal.mapping
+Bundle-RequiredExecutionEnvironment: J2SE-1.5
diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index e3cfc13..384b87e 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -17,3 +17,4 @@ Export-Package: org.spearce.egit.core.internal.mapping;x-friends:="org.spearce.e
  org.spearce.egit.core.op,
  org.spearce.egit.core.project
 Eclipse-LazyStart: true
+Bundle-RequiredExecutionEnvironment: J2SE-1.5
diff --git a/org.spearce.egit.ui/META-INF/MANIFEST.MF b/org.spearce.egit.ui/META-INF/MANIFEST.MF
index 9857e3f..e1dcc12 100644
--- a/org.spearce.egit.ui/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.ui/META-INF/MANIFEST.MF
@@ -19,3 +19,4 @@ Require-Bundle: org.eclipse.core.runtime,
  org.spearce.jgit,
  org.spearce.egit.core
 Eclipse-LazyStart: true
+Bundle-RequiredExecutionEnvironment: J2SE-1.5
diff --git a/org.spearce.jgit/META-INF/MANIFEST.MF b/org.spearce.jgit/META-INF/MANIFEST.MF
index 3f9d29c..c5c0e0a 100644
--- a/org.spearce.jgit/META-INF/MANIFEST.MF
+++ b/org.spearce.jgit/META-INF/MANIFEST.MF
@@ -9,3 +9,4 @@ Export-Package: org.spearce.jgit.errors,
  org.spearce.jgit.lib
 Require-Bundle: org.junit
 Eclipse-LazyStart: true
+Bundle-RequiredExecutionEnvironment: J2SE-1.5
-- 
1.5.1.1
