Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEA01F461
	for <e@80x24.org>; Wed, 15 May 2019 10:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfEOKyF (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 06:54:05 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34399 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfEOKyF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 06:54:05 -0400
Received: by mail-ed1-f41.google.com with SMTP id p27so3541031eda.1
        for <git@vger.kernel.org>; Wed, 15 May 2019 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=F+d/XrnFLYaEprFq1VRPCKFYJlcrGcDHwDWyBTEjE5o=;
        b=nKf3v2Ogn5VhrHaKgEKrC23Efwxz8kGgrCJizNFIZEK3ImI5xqdo/jkquKeiF8d9qQ
         ffwcRpaQ+LlieywSn7jn2DCF6G+oYRYMq1KNjq/Ir77T3R+e4EH6JhsZ0EXSZvY7k1fs
         KaeCBB7pfLUDf3e9wFKkTIlT2wPGqfOS2MjYrBZB+N02NlDIbYETtBJRafWEfyLqhngC
         YNzTCaCFjZIB8Tn7bXRX7VfpgKCiF9ihwea79g/w3sRp5un7fd6MoxkSCh4ZJMDefpjT
         +l2QZu6RVLx5g6t8KPuO3i/Kxy008x0QSwIqilJfZaOHnq34AW9gSuDallwN+wFeTe6F
         XNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F+d/XrnFLYaEprFq1VRPCKFYJlcrGcDHwDWyBTEjE5o=;
        b=GPCr8xqnuDVa9GAC8aKVr5e/DrF/10T0qHs2NU62a64SFHA42XB9qw9ej/eNWJiZaV
         vANXed4rTxLgtodREO+xgtJRZcVLVvoS0Q1G/NrXyHJ/4WVDK6e9y88zrkFMvP6iIdQE
         N3molNMdrYx02G3t9GqzatAtnbykzsDyXFmdWkPPjVzr33LKDO6hMCh+FSJU57735cGR
         ZwelGbryqJ/9IOm3KUGKOW/QKXncpl8UYNtx8AnhOs7N48CTCAoZ2JpvT+X5e11ZANGT
         yjHEXKwIaVOQOFAg8LLZMExRLEwbsL0tGqksIW78482qMXqWdTmNL76pDYtkxxvIeSQ6
         vC0A==
X-Gm-Message-State: APjAAAWfcL5ihD1lpGF019spgssORThb2plCGvXIzodXl+CLIGybX950
        OSswQd4kttJTMDd/HckhKtZ1urrs
X-Google-Smtp-Source: APXvYqzV4xPvzXfZOVURjOuHhSi51xL6mvWGdEJ1eyJnCkT6Ttpu7xwOvD0U1eFj/wnzRWsTz6dTvA==
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr33323497eja.58.1557917643552;
        Wed, 15 May 2019 03:54:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c49sm678607eda.58.2019.05.15.03.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:54:02 -0700 (PDT)
Date:   Wed, 15 May 2019 03:54:02 -0700 (PDT)
X-Google-Original-Date: Wed, 15 May 2019 10:54:01 GMT
Message-Id: <pull.196.git.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] status: remove the empty line after hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, there is inconsistency between the status messages with
hints and the ones without hints: there is an empty line between the title
and the file list if hints are presented, but there isn't one if there are
no hints.

This patch remove the inconsistency by removing the empty lines even if
hints are presented.

John Lin (1):
  status: remove the empty line after hints

 t/t7060-wtstatus.sh    |  5 ----
 t/t7508-status.sh      | 62 ------------------------------------------
 t/t7512-status-help.sh | 14 ----------
 wt-status.c            |  4 ---
 4 files changed, 85 deletions(-)


base-commit: ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-196%2Fjohnlinp%2Ffix-status-empty-line-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-196/johnlinp/fix-status-empty-line-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/196
-- 
gitgitgadget
