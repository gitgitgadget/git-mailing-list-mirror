Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DA41F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbfJPTfv (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:35:51 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38008 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbfJPTfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:35:51 -0400
Received: by mail-wm1-f46.google.com with SMTP id 3so55205wmi.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FCrTsUxCBtmmbGPn+gkIsJ//3poycXRqcoT4fYOpYus=;
        b=q2EypU9zeDz6TOxwK9UtUc9SPavi/L24H9s4WUyX1k/9oUDK8AOYp60ZwkDN5/fCEE
         2Yg7+ox41zs383CL/TNG1wbCUbKO0EiebE6pkICoZc3Ymi5agnL0+HbwOHom+9z7BNii
         WmAMTCimPpPXuMiOexC279/22QB4p3ddz0zKsUCiCXT8ja2e0yWi+eGo8jLMFySVKPfu
         6XX/B5wl6vP41aWtuCeheWxefyPohCajDcNM//l96cOdR+JnR/+npHZ/gekbE9unUad2
         yqRi4YuYSMSaQDlXA9hjikyfu9SjPAFmqvImcLb3T4tbBvVoj3BdNNlBLoEPrva5d5Wp
         CdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FCrTsUxCBtmmbGPn+gkIsJ//3poycXRqcoT4fYOpYus=;
        b=CHvD0Sd1fUfYffYs1GhiQF+BjJWVjBaCkkJNxQp1fiLW1AFgvPHLboqozJF6ad0zba
         Oa2ql8YhncINXLPhI/IfkMJSY/BCrL7NDZ/rJXW8EQZmc/ACE/sHZCh6/hj647u4Efbr
         YJGuAyF6mf2cLs3zvEVFfZT8U3nT5K6F3vyJxVKJ/QTiU30dJRbkCeosfiv5hsqrZ2Ww
         p+Imd+MpXFHYwplygOhJfgy7aEI9/O+hVN8Ma4H+VtrI/+ynT+f5ouSR914cge7qbJZP
         dhhLHGUPy9TrKrDyrhEtZ/T08Obp4139xRruFTZ8JBfjxfwXZgjr2pzc+EBDeoLkHFgs
         4g9A==
X-Gm-Message-State: APjAAAXIxf/UVQ11Hul3w9H8FVlN6df7d3Nf1DzbRV58qNl5UzfC56CX
        0QxbVYDNIgVaPfrSZ4n9B4oCaKly
X-Google-Smtp-Source: APXvYqx/6OVCyQKtRgjR8B+cJHSE10Gdca9chAS6w9YAuovX41BnRe9UZSWRkFa45sOJVIOJgXWovg==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr4535287wmk.99.1571254549034;
        Wed, 16 Oct 2019 12:35:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t203sm4195903wmf.42.2019.10.16.12.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 12:35:48 -0700 (PDT)
Message-Id: <pull.404.git.1571254547.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 19:35:46 +0000
Subject: [PATCH 0/1] t7519-status-fsmonitor: improve comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        Johannes.Schindelin@gmx.de, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is based on the 'wb/fsmonitor-bitmap-fix' branch and
addresses feedback on the new test that was added there. 

I've updated the comments for the new test to more accurately describe the
scenario being tested.

Thanks,

William

William Baker (1):
  t7519-status-fsmonitor: improve comments

 t/t7519-status-fsmonitor.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)


base-commit: 3444ec2eb2be58c285d2bf04f39e6e9ea5eda9a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-404%2Fwilbaker%2Ffsmonitor_test_cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-404/wilbaker/fsmonitor_test_cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/404
-- 
gitgitgadget
