Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B953A20248
	for <e@80x24.org>; Mon,  4 Mar 2019 08:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfCDInB (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 03:43:01 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38558 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfCDInA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 03:43:00 -0500
Received: by mail-ot1-f47.google.com with SMTP id m1so3564939otf.5
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 00:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOD/BSX81NXkAqzp5vzbyMoM19mxWY2gLdsboQq1T/k=;
        b=gw0NBx1YL3YVilB6Inyaa8SOaGOXf4pBslbdsRo48jFcuSRaDrMkZsSAvEvxPdT7su
         mPb5+qWDRZe2X75/Ak/N9La4zC5OAji14YI9JEgXv9wZBQDTmt448ZE1DC1noYqSh3Li
         zZA35+SlIIsw3XnjU1BuiC5wKj9MhF2cZLsysCcYkHVrmdVUm6fh1hxzn+BUfTrwwjw3
         A+Oz+5XMHNwmMsypZfz+NcTWeaACe7PyvctNzj9frsx2jj8/LP4ghXjAPcj1RIMlgMuu
         ex745OjrW07HwOR/BD6p5+NKGjKW1g7qJtewgppPRMZitIPpIsWZuDkcQG/Tvnbn/zFr
         xOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOD/BSX81NXkAqzp5vzbyMoM19mxWY2gLdsboQq1T/k=;
        b=KrQe6IbgQfwQZWZ3GjTXqkdtgAIdzKitZrZRO83SmXwpSlxGk/pFUSbUuzEHLdul1/
         nY5cgAeLfvJbJT40LyMtQhXNentpCkke1P2bM2TLBBhEW31ivQOGRuEL1uAvtjaNSK/z
         SBzpOcXvSC778PXQbt1IrRbbzNa2baV1rnXPy5HPI6Dr9aqJ9AfsyRh2ElfyRjQZsRhf
         i+osweBSGPS3slxm+0dzrdXJiJhGUOb8wluZ24Iuvaeta1RdEYepCUzagshcN6pQ7Y3D
         BTdI8lpCe5v56lf0J4kEtdG9j2OYfNBsF1NIqREUX3H/m26zgJABCp1fxNvKof5OZT5m
         NWOg==
X-Gm-Message-State: APjAAAW55Ycmn6zKZO4lYU1RtuyuYS/bWhk/m6d7GnIbdlyZ0gjNqB+O
        mz8EnxhLbhPh2GH6rY2joh4=
X-Google-Smtp-Source: APXvYqz6Rv4JfAfBAdQEgS7hO7U9tp4NNEsrAIpjBzzF1hnepdmByyLlqFFrJq/l1OLQS15m43fGmA==
X-Received: by 2002:a9d:3bb6:: with SMTP id k51mr11012332otc.8.1551688979785;
        Mon, 04 Mar 2019 00:42:59 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.23])
        by smtp.gmail.com with ESMTPSA id t12sm2223577otk.16.2019.03.04.00.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:42:58 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jordi Mas <jmas@softcatala.org>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [GIT PULL] l10n updates for 2.21.0 round 2.1
Date:   Mon,  4 Mar 2019 16:42:50 +0800
Message-Id: <20190304084250.3370-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.19.g6993b9cd58
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the following l10n updates for Git 2.21.0 to the maint branch.
These updates include l10n of Vietnamese and fixes of l10n of French and
Catalan.

The following changes since commit 8104ec994ea3849a968b4667d072fedd1e688642:

  Git 2.21 (2019-02-24 07:55:19 -0800)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.21.0-rnd2.1

for you to fetch changes up to 3ece05c5f408861e319043fa3f92125a9799db48:

  l10n: Fixes to Catalan translation (2019-03-02 19:12:58 +0100)

----------------------------------------------------------------
L10n for Git 2.21.0 round 2.1

----------------------------------------------------------------
Jean-Noël Avila (1):
      l10n: fr.po remove obsolete entries

Jordi Mas (1):
      l10n: Fixes to Catalan translation

Trần Ngọc Quân (1):
      l10n: Updated Vietnamese translation for v2.21 rd2

 po/ca.po |    6 +-
 po/fr.po | 1500 --------------
 po/vi.po | 6954 +++++++++++++++++++++++++++++++++++---------------------------
 3 files changed, 3979 insertions(+), 4481 deletions(-)

--
Jiang Xin
