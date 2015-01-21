From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/2] pack-bitmap: fix typo
Date: Wed, 21 Jan 2015 15:13:51 +0600
Message-ID: <1421831631-28729-1-git-send-email-kuleshovmail@gmail.com>
References: <1421831604-28674-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:14:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrMS-0003Xh-Dc
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbbAUJOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:14:01 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:42921 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbbAUJN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:13:58 -0500
Received: by mail-lb0-f175.google.com with SMTP id z11so38246521lbi.6
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xieg9+5P9cDLRmZrIFdJFniWlWL3BpkWHMxuuSxMYSA=;
        b=bCWeIk+n+vQMKylHQaehWL+svo5h3obsuDj/Vx0OmQgzOKFO5dXEPO6rHy5rVLx9/V
         nUgvy5sJzlQtO5Oazjyul4ZNeVoj3qw1zfV2lB9GDQA2dFn/7XH3hckyK57pxQtIDQE+
         KPekFOWXmidTJe9HB5DtBluDFT4QfWYK1r/UP53eTWD+clcnIRMQ97/olb0MwJHn8LHn
         Sga57ucrAKipEZu2xHXWbLUynGtZGXT1DhvlbdjF/xmgIGw8jWO9g3UFxSFB5WIEXgtD
         72JWtCDB6pxzs1R+VyALwf2n9v92jrw3EvygJXjoV5gMurzTGBNxRU24QcLJSCqpHiKJ
         s70Q==
X-Received: by 10.112.125.41 with SMTP id mn9mr42686831lbb.80.1421831636807;
        Wed, 21 Jan 2015 01:13:56 -0800 (PST)
Received: from localhost.localdomain ([147.30.53.164])
        by mx.google.com with ESMTPSA id o3sm5312183laf.42.2015.01.21.01.13.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 01:13:55 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
In-Reply-To: <1421831604-28674-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262722>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0cd85f6..365f9d9 100644
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
2.3.0-rc1
