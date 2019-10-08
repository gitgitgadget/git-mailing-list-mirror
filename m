Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D70C1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 18:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfJHS14 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 14:27:56 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40496 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHS1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 14:27:55 -0400
Received: by mail-wr1-f54.google.com with SMTP id h4so11828959wrv.7
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=c+TFcd7S9yIiP/D6toZeQWJUMK9yLLwFLoi7HUFMbeA=;
        b=QGVJRZoIzXaOx3jZqkBzOCCIwrFPt6DKfbyb+Og/QNNeJkiuN9U+a1+SEg4Z7jtdlw
         Opq5cIXYXJN0BXFVQg1wmCpVA4i5Dfpogmj4cjxI7o8V4TTBCRybbGYRsdJHHGqgSnoR
         978rZCGFXVkaF6gQbXBxlg0CG6uwdl6h4xwqAEkGSXBqtZgvKmo/5+CxQ5Sfh4p3pYBY
         30j8m4pJh+mXFBBL0BxgZsFfZC0ymgk/Vz+4FdG07htjy53tiZk49mjfvZawteFuy8Zy
         gdxoP/ke4qm8JHmmK/DwTSRKhGeAaCJ3w/Hky2ccSh9qQJDax+iHcshDi3vvHZ24Kvr6
         cyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+TFcd7S9yIiP/D6toZeQWJUMK9yLLwFLoi7HUFMbeA=;
        b=OgefYb25dx+N9AesXEmLxO6WigM0S7M6284XDRRMrCJTHegAhKOTQQDG+btQSF46Zx
         GHYuTUeX0ks+T4aZh/gJgz8izBruQ/2EgbMIuNOhy+wjHEoVnT608Y3uJakMKxgQZoNZ
         0nMzRtEQLx+EDvreUv0PCAIkSKXE1NrPoBUk5PO+NA5oc+jJPZ4TSWiR6G1B7m8OL/xy
         y7zzpKXiar5bTaAzRHp7NxdR0WJzCGDenHN0CHHktE0ApkchKtulhDMR5FAO7yfaAoDV
         OXYy9JA9ExhdLisVS/RbkPG8s04W9iV44QwBMb+wwKkwz4VUesjJQlPaxaRJL7WBIR6L
         Yu9w==
X-Gm-Message-State: APjAAAXC65sxEmCAI+U3SFYKJug5UfAWvDRcujOuyXfokM+AWjnXwJYn
        VDfGn8RQDnc/tRMm1JxxrRYnF/q7
X-Google-Smtp-Source: APXvYqwR5lM3h8MqHPQCp79IJ+omptZBm3bog6U5Gdj6hz0smX1SJfu/1+cRCh+0zQyzUg8LBm+Aag==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr1072028wrp.25.1570559272096;
        Tue, 08 Oct 2019 11:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b62sm6476054wmc.13.2019.10.08.11.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 11:27:51 -0700 (PDT)
Date:   Tue, 08 Oct 2019 11:27:51 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 18:27:49 GMT
Message-Id: <pull.380.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] xdiffi: fix typos and touch up comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of these changes are best viewed with --color-words.

Johannes Schindelin (1):
  xdiffi: fix typos and touch up comments

 xdiff/xdiffi.c | 99 ++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 44 deletions(-)


base-commit: b744c3af07a15aaeb1b82fab689995fd5528f120
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-380%2Fdscho%2Fxdiffi-typos-and-comment-style-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-380/dscho/xdiffi-typos-and-comment-style-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/380
-- 
gitgitgadget
