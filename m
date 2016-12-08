Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0341FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbcLHTC1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:02:27 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36293 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbcLHS7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:35 -0500
Received: by mail-pg0-f53.google.com with SMTP id f188so176159048pgc.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v1YS/J83Eu5nrPHDPpheoNGguZg0ZukbHxQjRUh1nnc=;
        b=na7BXMkRpw/PGGMiwAPa3X24D9AfIc2iVcFAjjcx9MB6BlAN19hqPDTX3bW6ynb0HM
         kR3KLNwN/qI0+0y5vQoV8uRM3fPsza7Df2wVMqOi6x+NzGRHe+w9m/rRc4wGIYC59bq4
         bJDfim56wZ7Vngeyx1hJye1tCRrZfhG7dbvyG0Mi6mcuiDEn1iXzRqtzlA5KCjKgBXKc
         VJp6+L7oj1ZHzrllAXIPuPta8Id7VmGk3WgyU4hly6eekb8xLgeAy2NYFcdRwYtyG5Jt
         PPXVFufvScxfd4IVeWwiC6rYZjxF/ZX2poUsc1puGREFPzg58ZKsx/1h8ZQCjI+jFmde
         gmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v1YS/J83Eu5nrPHDPpheoNGguZg0ZukbHxQjRUh1nnc=;
        b=lkfoPEZ04eAAaLUV+tOjBrBEFiJ3I4/VpALBGA4f104A28ASaR/ekOvD8qqTSM1+Gd
         AxT59LZiG2USVZqelY2jS7JoUs1IuPhjVz/gdEAB/0gyxZKgXtiBtStJ8/lh2o0Fy0tv
         HD/VvKRv8qWeLjv1fZkzeYqwTtzfUeVh3MNOsR0e8pHmw28rLD7UbtrRjWMeT3sNUX+q
         aNO/DTyp5NP375hFdiUuzTVXrj4mDpx2PTG07jihfo+Aww+hvGw+Ix/KvzGaoftmZTTb
         7KJFR+3zXEaVjfMoOD/uHYHbvc2qMt/IKnb9LF1qy7WI6Vmw4Q1M825efvSCt41d/0eH
         XzBA==
X-Gm-Message-State: AKaTC03lKH2xik4lD6u708HEBnyEweZVw+rQHw9qfyxezlDwiUEtMES0+neqJnGanCLgMKu4
X-Received: by 10.99.146.76 with SMTP id s12mr133015623pgn.8.1481223574525;
        Thu, 08 Dec 2016 10:59:34 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:33 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 07/16] pathspec: remove unused variable from unsupported_magic
Date:   Thu,  8 Dec 2016 10:59:01 -0800
Message-Id: <1481223550-65277-8-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
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
index 8f367f0..ec0d590 100644
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
2.8.0.rc3.226.g39d4020

