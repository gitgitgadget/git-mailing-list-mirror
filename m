Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2EC31F597
	for <e@80x24.org>; Mon, 16 Jul 2018 10:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeGPLCh (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 07:02:37 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:39632 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPLCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 07:02:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id j8-v6so1438145pff.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=K+R6PsDDXQK3BOyQ4tc44DPGs49Py7na0+DG8GQGMtg=;
        b=ER8RDzzRruPMi/YL8jvnfvmRffSNlHWZugYxHj6J1l0tbG1G1BTZraAmL0Ze+WAJof
         xJE2ZpFFSDCQ893w7tE1hY2fNu6teGRaC/gt6UxLp8mKH8NYTW3MO9IfnSkBvVo5rXAN
         nDfSTI3EYmhTdTdb+t1vykzSZwXN1Xf63JHXzFMAVBL/eE0u2H4PcnQiLYfVv0iBfHKK
         reA4BfdJs5ppsJQbePtxS6igQr81E0BkklUQes/QNdLP44VTtbQKwokeDYNIM5O1iHZN
         XLLBBgkSirVH/lJZ6V5/lLceWpnWh0cozVaw3JQQSdW4cOB7HrWw2hjpW9HH8zk8fth1
         qgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K+R6PsDDXQK3BOyQ4tc44DPGs49Py7na0+DG8GQGMtg=;
        b=aPYO8V7f+nSXllaYxJWnrSkr5/ThzNZiESbTv2OtpuLv9Se5pc3nPEYxwWopbpKRXg
         57avvN234V5q553WviUim8jT6zZM7ovpNwy106QmhN+lw/j/3bcEm+Ehyi65O5tg9biE
         PqJkctiX/TMEcpbsXwRFrAvpXRwuZou5IFWCJfJEX2TZPLQ7WODg+1U2ZXcM+qeHXp+O
         w/217ypejyjAD2kNCMOFcwuKGVIUtv/iXo8YPiNvHe3qkPYj9BS6AX/u8XuypmfOeh0S
         d90Y/I0GEwskU1ucHb28JNxCYVEw0rsdrq0AupX2ymFS5lfwFood/k8ViLBb3slp5m+Q
         OYGw==
X-Gm-Message-State: AOUpUlEgfE8/cZsW7HbQoaCpBkztQq1DFBHaYAZHyJ18gE0+8tbrXKUi
        aqJaQx2VKEFotLf/BgjxtCgc+A==
X-Google-Smtp-Source: AAOMgpcnG10o1azzAsbTHt0CWCuxjCWuyQ3Zp8Lt07fTuGN1Yfe5lj/BXdPq62QwX8a4o5RbwYq6Bw==
X-Received: by 2002:a62:f587:: with SMTP id b7-v6mr17528406pfm.158.1531737349328;
        Mon, 16 Jul 2018 03:35:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id x25-v6sm17937358pgv.63.2018.07.16.03.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 03:35:48 -0700 (PDT)
Message-Id: <pull.4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Jul 2018 10:35:46 +0000
Subject: [PATCH 0/1] vcbuild/README: update to accommodate for missing common-cmds.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 60f487ac0ef (Remove common-cmds.h, 2018-05-10), we forgot to adjust
this README when removing the common-cmds.h file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Johannes Schindelin (1):
  vcbuild/README: update to accommodate for missing common-cmds.h

 compat/vcbuild/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-4%2Fdscho%2Fcommon-cmds-fallout-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-4/dscho/common-cmds-fallout-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/4
-- 
gitgitgadget
