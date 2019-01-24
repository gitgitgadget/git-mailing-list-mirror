Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6AC1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfAXI3W (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:29:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40640 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXI3W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so2346948pgp.7
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7iGSvWK0La1kyVTghgImSZBL01vL8BFl8y4phqz4dM=;
        b=Qf9wTGZkFJZgBTH35CODDbEWZa+/+RStde1Qxln3oqBZs9oHgq7hLOYLx031AUchk1
         ZQ5bGKzbZoCea2AVocq2FgsGVZs/o3X7lSBdzDWJI0rl7O7q5HEGswZ530rQZCWdKGwA
         8g6mDBrJ6TYpflnYUItPD0XnQG//RE0FFbUuVFcpvx0AvQsfVA6Hr3HlETSNJJ7kcKFN
         JFoKGLdykFmm9lbVDDQDoK+vmgp6X10aQrG8pkuOKCdySkgBsGArZNMf0uICjPVjOq+5
         d1G/sdlXbn7ZaFvFauE8IeojwvKT04PYvcGSYkF4tk8nNsqfQKhdQtnn1LqG0lTizpAL
         Rk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7iGSvWK0La1kyVTghgImSZBL01vL8BFl8y4phqz4dM=;
        b=mdwt2pRWjWBWvB0jlt3mz2uBQhlbNnjf0Xe134pPDKSqh7S2tRM6NB72FFW3nr2xaZ
         4eVPbAG26jwXvSbxILg4r2EFKZzXTCbwQPFaN50utK9F1NOZqZVuz4EqXD9wuhngYUNJ
         S6yM+xy2/8bAPtxLShkpExRtV2ZcZQUJjAjQ8RxkZ7wBzagBsbRrf3KtKVep8TCUwEF+
         mu3utMTY0Fagk/0aVyX2uXp/LFRytGJO3bsMuaA7Ye/1llmaEdBWskM09cn77c4xw5yL
         TkM17g9QEryt07BqeUYWU9VzGbiZJFwdVpfr03l+RPoOuOqRHVgN41Cf2RWZsCBEuIsk
         61Pw==
X-Gm-Message-State: AJcUukdqxJF/LYExslYRLeKs9/HE6jsyAIjMDhy4HwnXxX1Moqamf3ym
        zKtNpcxJ25uT/hezZ1NprzE+4HN1Z6k=
X-Google-Smtp-Source: ALg8bN5gQP9C9SjuXTlZnExWA+0qAYSIrjOklfCmJKqiGoY6ITt4KU3xS+DFcRT4mZv+8V/QFpIOzw==
X-Received: by 2002:a62:8e19:: with SMTP id k25mr5511190pfe.185.1548318561098;
        Thu, 24 Jan 2019 00:29:21 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h134sm45293804pfe.27.2019.01.24.00.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:29:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:29:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/11] nd/the-index-final small update
Date:   Thu, 24 Jan 2019 15:29:01 +0700
Message-Id: <20190124082912.24401-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was noticed by Ramsay [1] and I almost forgot.

[1] http://public-inbox.org/git/419519f9-1b48-93bb-eead-eacf6b383f70@ramsayjones.plus.com

Range-diff:
1:  4478671442 ! 1:  971d2839ab cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
    @@ -2,12 +2,11 @@
     
         cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
     
    -    >From now on, by default index compat macros are off because they could
    +    From now on, by default index compat macros are off because they could
         hide the_index dependency. Only those in builtin can use it (and even
         so should be avoided if possible).
     
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/attr.c b/attr.c
      --- a/attr.c
    @@ -590,6 +589,15 @@
      diff --git a/repository.c b/repository.c
      --- a/repository.c
      +++ b/repository.c
    +@@
    ++/*
    ++ * not really _using_ the compat macros, just make sure the_index
    ++ * declaration matches the definition in this file.
    ++ */
    ++#define USE_THE_INDEX_COMPATIBILITY_MACROS
    + #include "cache.h"
    + #include "repository.h"
    + #include "object-store.h"
     @@
      /* The main repository */
      static struct repository the_repo;
-- 
2.20.1.560.g70ca8b83ee

