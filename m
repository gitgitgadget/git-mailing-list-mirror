Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D681F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbeHPF0Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:24 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:55787 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:24 -0400
Received: by mail-vk0-f74.google.com with SMTP id j80-v6so835448vke.22
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LoYQkDMNC5oV7oV1C1KRgNBVF1lkSBoP6KKcwZVTOGw=;
        b=Zn0qPmsmj/nOu0wQOd9edngeT8FZw7U1K5WNo5XF/E3qOHslhyXoQJhfjBzyNwD619
         rhRUWd/bhq9Am5zXRklqVpNHU8zw0eP5J+hIMvx4k8HYX7FU8QWQftugMJz/k99QhoH+
         SqRa+e9DFfO7Tw5Qs4escRkwAoyGtMrtKv3YIGu8aDKsbeOBdwgR7qxwFgTzeuNIJ0u1
         RyRgzzZH/+AvwdW0QbcHC6UOg+Ywi8Agkcch3K2x3SIy7brkn8f5zrdOzZTl4sSg/fqY
         HLZSIc0B756PNJ4IyEhUldkdtcQnw+bFYLYgtSL9PB1DGK3ffiR5m4z6XtemizuxoIGc
         Xqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LoYQkDMNC5oV7oV1C1KRgNBVF1lkSBoP6KKcwZVTOGw=;
        b=Q5ry2rR5S/n6nqC0Sx8sK+AYEJk9A7DqM0wCTR+tKOW20WeveK+5Ja5tFWxbIxGsV6
         2Ha8SuGLutaWqbwUC9WWwwNtrgspi1pnXXID7FQVoXqw4kbherUDKMn4PwmgAimyGOqm
         I9tnRgiV6JqugiOzgKJrJr1nWwdSxePJ5NucjhmGQAJE6K2ubjQoOQOV62RgQa8RfEqa
         FtF+g+SkpcedeQEvyOsn4EY/ma37Vd/rrgoB/Pqzges8VreN8k+GZMGxFCJ+jtcMQl/G
         jMO4muHjz9wUdOEMuWgm1FoJfxzKzNnD5FJlE6qvFZNnWU0O0Fh9dxdwb8UGJrQzjRSC
         IsTQ==
X-Gm-Message-State: AOUpUlHSZfGY84Zsg2he31mV1C33lVAb24/M2QRmwz0W6SatiSpJdRzt
        OlSanUTxlZteihddlcllZSF8NQhTu+BxqEEInaZb605k7tu2BcyvRHt4jx4jQhfRDQ/w6UKf+bL
        fL98+AH6KHNtFy1rPBCKQcdAduwokn2pPlEZS+L9EQiLvINqiFB69CTy2kI4q
X-Google-Smtp-Source: AA+uWPxL+mcosB//SyoKpUVtQFWgJTCieYDe4DXl44aRrITvaiKbqnjHsppLv1neSIXTlveudq0cMekPQ6Ml
MIME-Version: 1.0
X-Received: by 2002:ab0:50d7:: with SMTP id d23-v6mr13308006uaa.125.1534386676255;
 Wed, 15 Aug 2018 19:31:16 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:30:55 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com>
Message-Id: <20180816023100.161626-3-sbeller@google.com>
References: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 2/7] builtin/submodule--helper: remove stray new line
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5c9d1fb496d..2f20bd4abdc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1024,7 +1024,6 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 {
 	struct sync_cb *info = cb_data;
 	sync_submodule(list_item->name, info->prefix, info->flags);
-
 }
 
 static int module_sync(int argc, const char **argv, const char *prefix)
-- 
2.18.0.265.g16de1b435c9.dirty

