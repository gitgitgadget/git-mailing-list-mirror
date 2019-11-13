Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5D31F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 21:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfKMVO2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 16:14:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41696 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMVO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 16:14:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id b18so2563629wrj.8
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 13:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Lu8XZ81CLaejrZEKF31bClbjXnoeWDDMg8/vHONuy3M=;
        b=qiXQFi2txNAxTVRBFJar55Cc4HFZPtnswDjQDryICbnHqmt57irMG2p4gdyMi42eVk
         VH+bGaEsYJOfcYyjTeYG4UuMj67pvbdZ6taOKg9w8vQ5fjUMxzQTYGBbl52KS2pFy6bS
         qlxmBkLrR0UwagpX7XCOAxcNrRp5NIIjALJj8pWJmNWrkE+acKGm0dlJGdSemDKzLbaH
         8Uheww/WRHhAUWcM+fHYZnRXx0yHIbHYWIiV92pbO2fe5Ae+hC+MfxDR/vKGmOWotdNy
         dtGthAYvTI8GHhs0LiGkGr6g+fYC7ltmkajZeR+wzB6bgMm8LwNTiBtO1VPrmWSGa3KT
         rlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lu8XZ81CLaejrZEKF31bClbjXnoeWDDMg8/vHONuy3M=;
        b=SGUCUA2XFIndChb1Z1gal+4mo9Fmm97bPEosbfdYzZk+SAE00PsEaBsySTRdkNekXM
         +23LTXn64uVnQS8Y9mPqs0HXfbF10zym28ph0wiHh9AMJfhCbByYX52gjEvu217Ja+Q6
         ksyHYXHHgHTLzBtUudVkj7zXlQom4A0JBvShjhalmYSsdpd+jxsH3srN1Ipm1m6yljOD
         OMtlk5ewdWXc4zCXD5lJfTqGEmRk6DOtjBUemaT89/EEs6baRTBnFAJE2KaucHa/xZ6W
         qAtm563Kj3A9WVgyjqApvn5A1aqhE1Iy4bNMqaMaeTyybpXywYWD4EGw7RKDS/hvqHFf
         YEIA==
X-Gm-Message-State: APjAAAWbyTVdi9i8WfpZJyLprUy7zaY3ojAlfwGfF5RXVrOXdwk9Po6e
        d2+FemOR/mB9rvLhqMN6vikwL/qx
X-Google-Smtp-Source: APXvYqzHeCIRYdexlFe6iGTKAf/1p0EU8fWPWjB8JWbMKLABGWZHjNpo4fximQWSZrAVNzjNUy85Yw==
X-Received: by 2002:a5d:61c6:: with SMTP id q6mr3310601wrv.13.1573679666625;
        Wed, 13 Nov 2019 13:14:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm4159500wro.76.2019.11.13.13.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:14:26 -0800 (PST)
Message-Id: <pull.465.git.1573679665.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 21:14:23 +0000
Subject: [PATCH 0/2] Feature: New Variable git-p4.binary
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issue: Using git-p4.py on Windows does not resolve properly to the p4.exe
binary in all instances.

Two new code features are added to resolve the p4 executable location:

 1. A new variable, git-p4.binary, has been added that takes precedence over
    the default p4 executable name. If this git option is set and the
    path.exists() passes for this file it will be used as executable for the 
    system.popen calls.
    
    
 2. If the new variable git-p4.binary is not set, the program checks if the
    operating system is Windows. If it is, the executable is changed to
    'p4.exe'. All other operating systems
    (those that do not report 'Windows' in the platform.system() call)
    continue to use the current executable of 'p4'.

Ben Keene (2):
  Cast byte strings to unicode strings in python3
  Added general variable git-p4.binary and added a default for windows
    of 'P4.EXE'

 Documentation/git-p4.txt |  5 +++++
 git-p4.py                | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-465%2Fseraphire%2Fseraphire%2Fp4-binary-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-465/seraphire/seraphire/p4-binary-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/465
-- 
gitgitgadget
