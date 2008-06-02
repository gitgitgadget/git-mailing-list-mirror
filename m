From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 08/12] Copying constructor of MutableObjectId
Date: Mon,  2 Jun 2008 23:24:39 +0200
Message-ID: <1212441883-12990-9-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-8-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXr-0006g0-Rc
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbYFBVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYFBVZO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:14 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:45136 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYFBVZL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:11 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1247612mue.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VV/oN6pgS/6iFgCq1ubuSPUQAw4j0Dv+jE41Dy5C/6Y=;
        b=JW1vcmXclgyHCf/1IfCmDrsEhR/oOiif77lMp8LUI3IyPM8rm9FXakSvKMi7DdIbJkxifuE9f3VJ9Sfab4wLP9JHB56C19xNlu+bxQ5inEaiDc8EEuA64++Ze1HjP1HB2G6TZKlewHoK/JIkISKAAKfPKGLCYElLuIve57C7Asw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fJY3jTJWdiVYKSxAHRh0T6fgC8eb44AtQbLBiLt68YJI3EP0Ni4WBu1I9sPgQ3HWbidNtRgacLrEMPh/Qcvq24+ssHi87VEv1vlqzoYWAZ+gD3qx+x3zqmxFeFqklSxl5xOG9ajNbeLKhv5VPjvq608oDksR0upwK22/4y3m8R8=
Received: by 10.103.176.20 with SMTP id d20mr5783198mup.136.1212441911179;
        Mon, 02 Jun 2008 14:25:11 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id u26sm7537944mug.4.2008.06.02.14.25.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-8-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83573>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |   21 ++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
index 954380b..f88d8cb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
@@ -46,6 +46,27 @@ import org.spearce.jgit.util.NB;
  */
 public class MutableObjectId extends AnyObjectId {
 	/**
+	 * Empty constructor. Initialize object with default (zeros) value.
+	 */
+	public MutableObjectId() {
+		super();
+	}
+
+	/**
+	 * Copying constructor.
+	 * 
+	 * @param src
+	 *            original entry, to copy id from
+	 */
+	MutableObjectId(MutableObjectId src) {
+		this.w1 = src.w1;
+		this.w2 = src.w2;
+		this.w3 = src.w3;
+		this.w4 = src.w4;
+		this.w5 = src.w5;
+	}
+
+	/**
 	 * Convert an ObjectId from raw binary representation.
 	 * 
 	 * @param bs
-- 
1.5.5.1
