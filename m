Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F36C1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeKNBES (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:04:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34688 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeKNBES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:04:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id f12-v6so6166166plo.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5hmPzSILSwU20QKm9epAnbGuHcIIB/Aeu/+ZhrNxMR8=;
        b=soK7XThyIuZkSVPkylnPRmdA6owlvE91JZG0s5LEbqC6nzJkm+yLtz+/Jtm42aeKXT
         ttw3Hh0TTVZOlTpfqKeePxXHglxnGQ5SRzf+DJCHXd+J+1s0NoeTnJsscGpMxXziDyif
         9u0VENR8D26uYeZLjM70kPS9SwWQz9Vaqs03asBv5taiCsn/t4QGsiQkaDHk3Os18E73
         5Utj9qE3ZkLoIxvbg6Gkn6RXh5TULUvvTtNtCIW+4B2I54SRXwRf6FeQt46Inqd7wIW3
         sRax/7xkFQ8LyMDa2pMB0pwJ487uVVwbrT75pRIoZRP72nLiCAcnu51yZrZfCDAHKozB
         LO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5hmPzSILSwU20QKm9epAnbGuHcIIB/Aeu/+ZhrNxMR8=;
        b=TReXXySfYdjS6Bc81hkqGaz+tc0HE0swYPaW18wDYxBcKAOZ8Njxjx+cVPmi4TNJ1J
         tSdmIsTDJXUycIpzwhrucNgzDh3+osPG+SWsHSo3UWRdf6SeeueP/jdyFmj9+7YGhMTe
         RCUqutjMmDvwqGksea0sygapqe4mMxWBFNgspQWdMABxvND/AzVQqu1G4KN5LZbIgsgk
         Hc+3ShjCI7fIoNJq67Xn+6u/bLXQbcrfkty53/ffqMu1sqt6CNMUfZaERYLbWZ7EdGZk
         R30NKPmv9xCZChQ6wFlV77iLP1xJj3BcPmT6iuXwj3nFFelEn3FZdq8Ha5L1mu1C9EJi
         6S6w==
X-Gm-Message-State: AGRZ1gKeG4qGoJpPvT1wiDgja0cWk4qZFYNLdtFP7Qnr4RxWIgXi/LYS
        bbHXzUW1AxFJhZpGJg7pigYX2lNh
X-Google-Smtp-Source: AJdET5cltBb74nXEa1sbXo9hRNyKD5aGM1B7C/spRKQmWLjNG7vLTnZ+GIc4CK2blDjYdTVHlF6AlA==
X-Received: by 2002:a17:902:b584:: with SMTP id a4mr1690699pls.246.1542121545199;
        Tue, 13 Nov 2018 07:05:45 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id m17-v6sm22678383pfi.102.2018.11.13.07.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:05:44 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:05:44 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 15:05:41 GMT
Message-Id: <a3854e4ed8108c8fde5cd4e2107e90ccffafd49b.1542121541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.78.git.gitgitgadget@gmail.com>
References: <pull.78.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] do_git_config_sequence(): fall back to git_dir if
 commondir is NULL
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

Just some defensive programming.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.c b/config.c
index 4051e38823..279d0d7077 100644
--- a/config.c
+++ b/config.c
@@ -1676,6 +1676,8 @@ static int do_git_config_sequence(const struct config_options *opts,
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
+	else if (opts->git_dir)
+		repo_config = mkpathdup("%s/config", opts->git_dir);
 	else
 		repo_config = NULL;
 
-- 
gitgitgadget
