From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 03/12] Format PackIndexV1 class
Date: Mon,  2 Jun 2008 23:24:34 +0200
Message-ID: <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXo-0006g0-Rz
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbYFBVY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYFBVY6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:24:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:39632 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbYFBVYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:24:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so844313fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LGzw+BH68G1FHEdZ6PJhzt0pBuKfCcYMifJxc6wJgqc=;
        b=mOQ4T8b3aBhZmseAHwlJpCZLQg9IdIQ9ZeAi6KfoggFvI8sBoKfFNFH9gDiSSlQHmWPMooe7cl/BOoqxOGi/ALhdk5tJZCyPbZXTsJ5i2IW8DZk0oDppUMF9IcJWA9yUBCnsZuJLSfOojaKvhjsE9DhrimC7NvHdDOf4+cRUXAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sw5G8lX1PGGIWyRYJKrprJpIguZrLjUZunged+N2JhK6C7XGsaUqXTdqAvPFzvLOL6WqO9dUZznK7CXeyV6FAOaiQI3ZS19q1WX2UL52pM81lY+y91SJvv1pZWkLzWNjTw220oAipPoMEVq+DNM/mWn9jXZBf/jikQMBzW7MQl4=
Received: by 10.86.70.11 with SMTP id s11mr2416206fga.71.1212441894989;
        Mon, 02 Jun 2008 14:24:54 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id d6sm5496679fga.2.2008.06.02.14.24.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:24:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83567>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
index 84f13d2..cfd18da 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
@@ -64,9 +64,9 @@ class PackIndexV1 extends PackIndex {
 		for (int k = 0; k < idxHeader.length; k++) {
 			int n;
 			if (k == 0) {
-				n = (int)(idxHeader[k]);
+				n = (int) (idxHeader[k]);
 			} else {
-				n = (int)(idxHeader[k]-idxHeader[k-1]);
+				n = (int) (idxHeader[k] - idxHeader[k - 1]);
 			}
 			if (n > 0) {
 				idxdata[k] = new byte[n * (Constants.OBJECT_ID_LENGTH + 4)];
@@ -94,11 +94,11 @@ class PackIndexV1 extends PackIndex {
 			if (cmp < 0)
 				high = mid;
 			else if (cmp == 0) {
-				int b0 = data[pos-4] & 0xff;
-				int b1 = data[pos-3] & 0xff;
-				int b2 = data[pos-2] & 0xff;
-				int b3 = data[pos-1] & 0xff;
-				return (((long)b0) << 24) | ( b1 << 16 ) | ( b2 << 8 ) | (b3);
+				int b0 = data[pos - 4] & 0xff;
+				int b1 = data[pos - 3] & 0xff;
+				int b2 = data[pos - 2] & 0xff;
+				int b3 = data[pos - 1] & 0xff;
+				return (((long) b0) << 24) | (b1 << 16) | (b2 << 8) | (b3);
 			} else
 				low = mid + 1;
 		} while (low < high);
-- 
1.5.5.1
