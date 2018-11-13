Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119BF1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbeKNBER (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:04:17 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:46304 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeKNBER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:04:17 -0500
Received: by mail-pf1-f169.google.com with SMTP id s9-v6so6174553pfm.13
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CV7X6VaxZFyzseHPgaMSmuDoXr8Ee7vzQO0HivVL1aY=;
        b=kbQR/OssbQusyaCPw4vkliTy1tVh42qjeYAVOUReulq+WcfHMtSVPt60ScadXamsPq
         Ch3earShfsnPFX46Zmlmb3kcwcvbO1ljkkarfLEIWIHn1S5Oged8v8q2A+jVr7GFG2mK
         k+wr86PIxaSCHuJfYDdcRBFASn5bybNe7yK+Y4Q9mFAcWfa4apHhuzkmfMWfa0siefTb
         e9Laq67vSrWEcrq8UTgRrwl4LEc6SH0nMphncxsEmOiWEynggCs3gLlvjvBbq5OuRzhr
         coxL7SJAqqdkTw8aTlTtNbUV8swWD+sHFJubSrG4Di61Jy3teTu/aLrXIKlyJm7cWA8M
         J6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CV7X6VaxZFyzseHPgaMSmuDoXr8Ee7vzQO0HivVL1aY=;
        b=Jgc7uSj+WRCpjRpVV3yqBY25akPMDREdoXmhJnqOIDp2pivIrfAjI2bGrloKe/p8nn
         ZXSOEKA50e/gx4yvUaPYbYRZbjn9A6DLceoSXggpIUy+6qQBYV3hBbYsBdQwU6DmzWYc
         MNm68GkH5F0HFAuBt8rVB0kcwqXRquQZV6Hv5qaPPJPT+oOek6ph8yk3W+8VhOmkS7OA
         XgWddUxTVotC4FhdBSVOIqKbjkFLQQP3/euFXNRJL/8f5Yqn8iypt9o4+h7HzU14rcIp
         Lda3yfKYZw3MreXlR9d1UPo9vKpPLfg0/2cxOiT5P47QZ4JJYBYO/sKtBjpx6PWHxivC
         0omA==
X-Gm-Message-State: AGRZ1gKXCOmG7UTR0wYppt/iMQPWTa9+p3Lzow7jIk0mDPrZC6TYUbYR
        P9+uDFwybuSjQ0AoPNTs1Tf76K6E
X-Google-Smtp-Source: AJdET5fhOWeEhoIUy0j9ciaEBQXA8V9VY4NbOV8pTaQqUsLgN/FGQ6aLBorFrM2frQVJ7ZRZp4X5/w==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr5067228pgc.62.1542121543840;
        Tue, 13 Nov 2018 07:05:43 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 79sm19689251pge.66.2018.11.13.07.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:05:43 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:05:43 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 15:05:40 GMT
Message-Id: <pull.78.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Some left-over add-on for bw/config-h
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

Back when bw/config-h was developed (and backported to Git for Windows), I
came up with this patch. It seems to not be strictly necessary, but I like
the safety of falling back to the Git directory when no common directory is
configured (for whatever reason).

Johannes Schindelin (1):
  do_git_config_sequence(): fall back to git_dir if commondir is NULL

 config.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-78%2Fdscho%2Fbw%2Fconfig-h-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-78/dscho/bw/config-h-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/78
-- 
gitgitgadget
