From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/9] Add .qualifier to the plugin version.
Date: Wed, 28 Feb 2007 23:26:26 +0100
Message-ID: <20070228222626.12021.60482.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLf-0002xY-Is
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbXB1Wca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbXB1Wc3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:29 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1442 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932596AbXB1WcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0A1FD8033A6
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:06 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18351-09 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:05 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 1F2D58033AA
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:02 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 34C2429869
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id rgyVi-Mg9s3o for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:26 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id E1F0229859
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:26 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41019>

This makes every exported plugin have a different name. This
is not the git SHA1, but a timestamp.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 org.spearce.egit.core/META-INF/MANIFEST.MF |    2 +-
 org.spearce.egit.ui/META-INF/MANIFEST.MF   |    2 +-
 org.spearce.jgit/META-INF/MANIFEST.MF      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.egit.core/META-INF/MANIFEST.MF
index f295c3c..a8349a1 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -2,7 +2,7 @@ Manifest-Version: 1.0
 Bundle-ManifestVersion: 2
 Bundle-Name: %plugin_name
 Bundle-SymbolicName: org.spearce.egit.core; singleton:=true
-Bundle-Version: 0.2
+Bundle-Version: 0.2.0.qualifier
 Bundle-Activator: org.spearce.egit.core.Activator
 Bundle-Vendor: %provider_name
 Bundle-Localization: plugin
diff --git a/org.spearce.egit.ui/META-INF/MANIFEST.MF b/org.spearce.egit.ui/META-INF/MANIFEST.MF
index 5c97648..63dcec8 100644
--- a/org.spearce.egit.ui/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.ui/META-INF/MANIFEST.MF
@@ -2,7 +2,7 @@ Manifest-Version: 1.0
 Bundle-ManifestVersion: 2
 Bundle-Name: %plugin_name
 Bundle-SymbolicName: org.spearce.egit.ui; singleton:=true
-Bundle-Version: 0.2
+Bundle-Version: 0.2.0.qualifier
 Bundle-Activator: org.spearce.egit.ui.Activator
 Bundle-Vendor: %plugin_provider
 Bundle-Localization: plugin
diff --git a/org.spearce.jgit/META-INF/MANIFEST.MF b/org.spearce.jgit/META-INF/MANIFEST.MF
index 2f959e1..1485bb9 100644
--- a/org.spearce.jgit/META-INF/MANIFEST.MF
+++ b/org.spearce.jgit/META-INF/MANIFEST.MF
@@ -2,7 +2,7 @@ Manifest-Version: 1.0
 Bundle-ManifestVersion: 2
 Bundle-Name: %plugin_name
 Bundle-SymbolicName: org.spearce.jgit
-Bundle-Version: 0.2
+Bundle-Version: 0.2.0.qualifier
 Bundle-Localization: plugin
 Bundle-Vendor: %provider_name
 Export-Package: org.spearce.jgit.errors,
