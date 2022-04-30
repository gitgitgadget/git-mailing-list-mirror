Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE86C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382201AbiD3ESo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbiD3EST (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051037A98F
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so432976edw.11
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRaeyIvLG/+8n8vzp1hUVKFLUp5qA4nbEz0eqgOp1Nk=;
        b=GgpAp2Sr3+4HyER/GKzVgt84hwQh5HnAIT+F/qsxUQe6154208ItTKzPT+ponAtZKc
         pHlcN9tBJDRX/N6uCQR5SpgJBuk98DQIF+4+1646iPDq9y1FRjyM38x/T0khYq6YbPNH
         t8B9qHvlHuzF5spr3aCnUzi2rV27h13qSCJBv34kDV++CQrAt+e2mEdJEQ1vPAj7LO6m
         WaKB0dllSWEJszi7cDT751iS97lzAPfziwwFpRR0c304mU6KFUbAWba1fUyH4bCr2QyC
         WwO/kxsTYaZRjga0cNgN9D309Y4ONGAboFfbUR1Q9v7YpTHWJBcKUqHjbe1g9kLyhX6g
         ovjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRaeyIvLG/+8n8vzp1hUVKFLUp5qA4nbEz0eqgOp1Nk=;
        b=wBRoh+/Y36lRz8SWLH+QdGsXnw/GVh8VcD2zhH79NywzjFJ6tlzdHC7FOXBbTQ+9o/
         SApBUQ9g/7fgfMeYQUYu1ncPKX//ih3b9hulSjB7uEMuFV2Sa+ojPRRvpsV598BgnQaN
         sdpp5J5tQudUlF1ZHgfd6vxZFRhNYT0NxOwY7JBlBu0Q9OfQ+V3XPImQ08Vg21WDvARz
         eWSZyF/7tC+B/c8/8q8GR61kRHwn2QCpoM8x8fkMvASuOvo2fTvt3xHiIlu4V++Vy8Zk
         7DJhj9Qw4HJ7JHTg5leTzAxIUY87s8TUROZOa9Lu+rVLMgFNl4ypELMWzUvBc9vDLexT
         KnxQ==
X-Gm-Message-State: AOAM5315Xy6tjzal1Z5IPSpm6d5tU+xiMauHtCTTMLA/uypCBvENyPTG
        TccvQ57XPUmZgmaPnywWQQ+T8EAhX2g=
X-Google-Smtp-Source: ABdhPJwl7qLC6O4m1rC7aQjZRtF8Um9hJrrGUNh3ern7NH4VhLYNtfY9O9p+9dfzktJKnQu5svV9BQ==
X-Received: by 2002:aa7:d416:0:b0:425:f5c7:d633 with SMTP id z22-20020aa7d416000000b00425f5c7d633mr2589608edq.105.1651292082089;
        Fri, 29 Apr 2022 21:14:42 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:41 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 20/23] builtin/shortlog.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:14:03 +0000
Message-Id: <20220430041406.164719-21-gitter.spiros@gmail.com>
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
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 26c5c0cf93..62c4a4eaba 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -81,7 +81,7 @@ static void insert_one_record(struct shortlog *log,
 		format_subject(&subject, oneline, " ");
 		buffer = strbuf_detach(&subject, NULL);
 
-		if (item->util == NULL)
+		if (!item->util)
 			item->util = xcalloc(1, sizeof(struct string_list));
 		string_list_append(item->util, buffer);
 	}
-- 
2.35.1

