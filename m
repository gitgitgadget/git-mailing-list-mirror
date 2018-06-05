Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387F51F403
	for <e@80x24.org>; Tue,  5 Jun 2018 15:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeFEPnl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:43:41 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:46193 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeFEPnl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:43:41 -0400
Received: by mail-lf0-f49.google.com with SMTP id j13-v6so4306159lfb.13
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyptaaM2TGAkTl9fuE9/tBS8c/J9meLoKVtIGMHby30=;
        b=rRhs1JcMyzKnxJ9mND9p9bqGQhMR9uPiO/2qVsfxGlEVgeNtspjL2QbTuPCcQ3170e
         STODjtDBHJm/9BO5wn8uj3uBZGGz6V4iGAP/3uh0E8DFVNCnrq6fwHxQhHP4xNxNvRJo
         V60nrvlx6GMioabSV072I2UJ8wNrykz50Q2mUsD+JezzCeZNtkJwUJG4QxsGDsxjIj+T
         gLVGsvnAOoSXtnG/jzE3eNpjqfNKSHieJYeIisgibnaek30gCeNb5NrMTjqJzEj6yciK
         dZWmsBIwoABs8+v7WQXX0L+6pWynPze/XirJld8bbH5hliS1gHpRM2ffqvcgfAuoRYRp
         cgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyptaaM2TGAkTl9fuE9/tBS8c/J9meLoKVtIGMHby30=;
        b=NZr4+iFgaJNV1Ui0Mpzaa4ghQ11XtFvCORUYzjq/heINkRlfouUz3Apl/4gZCY5vPu
         yqrdWEciNPQUyEHrbTGJtWD3cV9g4cKw/nQ+Zn6Q5EpezTtQCds9WK4jWupB9zGGT3z0
         HMS/TsbwDtjrXeRI3BiTgv4eRuhvZlUOn9wL6lBES+zi5ppFr7NTyE0HPfSf3q7iaGNc
         dlX0GTJGmHlb0DHvwBDhGqgC6MXoXJuPLNqwNllk7s6xMLsTU4AwDBfsl6IJGTsi7d1R
         I56NOIQDXKH9+mDSrbhB5fQF+yV9pSQ67Ci+yIMb3aH8ZwbZY6NPyWRb3E6ifQLTMoDV
         xsUA==
X-Gm-Message-State: APt69E3zDOOCY5JOgVoVkqW2zQ9Va93l8RvxN92Iw6xlx9fyy9Pqgb+b
        vw0iO71uZ1sNnSGmmfRwapC6Wg==
X-Google-Smtp-Source: ADUXVKKfbcphCLhXKqjQ2sE4WA90KV1oQbKeQHm0IE29iqP/tVvBM1XkgMC2nCKNyC1KK6v9AwLyrw==
X-Received: by 2002:a2e:7c02:: with SMTP id x2-v6mr3772994ljc.71.1528213419419;
        Tue, 05 Jun 2018 08:43:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o9-v6sm5161054lfk.2.2018.06.05.08.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 08:43:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/6] Fix "the_index" usage in unpack-trees.c
Date:   Tue,  5 Jun 2018 17:43:28 +0200
Message-Id: <20180605154334.22613-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180601161153.15192-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a potential problem that is exposed after Brandon kicked
the_index out of dir.c (big thanks!) and could be seen as a
continuation of bw/dir-c-stops-relying-on-the-index. Also thanks to
Elijah for helping analyze this code.

The last patch may be debatable. If we go this route, we may end up
with plenty of "#define NO_THIS" and "#define NO_THAT" until we
finally achieve "#define THIS_IS_TRUE_LIB_CODE" many years later.

Nguyễn Thái Ngọc Duy (6):
  unpack-trees: remove 'extern' on function declaration
  unpack-trees: add a note about path invalidation
  unpack-trees: don't shadow global var the_index
  unpack-tress: convert clear_ce_flags* to avoid the_index
  unpack-trees: avoid the_index in verify_absent()
  Forbid "the_index" in dir.c and unpack-trees.c

 cache.h        |  2 ++
 dir.c          |  2 ++
 unpack-trees.c | 55 +++++++++++++++++++++++++++++++++-----------------
 unpack-trees.h |  4 ++--
 4 files changed, 42 insertions(+), 21 deletions(-)

-- 
2.18.0.rc0.333.g22e6ee6cdf

