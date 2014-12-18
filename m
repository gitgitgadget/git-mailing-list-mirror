From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] pack-bitmap: comment typo fixed
Date: Thu, 18 Dec 2014 20:10:42 +0600
Message-ID: <1418911842-1655-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 15:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1bnf-0001wS-KX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 15:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbaLROLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 09:11:17 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:62089 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbaLROLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 09:11:16 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so998403lbv.25
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=82FHSYXH28C28t5pKZpTaI1nhOIL92oWF3SJ+lBrUd4=;
        b=JAFcobYvv0ZjNv0hk2AYVhy8yZ/jbVbTTldMUCCLOb4sKDNEk3uEWg7XEOklBtPCLL
         AnVMGtccm+edH+rUZJVtsOP+zhBEzQI6CCfTHRB5gp8CMlbVgFskciVwo/2sUXuFJQdC
         homTqIkPjHPeBf7VIslxeSXRdzrF5I7wscgS1dSbWuC4jEfkbwcW+PI9lYRpTsCrgSze
         uyCO499y6WI8BnTiqQWSouBD5I5XOlPb6i0/5HD5rOfM2teDr+wbQ3ASptPFmvUbKhsn
         EL/5qUSF9IZnLAXYCsh8uwnEdZ4Czoof9dB+v6zK2Ro5BeO4H/5OV1uD3C4aEQ/xCIL4
         e0uw==
X-Received: by 10.112.185.99 with SMTP id fb3mr2429047lbc.21.1418911874583;
        Thu, 18 Dec 2014 06:11:14 -0800 (PST)
Received: from localhost.localdomain ([2.133.0.167])
        by mx.google.com with ESMTPSA id z4sm1642661laz.8.2014.12.18.06.11.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Dec 2014 06:11:13 -0800 (PST)
X-Mailer: git-send-email 2.2.0.66.gda9d48c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261527>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6a81841..3281df3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -60,7 +60,7 @@ static struct bitmap_index {
 	struct ewah_bitmap *blobs;
 	struct ewah_bitmap *tags;
 
-	/* Map from SHA1 -> `stored_bitmap` for all the bitmapped comits */
+	/* Map from SHA1 -> `stored_bitmap` for all the bitmapped commits */
 	khash_sha1 *bitmaps;
 
 	/* Number of bitmapped commits */
-- 
2.2.0.66.gda9d48c.dirty
