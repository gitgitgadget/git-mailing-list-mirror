Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1DC1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBHKBW (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:01:22 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:42087 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKBV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:01:21 -0500
Received: by mail-ed1-f43.google.com with SMTP id r15so2250126eds.9
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=ghlpCBJt4E21WeYFfCLLy9iuOwMgSx+0f47Qla46Wy0=;
        b=i5UonihBC9hr/sIUpb0q9g3qMEBkrQA5MPi9BdBvmGyz+MIOKYC0D4j4bv62SPSKg2
         HFeYAEnuxksQAqE6w5/xs6OEXFfRRQKt/1C6UMR7wVor6ZA15osaaMFo51Tftk11k6DV
         b8C4v6ywauvwz78iWUzAR1pSqRKrSSyzu84O6FTke1vmQNAApHgHVAS4g/Xg7gN4fw/h
         2+EMthaT8gmZ2jZOXFx/2z2p/OS8xS0gXpuUaz0u/Is6GvUc9VWFIAZXlYQ88mrS1O2M
         /0ffJ9Vhv/1tzmPk7+N6ZMgoECTKCI4xAKqSEcEtgjMN9vNeEJLCWDLFHfQ09vlemEwP
         6fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=ghlpCBJt4E21WeYFfCLLy9iuOwMgSx+0f47Qla46Wy0=;
        b=eisXZWenVcKMoYQDRBce3v4kqAU+GoopQNttkki6QzJpGQKmbJo3J6b5syhYBK0Ih5
         Lpsxjf8sHgWx/0QbQwT8NcSF7WQiE3cq3hveis1YOtxqeIBae9MHvUfPOPQrQMDhOrap
         LUorCQ3W7Mr4ajdqh1pIrqdjEYYK3C+NzDahaqqL90xSWEBIFmjO0FmegSYZk6y67VSs
         +BSQeWPPR+HdaFRKRAnr8aeBB0dax/HeX966oLjMAi7xGo72yVRxgJH4cmnlxvD9D/vI
         lhgFE2ISsOb7RrFjbNbcAKgcdc0lusW+EVnBMbpQkvUZ4lKTYUr952Ur8gUrS0Qt1KUE
         J17A==
X-Gm-Message-State: AHQUAubPfzKeIyCcVcyQzgFozwOu1uCMPbrwOE4oje2jwtj5zqGGDk5s
        UzGkcz7ZFVXopGNC+UJjl2RmhYpA
X-Google-Smtp-Source: AHgI3IYcJx2jZfWElOgh008j0P2qUkLsS1LAfZgq8ET+7wMltboI5QHBjCUvmdmiACa4Sbl0VsxD+g==
X-Received: by 2002:a50:a3d4:: with SMTP id t20mr16416245edb.159.1549620079707;
        Fri, 08 Feb 2019 02:01:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c96sm497597edf.79.2019.02.08.02.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:01:19 -0800 (PST)
Date:   Fri, 08 Feb 2019 02:01:19 -0800 (PST)
X-Google-Original-Date: Fri, 08 Feb 2019 10:01:17 GMT
Message-Id: <pull.122.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Add .mailmap entries for Clemens "drizzd" Buchacher
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Clemens Buchacher <drizzd@gmx.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gábor pointed out
[https://public-inbox.org/git/CAM0VKjkM-THZALy20VrZ-JSMyZjUXUqp1CAoCPrezXRsBfRJ2A@mail.gmail.com/] 
that some of Clemens' email addresses bounce, and that the .mailmap file
should be updated accordingly. This makes it so.

Johannes Schindelin (1):
  .mailmap: map Clemens Buchacher's mail addresses

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)


base-commit: d62dad7a7dca3f6a65162bf0e52cdf6927958e78
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-122%2Fdscho%2Fmailmap-drizzd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-122/dscho/mailmap-drizzd-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/122
-- 
gitgitgadget
