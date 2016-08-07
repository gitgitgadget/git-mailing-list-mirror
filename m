Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDFC1FD99
	for <e@80x24.org>; Sun,  7 Aug 2016 15:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbcHGPRt (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 11:17:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33823 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbcHGPRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 11:17:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so11175462wma.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2016 08:17:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4cRBxdj04+wlkcjfA3qjSmIs03pt/tDImt3LLTGayNk=;
        b=puGLqh9eYCThnWC7ke7jSbkpLUsQeMWUhuKkTLaIhYZYXvz8QIPgoAaqwpK3J/xgrW
         mDF5YzdJ6EBgNpLpjotQWRzriUrM3gJruH4ullQ2rRF1PnFy0IX9cgk2wTtCGHGTJcTe
         LUOO4pS3ljw4kbc2q9mUyU8aeYtUaGb8Y4/7S/+FYllF61Akvec2G1BvAAjT9xXJo4Uk
         y1S/goNji0IY5NT1oKwYT8dtECmpADEawsU8k45Pp4NFD3G2VlkqYhEfDFo3vnh+GdRk
         Szp6dqj5gxgap1KnnZIoJhYkIu2vw6npU7Fiia3YSE/TwwM07rnunkHDjqajxWi+0cEy
         yTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4cRBxdj04+wlkcjfA3qjSmIs03pt/tDImt3LLTGayNk=;
        b=f+hXAL0AA4AwFDas37VsCymNd5M97pAlVKU+uAUUAyvSxBEA6gdW450t3/lKZNmdA5
         wyvMX1oDJL34qaz3ketilyhrCRwiTkxR+DncJSXnQlL+R0aO6l004Ft9e9xS7lPZeUfM
         7Ven5CDhz/uzGNPE/e/xo7wsfkw78/41QGb79s91HKdUp5vUOVhA1rH808mvA8Hcj/S1
         HQdRCunqDJabFQ06O0QVaGXORNlx3URxfVxPrQEqFghHCHxfN3mCF+AUmTi0w/MZOxrs
         7TKyAEahkfrNHRKsJMYIvcf/f5Eo04g/rYAKQKsFR6sX6SbyM35HwQu9F83WN5F6c+3j
         jOyQ==
X-Gm-Message-State: AEkooutwn4ZJ57k2TF+VEZIVVJCybjMxYeyuY8oRhx0ipqiBnyT7LKXsX4dKzfX0qGNEPg==
X-Received: by 10.28.15.194 with SMTP id 185mr12276430wmp.58.1470583067136;
        Sun, 07 Aug 2016 08:17:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id t188sm18921718wme.19.2016.08.07.08.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Aug 2016 08:17:46 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] .mailmap: use Christian Couder's gmail address
Date:	Sun,  7 Aug 2016 17:17:31 +0200
Message-Id: <20160807151731.29566-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a714e69..a408ac6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -33,6 +33,7 @@ Cheng Renquan <crquan@gmail.com>
 Chris Shoemaker <c.shoemaker@cox.net>
 Chris Wright <chrisw@sous-sol.org> <chrisw@osdl.org>
 Cord Seele <cowose@gmail.com> <cowose@googlemail.com>
+Christian Couder <christian.couder@gmail.com> <chriscool@tuxfamily.org>
 Christian Stimming <stimming@tuhh.de> <chs@ckiste.goetheallee>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
 Dan Johnson <computerdruid@gmail.com>
-- 
2.9.2.558.gf53e569

