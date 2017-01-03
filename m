Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9401FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965656AbdACSuo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:50:44 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35962 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbdACSuh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:50:37 -0500
Received: by mail-pg0-f44.google.com with SMTP id f188so217396839pgc.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YAeaHHSkOmPbKVBRh1ojNXYPQuCOW7LCuvu23hQBUq4=;
        b=XubPxWXZDRJnPJcf12zaLiB9P3l/VrAuW/900ImeFtRCiFEx+eF3+WyU9xjq36Opej
         GD08424GvTPz3X7vF/i3EWqJrCMDxyXDpL85P2Sb87SwH2EcCYvsQjWNQhPn6fEFIbKD
         TEAG8t8WVEddUS5SYUxtc0+PEDaTpZZJk/A5JH5aitBY9yMsq3kOLy22EkxUtd5oLQQz
         0VoirSUry5MjdLomkGFoVMMqmSCcbHqw7+c7XRXN7hFwUPScUBUTmWOmcD6vJnrhS3wH
         s2QYX95bOhbH73DcHCwU5tm64wWfFfduuJ2Qs3KbBuwfN72Sn+2eDQFC8y+gcrZ6r3qV
         b0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YAeaHHSkOmPbKVBRh1ojNXYPQuCOW7LCuvu23hQBUq4=;
        b=iwstxMH6iyF4z4iNXbFe013PtfYeo22brKaNoB4w88cy7dIbE/6j3i6dm9IcivjfGX
         kLb9LAXWAjeTflR7XiuUJBcjI5rE1NYhw6rtzrG7Y3/5t591dwNdfkfD2RB3XoAZGk/F
         L301rYwnZl/je8Xb4g1DqxAiWFbMS0DR0QEzufjePDj61yetlL5lsbN6RuhBpo7oWe4s
         tX/L4e7AWmWFuX+Oq2vgJRZgd4DRhjSVWFLNzIzgxK6TjuLVmA9S1+GyuAX9OzAsJ4dM
         yps82KHo+PmUCkrbDBxnhLgstcgO6mIfVdihVPfZic1gjbqqXFsPsq0HNECHpkpUx8gN
         JOdQ==
X-Gm-Message-State: AIkVDXIrTH1eFB43tKnUs6XaN9tJrfDO8cz8Ic5ZNAsIJAoYQNNekL1cdPghdnSVjZiP3kz9
X-Received: by 10.98.192.208 with SMTP id g77mr47840392pfk.118.1483468988634;
        Tue, 03 Jan 2017 10:43:08 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 07/16] pathspec: remove unused variable from unsupported_magic
Date:   Tue,  3 Jan 2017 10:42:32 -0800
Message-Id: <20170103184241.128409-8-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Removed unused variable 'n' from the 'unsupported_magic()' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index b8faa8f46..b9a3819d6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -333,8 +333,8 @@ static void NORETURN unsupported_magic(const char *pattern,
 				       unsigned short_magic)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int i, n;
-	for (n = i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+	int i;
+	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
 			continue;
@@ -344,7 +344,6 @@ static void NORETURN unsupported_magic(const char *pattern,
 			strbuf_addf(&sb, "'%c'", m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
-		n++;
 	}
 	/*
 	 * We may want to substitute "this command" with a command
-- 
2.11.0.390.gc69c2f50cf-goog

