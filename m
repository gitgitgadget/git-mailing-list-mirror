From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 16/31] Remove debug/test console output from GitIndex
Date: Sun, 17 Aug 2008 22:43:57 +0200
Message-ID: <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp99-00038o-VR
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbYHQUpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYHQUpP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:15 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYHQUpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:12 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vTKmx5uyzMVp9Uo83hvorEoS2KrgI+HWoI9xO5PxT8Q=;
        b=jY1s08UmyTwdcErlJ9OGLjur209+gzxyIbCpGee/4AzVidEkKYhs+Y7JKJfFZqhm/8
         q0XoyvdMhK8C2bQ78QgFs/PNDlKNooM8dRkC6O1JfbS7FqfcW8ZjyB/jOzrR7J4jczh8
         u+ztq80WXH1dC7obNmTQcAPLTXfDm6Knymhtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KFYxLTh6Kma0ycVxllzmc5Pr4xT0PbBvCVqu5RNRMi/O6fhu9qzLDId7EUdjlBXZ5B
         MkZZIUg/7TCz6jKj0ykvp7g6a1airj3Wn0nfFvcQ2WUviphxQ5Nb0dR3GcqXX7YWislM
         etit5o66hRGA0JQiImnofANnsvs4HQ6ws6uoM=
Received: by 10.103.20.7 with SMTP id x7mr3467798mui.75.1219005911808;
        Sun, 17 Aug 2008 13:45:11 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id j10sm2479670muh.1.2008.08.17.13.45.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92651>

Typical Eclipse users (read: me) usually doesn't like unnecessary
output on Eclipse stdout.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/GitIndex.java         |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index c7a4402..2255c1a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -190,7 +190,6 @@ public class GitIndex {
 	 * @throws IOException
 	 */
 	public void read() throws IOException {
-		long t0 = System.currentTimeMillis();
 		changed = false;
 		statDirty = false;
 		if (!cacheFile.exists()) {
@@ -214,9 +213,7 @@ public class GitIndex {
 				Entry entry = new Entry(buffer);
 				entries.put(entry.name, entry);
 			}
-			long t1 = System.currentTimeMillis();
 			lastCacheTime = cacheFile.lastModified();
-			System.out.println("Read index "+cacheFile+" in "+((t1-t0)/1000.0)+"s");
 		} finally {
 			cache.close();
 		}
-- 
1.5.6.3
