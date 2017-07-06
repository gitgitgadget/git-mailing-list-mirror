Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F254202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 03:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbdGFDUT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 23:20:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34845 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdGFDUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 23:20:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so1165838pfq.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7jvnRwuoawLQ/W8+uwdfz2msAORLU8onyEB45U36kOw=;
        b=rT+nm5pFkbFFtHO81uh/NxaNIo15/I7v4iiqFLppRpUqDrNl6YeznZ0isIMXX32LVC
         zAlSPhssZtCVgl5B1xjYMI9JfEWgK3yq3Xk7N8ew0lp5A9bRNtckdB4kLGV00rxmQvE4
         xiJ/N5Qknj2K6Ol6q75mvm6iFLlgFGdsnwLGWtpkNRJsRWVwk13EnsebHeW56+mQ8w8Y
         k+XiF2wtRISXN6Fa0fnNYbhQg1BNwOzfHZZGYUvJVKDjgPz+I46r4uGkQcnf25aWZUMQ
         vVIDyNyyvNAejZRyf2KNdfScp12SPN176DJqrGwJL0o6hUbLpPtST3aM4bjSv5C3YqMJ
         gz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7jvnRwuoawLQ/W8+uwdfz2msAORLU8onyEB45U36kOw=;
        b=RUU6lGL9iBIg9Gpmnrgyi51Lp9dF6uzPgo+I7mgmnUgNtUrImZI7k4bRwWjWEIk5On
         G8lJgTgRyuLRRY6Pxi4fkigBnsxzPt3V/ks9Xm2lMnOgScIe4RQvlmkQoNIfC8RmeoMF
         9FsmuZ24g7LZ0ZCQQb9zzRHPkaFLdp7PDrCozoHmyV62bu/w+yIHGp3/By144fwDSYtV
         Cf+9M7ON1iTRpklum3zSdYTiwa6yfJRf9VXGbhzaFu4reYOt+OsY5vUNcjrq8n5qy6UH
         Y8zANrBnZhGeL3jiZRwchlA1lhUk0VpxCQaAezzADu2it09I4ZGv9chr2Xbu5zGFcBwC
         t8Hg==
X-Gm-Message-State: AIVw111+xEVIdOJ7qoGC1XDS5h239KGFRCb5vV8wH/ilgCQtv0p7zkPg
        724UMMPBntimIg==
X-Received: by 10.84.224.11 with SMTP id r11mr26336286plj.267.1499311212856;
        Wed, 05 Jul 2017 20:20:12 -0700 (PDT)
Received: from unique-pc.sce.com ([117.246.77.117])
        by smtp.gmail.com with ESMTPSA id x85sm949583pff.92.2017.07.05.20.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 20:20:12 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] comment: fix a typo in the comment
Date:   Thu,  6 Jul 2017 08:49:57 +0530
Message-Id: <20170706031957.5782-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqq8tk2iw87.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tk2iw87.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..aff6bf7aa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -984,7 +984,7 @@ static int rest_is_empty(struct strbuf *sb, int start)
 	int i, eol;
 	const char *nl;
 
-	/* Check if the rest is just whitespace and Signed-of-by's. */
+	/* Check if the rest is just whitespace and Signed-off-by's. */
 	for (i = start; i < sb->len; i++) {
 		nl = memchr(sb->buf + i, '\n', sb->len - i);
 		if (nl)
-- 
2.11.0

