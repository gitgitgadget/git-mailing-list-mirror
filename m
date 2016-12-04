Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE17A1FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 22:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbcLDWFt (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 17:05:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32850 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbcLDWFq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 17:05:46 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so14309075pgd.0
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 14:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rNu1yupzrZ8Eg+2loSB1ipzg4E2x6lpRXmpNrcIPSa0=;
        b=L6StVUR7DGAwk/8FgWw1GRNF6tJ5/0eYrb2KVJgvuPEM19JGVRNYz6KUCVadyUDdbo
         qXRZD0uthvOam5KRJhQetJYrpJzkVH5+w8g1CC/FtII8RWNXu3e7RwkMGNPT6BGIvSrc
         PHQJnLyfp+PKzpOz0eJK07kSggcGrTS9rM6SDWDmtNwUhJf+jaC3MR2/tPjG+7HpwkjU
         LPLWMqMY9Txx0u7/h/72szRL5ct3ZAeyY3fDP8RAkCDUy+tSOFX+wXg/KWiQSpKFeIb2
         oCcwnze4Ud64qSXgHdcoAf1TQzXUd9xE/WYwa+dcDctbxqYQr8rIbgcT/in4PbSwx4YL
         YDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rNu1yupzrZ8Eg+2loSB1ipzg4E2x6lpRXmpNrcIPSa0=;
        b=eeJXeoYT/xkftTYQUhN4pru6OZ/Js3gUrm4YExsZJhSZEC4hNbgO93bl7e5WknhQcS
         vNz8g7e4lgJ7EyZH54YdaIA7dPAZYZOberprondaeIbMrkQ4UkxtMXYiQtmmdJDyLFmW
         AECk65iH/e7Ct5Xi0TJu3NUEdPjbxHdg/RmxCJFDWtVD1ZUbnP1U+fNCJih9QQwdRVmP
         UlyVdXVx2RH5XBvjK9KgJRLyjRO/smZHUqOC+O4cjx5bju+Y2t05zkAYELj0hbaEFBgt
         TzWu9jtowaNPeI4IlYYikEg7jPD/A9TedBuXPeW0aVsBYz1/dnmvCxa1FBTwagY9hKOc
         LmEg==
X-Gm-Message-State: AKaTC02CSbZLbtChQHmxfnynL/RWcpjngcg18Xm2GxmbPlbw8N9LccNRqerTX50M/E2HFQ==
X-Received: by 10.84.209.143 with SMTP id y15mr119129725plh.173.1480889088604;
        Sun, 04 Dec 2016 14:04:48 -0800 (PST)
Received: from wolverine.hsd1.ut.comcast.net ([2601:681:4101:1302:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id q2sm22277897pga.8.2016.12.04.14.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Dec 2016 14:04:47 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] receive-pack: improve English grammar of denyCurrentBranch message
Date:   Sun,  4 Dec 2016 15:04:40 -0700
Message-Id: <20161204220440.30916-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The article "the" is required here.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e6b3879..6b97cbd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -795,8 +795,8 @@ static char *refuse_unconfigured_deny_msg =
 	   "with what you pushed, and will require 'git reset --hard' to match\n"
 	   "the work tree to HEAD.\n"
 	   "\n"
-	   "You can set 'receive.denyCurrentBranch' configuration variable to\n"
-	   "'ignore' or 'warn' in the remote repository to allow pushing into\n"
+	   "You can set the 'receive.denyCurrentBranch' configuration variable\n"
+	   "to 'ignore' or 'warn' in the remote repository to allow pushing into\n"
 	   "its current branch; however, this is not recommended unless you\n"
 	   "arranged to update its work tree to match what you pushed in some\n"
 	   "other way.\n"
-- 
2.10.2

