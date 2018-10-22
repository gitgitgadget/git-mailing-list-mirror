Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8285A1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJWGfa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:35:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38711 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJWGf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:35:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so19658175pgq.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p7UR5Kclt2dGuJopIM5uF6sVAIQ9zxuL49iu0o8UPI4=;
        b=k4/t2acDOX1O5M4OiK1E849wkSlFgC6H4FViNIJ/oSwN+34cUmYh843jTWM8/hlqBi
         JX3u8PRVj4wMRXei3WbPXRcMqSUeYcDMwL6BN3L6ovM89MWnNYzngDESo9nOXQsTMgJg
         kVFiVvR85/uQbgsJ7JoAb9zI3TSuidLqrQmSDlHzzjCp/F5vRjZgxMh6AdkFnXfTMEdJ
         Yu9dOqA8vHpl86IoI37KJ2vwq7DKTFn/8/6UYGcZck+TFtdsdEeCdjNlKdANxThptYSE
         G5/1IV5JqrDMvTialP7P+AhXHAFpuEHOxNFDJraiWIz9v9FTAYl1a4TKGSFZqZ1p3NII
         V0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p7UR5Kclt2dGuJopIM5uF6sVAIQ9zxuL49iu0o8UPI4=;
        b=YHA6cGFUXeeDOUZPj0+ShMKsesW8vifhJdL5len8G9zSm+2wZGfbpkj1ltQzdgQVJ/
         GV8CLDE+gT0/ixlVkWoKVzvh5OeLYCBruDWrYMKy9BOXNrdw8sKQTwk8mvg/8907heew
         GBxCsU7tzRmoLl9IuAAHu4Dtmo6lJhzhsnXaCEy0bcLllbS+Ie0DkJ7hYY1nSaTOusp7
         5TnRypXdYMET3XkgkzImPfPY72h9oeqNcT/N/rglzydV2xHGz6zYkVkr9pkvA+myuXBn
         M6dPIFuKFV1YRo/Ta+vwe3D7N0WaAX3Em5rwr4hpaAbbU1HyuS9Ou1bTSojyshUG7E3h
         WY+Q==
X-Gm-Message-State: ABuFfogIu1G6mczlzbXorqjN/texE3ANaQr7Ef6HSZCo0TAWTPsU28c2
        SuJKddjN2lkNP+XU/np1I/sgvBVr
X-Google-Smtp-Source: ACcGV62V3MurSUJSOTe4s2EV3DBQdwiAmLEh3usm1ByrTPLcNkUYHDtP/F7e2i0/NlhOq0p3XKHPvQ==
X-Received: by 2002:a63:c908:: with SMTP id o8-v6mr13276875pgg.261.1540246503000;
        Mon, 22 Oct 2018 15:15:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id c124-v6sm45294198pfa.119.2018.10.22.15.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:15:02 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:15:02 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 22:14:56 GMT
Message-Id: <88241ad327ac42b94046a7e7ca208c84fd9f4578.1540246499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.52.v2.git.gitgitgadget@gmail.com>
References: <pull.52.git.gitgitgadget@gmail.com>
        <pull.52.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] rebase (autostash): avoid duplicate call to
 state_dir_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER Gabor <szeder.dev@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already called that function at this point, and stored the result in
the `path` variable. We might just as well use it ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 313a8263d..d21504d9f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -251,7 +251,7 @@ static int apply_autostash(struct rebase_options *opts)
 	if (!file_exists(path))
 		return 0;
 
-	if (read_one(state_dir_path("autostash", opts), &autostash))
+	if (read_one(path, &autostash))
 		return error(_("Could not read '%s'"), path);
 	argv_array_pushl(&stash_apply.args,
 			 "stash", "apply", autostash.buf, NULL);
-- 
gitgitgadget

