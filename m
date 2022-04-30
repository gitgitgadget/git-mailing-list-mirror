Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A18C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382290AbiD3ETD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382204AbiD3ESU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3AF6EB0F
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so18665529ejo.12
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZxbhKjEZ8Or6/polrg/mQ7xB1PUvAf+YLX2+y17z9c=;
        b=G+pd/RyZWwIgkQXUAeVvknPgP0n9xqFr5QCXu49fXM26ZTTo2ARpvgThTx++sgQQAV
         35Pld3h5DSDyWWQk5ZTZiiiAQICn7xLJTssHqD5VssOC9iwA/fgCXxwA7bW6rOKji+o/
         rUqfsawbYTpgL1QN4XvfwjzNQN+vDruKrG72d/YGO5V8PACm1TT2/5AjfQKixztEn4OP
         r1uY+vZquqUWytCZM5LjYbhapNsrXqYBkVxIQv1PzIgrrwSJeLJwOPIvyVlRWqxHMP00
         iAVWmKpd9Nj17S+PV7J0cs38LbOCmManxTj8W8KtJ+4pV1JTqDsXKUrFFSc0Oal5wQA3
         KGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZxbhKjEZ8Or6/polrg/mQ7xB1PUvAf+YLX2+y17z9c=;
        b=yhkEo1S8mmiA1Am9SbU//InN3Bs+4ZX8tn8ChAbDEJkUg10ev1Pg9AJ7idT5eZWNld
         rv8Ma6Ol8oMWLbPJvZRI5g48Sh0wJVDT+OitMKekwAkbpTEBIiuzh1P6R5txUnlzn/G8
         iLdhfZ260/uxnmaWwN0aTmbQb7LD9UpQaRsV3uV04i6Fsdbltl+aDrVOGJSmplWaTxH5
         F/uOskIZIS9kqdRzBmsaffFJbtG+Klu4xM3s1sItuISHsJiHinDa/yP2OB4NwANHITFs
         02A8drbaLd8aulIoNEcMCgklsb/q8vUGjm8QafPzs79dvCyk8jQBoqh1JgzXK5TGC851
         CAwQ==
X-Gm-Message-State: AOAM530jNq8aOfs3rNgiiE25NaAf3qWGWNTBQmD/tDCLeEqs+DahEHxf
        JaC1YuuuRXgCAlZ3LrIwvvOv1T2KFXI=
X-Google-Smtp-Source: ABdhPJyfS6YM77Ws0UWhYNBLCZlMfeyIDn45MzosKMUnNpDGpfQqHt5NxzXdfjla4cVBhrc5pUjmDQ==
X-Received: by 2002:a17:907:97cd:b0:6f3:aeb8:6002 with SMTP id js13-20020a17090797cd00b006f3aeb86002mr2272072ejc.530.1651292083889;
        Fri, 29 Apr 2022 21:14:43 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:43 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 22/23] combine-diff.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:14:05 +0000
Message-Id: <20220430041406.164719-23-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430041406.164719-1-gitter.spiros@gmail.com>
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adhere to the git coding style which requires "Do not explicitly compute an
integral value with constant 0 or '\ 0', or a pointer value with constant NULL."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 combine-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index d93782daeb..b724f02123 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -195,10 +195,10 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	struct lline *baseend, *newend = NULL;
 	int i, j, origbaselen = *lenbase;
 
-	if (newline == NULL)
+	if (!newline)
 		return base;
 
-	if (base == NULL) {
+	if (!base) {
 		*lenbase = lennew;
 		return newline;
 	}
-- 
2.35.1

