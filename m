Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04538202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 11:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCNLZG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 07:25:06 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:43231 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCNLZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 07:25:05 -0400
Received: by mail-ed1-f50.google.com with SMTP id m35so4268232ede.10
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+cWzBxcspPIbLQatGZXn0iceHlZ+TVbiKM0EY+YiwU=;
        b=gwTllcNuRj+/BYLIbt8UQwV2u1Lw8U49iIVQzf6LjRb769+FnLBDoAQE27yKZG6Br5
         Okgm+ZfNeNh6yEhPStK5iEhsM4J8no4QTb0yp4oMmFGu+C+NK7gs3f3Bi5ohbw17NkOB
         vB3SGGpWniCfzcM0J/6hTmOjY8Fq1ESkPKVsVtV9NdMw5yd804IjCvXxmKzhmPCfYhyu
         FTjN9noGdu0o7Q/LwrSB1NIbPejoNEXj8pLS4MlqQp0QPIdyvXk+8hEEbZfow15TrMHJ
         QkXFN24mQeiWnzOrr7hIQXJ96zLSsJclSUi/YZwOo2VVH6afgrga2LRZPJCdsgTCUv4C
         dKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+cWzBxcspPIbLQatGZXn0iceHlZ+TVbiKM0EY+YiwU=;
        b=k3CbB3Le7cY0SbOf6zYpcUOSj4KaQpcCRY/wtQUoedu402MwWcWlqOCB4S4jDmg+9F
         HLRm1mVAsZ4VAwTU6oMpUnyQNs7R7Nif5UcHUbWydJOH3gNitgImy/6YKRU8/z3AH2IK
         t0PTjbQN/WjTNc8Rhm0xVmRZBP37BN8bAllAYewpz4N3GQZDNPLU3psMa0X5cwAEt3u3
         LOyH5+AGNrC8WNcuomEeX859TeZvqqbeOivWippsDe7DyCBdt3zhRjwISgSnH+UCG6Pm
         IQQCe4sgqE/5e/d4RzRc5bVI/a4VmnmzByTZhel/oWMDjAdVCcwm0BhyP8Oor1/kZGnA
         nQIg==
X-Gm-Message-State: APjAAAUZinpmekvZweJmh3EXNDai9FUM1+J44R2XlSdRrBT3+G+l7QsR
        p4exN/w397ojlfwlGozwV/+41Gec
X-Google-Smtp-Source: APXvYqy40jAm/TzHurXi1lXKuLatMNggICKWEbHN0u7JpxGRGtZjHyiHFT2yvI5mkTIe5ejW/M2FlQ==
X-Received: by 2002:aa7:db14:: with SMTP id t20mr11037683eds.231.1552562703865;
        Thu, 14 Mar 2019 04:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm1380266edh.83.2019.03.14.04.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:25:03 -0700 (PDT)
Date:   Thu, 14 Mar 2019 04:25:03 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 11:24:59 GMT
Message-Id: <2ad91f19c5b8c7e043e5944a1c075ad23612b59d.1552562701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.163.v2.git.gitgitgadget@gmail.com>
References: <pull.163.git.gitgitgadget@gmail.com>
        <pull.163.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] difftool: remove obsolete (and misleading) comment
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

We will always spawn something from `git difftool`, so we will always
have to set `GIT_DIR` and `GIT_WORK_TREE`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..31eece0c8d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -727,7 +727,6 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (tool_help)
 		return print_tool_help();
 
-	/* NEEDSWORK: once we no longer spawn anything, remove this */
 	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 
-- 
gitgitgadget

