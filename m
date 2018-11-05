Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57511F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbeKFEmQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:16 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:32929 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFEmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:16 -0500
Received: by mail-lj1-f180.google.com with SMTP id v1-v6so2910617ljd.0
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yI4L92EXBNhfN2qTw+PLhRGHagoiJy8ek6FRjJqsD2o=;
        b=Rn7yokKM5bh5wNF/QUYGrY5EUwOg3bFvEYo11oqMJnrNtzCjG6m5Pd6YrttnD5lTdd
         51Pm/q9OrEnwhG6dzNfGqF1tX9MNNvVlkAYQFBgkY1PNgsvBndhxt51W1ztzmMZdvGXO
         wtrqt/3zwfsJPiLEZVb1Ew4L0OVQ7KHdpqWIezy8I6lpxRFHZFgvhm1B+E+jj6QJAnWJ
         WZwgg3PC9oGDyiSZH5B3L/DDvF1kRHA8NxO/pmJvUCBC4NnvVHLMGeLAMYzi5tOQGMSm
         aGnvdKO3R7KYgptj2J8zFgM9HM/ELz03hCIC6ybmxlfhreuzaR/Wj+BaSJ0w49gR7Soj
         BNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yI4L92EXBNhfN2qTw+PLhRGHagoiJy8ek6FRjJqsD2o=;
        b=Gcl2nc1uReLgV50zDeWf6Wj2V8pdI+PMRKpEoIcyxOdx1YxQ1RtilJeuv1Zv5WT3kr
         hRvY6ky5jwpU+ZKC0Dmf0c17yh054qdfHBR4JZZ5xKXCwT7ZtESAAb2oYt0u4NXW62kj
         iSikmPuuwhiXvCvghr483mE3k2qSoVQhJAwupBPIlAesicVucdVlHHMJecNU6+2tR9WN
         YOFL2HV+lyKdEUUn6OdMPs5APBsQ8/gVozSP1Uh4owQBfrpjwmYOnoYqiBqfljoIYFat
         Yw7lvHSO7CTzqM+FOxInT7C/PuFWE19eIHmGxdqEZ7q+kpTQmHQ71Jst2jLl8ZaGfoJ9
         FaYw==
X-Gm-Message-State: AGRZ1gLIluWn/Lc++6PmmNOc2Rw2zYH8Z5r9a5c/lgRPiIZgku3CtdRq
        ht0csxcQHjcfuXoBmYHKuQ8=
X-Google-Smtp-Source: AJdET5ev7KsBP36sGihal1thlkejd83eIA8cYhXodAIUsOX9idU2TTPrgra0KE/1ZDpLjsKuQ4EPaA==
X-Received: by 2002:a2e:9bc3:: with SMTP id w3-v6mr2546243ljj.70.1541445665919;
        Mon, 05 Nov 2018 11:21:05 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:05 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 00/16] Mark more strings for translation
Date:   Mon,  5 Nov 2018 20:20:43 +0100
Message-Id: <20181105192059.20303-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 splits non-trivial changes out to keep i18n patches simpler. A few
more word legos in fsck are removed. v2 also fixes a bug in fsck that
makes it print object id incorrectly.

Nguyễn Thái Ngọc Duy (16):
  git.c: mark more strings for translation
  alias.c: mark split_cmdline_strerror() strings for translation
  archive.c: mark more strings for translation
  attr.c: mark more string for translation
  read-cache.c: turn die("internal error") to BUG()
  read-cache.c: mark more strings for translation
  read-cache.c: add missing colon separators
  reflog: mark strings for translation
  remote.c: turn some error() or die() to BUG()
  remote.c: mark messages for translation
  repack: mark more strings for translation
  parse-options: replace opterror() with optname()
  parse-options.c: turn some die() to BUG()
  parse-options.c: mark more strings for translation
  fsck: reduce word legos to help i18n
  fsck: mark strings for translation

 alias.c                    |   4 +-
 archive.c                  |   8 +-
 attr.c                     |   4 +-
 builtin/fsck.c             | 156 +++++++++++++++++++++----------------
 builtin/merge.c            |   4 +-
 builtin/reflog.c           |  34 ++++----
 builtin/repack.c           |  26 +++----
 builtin/revert.c           |   3 +-
 git.c                      |  32 ++++----
 parse-options-cb.c         |   7 +-
 parse-options.c            |  64 ++++++++-------
 parse-options.h            |   5 +-
 read-cache.c               |  73 ++++++++---------
 ref-filter.c               |   8 +-
 remote.c                   |  49 ++++++------
 t/t0040-parse-options.sh   |   4 +-
 t/t1410-reflog.sh          |   6 +-
 t/t1450-fsck.sh            |  52 ++++++-------
 t/t4211-line-log.sh        |   2 +-
 t/t6050-replace.sh         |   4 +-
 t/t7415-submodule-names.sh |   6 +-
 21 files changed, 292 insertions(+), 259 deletions(-)

-- 
2.19.1.1005.gac84295441

