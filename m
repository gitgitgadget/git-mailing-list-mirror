From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/9] Minor fix.
Date: Wed, 28 Feb 2007 23:26:10 +0100
Message-ID: <20070228222610.12021.1782.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLd-0002xY-Ps
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbXB1WcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbXB1WcS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:18 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1429 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932574AbXB1WcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1FCF28033A3
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:04 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18351-05 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:03 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 13D488033A7
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:01 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 14A8A29866
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id j864nmEIwY6Y for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:10 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C318629859
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:10 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41014>

Eclipse's strict checking thinks there is an error.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/WindowedFile.java     |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
index 28b495f..827cc22 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowedFile.java
@@ -21,6 +21,7 @@ import java.io.File;
 import java.io.IOException;
 import java.io.RandomAccessFile;
 import java.nio.MappedByteBuffer;
+import java.nio.channels.FileChannel;
 import java.nio.channels.FileChannel.MapMode;
 import java.util.zip.DataFormatException;
 import java.util.zip.Inflater;
@@ -85,7 +86,7 @@ public class WindowedFile {
 	 *            use the same window cache.
 	 * @param file
 	 *            the file to open. The file will be opened for reading only,
-	 *            unless {@link MapMode#READ_WRITE} or {@link MapMode#PRIVATE}
+	 *            unless {@link FileChannel.MapMode#READ_WRITE} or {@link FileChannel.MapMode#PRIVATE}
 	 *            is given.
 	 * @param windowSz
 	 *            number of bytes within a window. This value must be a power of
