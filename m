Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4616B1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 08:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGKIXo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 04:23:44 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38805 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfGKIXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 04:23:43 -0400
Received: by mail-wr1-f53.google.com with SMTP id g17so5248174wrr.5
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RzoiV1siSLUuFR/GiKjsWcjfiQe42SAneMxFQ8a+aZU=;
        b=DWqTfqJI/aEruE9mDplXqHYWuYmo0okzn8wcRGfs1BVE5lxvgPog7Z/kxQ/3b9+Htd
         xJzLcOyO94mkoaiRKad25hAnGpz/9PeBDTBPrLo6W48UVEK6tTKtbIohKZ735ixFBwnx
         KpVSErCdg3PCEorKV1/hvkmCH6rJ4+qT790AsEvIW2xvcS9M9iwR2GTAnF/Kd8e4MARg
         bwxGIA+DHDIJxniRNMwu0AP3tkJmSoaDN9T9V9hONv+DDU51LxMeE+rNRutwpZk56bIl
         qWklnSNK1v0ilLlOop0ZSgPUoKOO12VHRhZSHcNQK7EKrTeYD6VIq4cpnYkGEj8INDnS
         MPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RzoiV1siSLUuFR/GiKjsWcjfiQe42SAneMxFQ8a+aZU=;
        b=JwRn0853fsq8CpP9caqTNtolWLv1Goiur1V+su5E/RK+GxBOjTPgXEKW49La4TlZ5r
         FZoLNBEWU4/JUSC2AOkNn/8Q+XAlThLc/9Crn8qF1AnKWz0m62qMbryxcoQFRUCyl2bx
         eI4sO+y7+NSzMuNH1grwN47Ua9S8pIiLMlspXy4uPdnx5WRoPuFCe0flLG4CHMSLtaYj
         jbj4AQcrY9/K0fMq35KmC86VWv2X6IHilZYqj66xjY8XHgyIc6NTPFrzW2+tb/YBU5D0
         p75yXdGwfbRvoyp7C10aaBNlo2PhD5KZc3ZG6Vi4DB+PK88K999ABi5SRPklWO971sCW
         K9WQ==
X-Gm-Message-State: APjAAAU2NW4XHu+tquy+Ms6Av4YZmPn+wQGpF4QjtskceG1s6nViVoa7
        VVKTQcmlp0+Md2w733SIuIcNjJ6I
X-Google-Smtp-Source: APXvYqzsM4SCgphVRf+g476Ds2iv6OoAP1oh4afVNlFhhcJeuFgN9cMYFNbvaHhFnYIiCYbcuiDq2Q==
X-Received: by 2002:adf:e483:: with SMTP id i3mr3430703wrm.210.1562833421823;
        Thu, 11 Jul 2019 01:23:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm4313383wrt.93.2019.07.11.01.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 01:23:41 -0700 (PDT)
Date:   Thu, 11 Jul 2019 01:23:41 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Jul 2019 08:23:39 GMT
Message-Id: <8a0213291b2afc8db9243808319dc86b736122c8.1562833419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.213.v2.git.gitgitgadget@gmail.com>
References: <pull.213.git.gitgitgadget@gmail.com>
        <pull.213.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] diff: munmap() file contents before running external
 diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When running an external diff from, say, a diff tool, it is safe to
assume that we want to write the files in question. On Windows, that
means that there cannot be any other process holding an open handle to
said files, or even just a mapped region.

So let's make sure that `git diff` itself is not holding any open handle
to the files in question.

In fact, we will just release the file pair right away, as the external
diff uses the files we just wrote, so we do not need to hold the file
contents in memory anymore.

This fixes https://github.com/git-for-windows/git/issues/1315

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff.c b/diff.c
index 4d3cf83a27..42affb6dcf 100644
--- a/diff.c
+++ b/diff.c
@@ -4206,6 +4206,8 @@ static void run_external_diff(const char *pgm,
 	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
 	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
 
+	diff_free_filespec_data(one);
+	diff_free_filespec_data(two);
 	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
 		die(_("external diff died, stopping at %s"), name);
 
-- 
gitgitgadget
