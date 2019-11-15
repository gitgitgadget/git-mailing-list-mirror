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
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C2C1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKOOnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:43:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39815 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKOOnB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:43:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so11248912wrp.6
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uRf08cgrA8p5upeUaZbVz+PizPDqFqlhzfv7g9D0C2s=;
        b=Tf816d5ZF3XyRmCY9T82OC4dSAGGl+fW98oKgB+fZ/4lA3eQdldtEXWZe69ip7obl3
         7oirTS+bmu/JE1FMGfcYSSwqXAcdL1i5ptxaA7d7dZhICm6/psrtA3WSHEc3V4vjBL4O
         yamSQ6LBNe+Wq0isCSdhRvmXS4nrfqLi99brPKaj2WADiNpCMBlCFIroWZP20dDvsQUO
         bkswCbqI39PZNljRLQZcnu7nq4QwraCDGR+jhn+BNcTP/jXqpJf8wTVKz2UR3TLc30IV
         mqBA/BYjdX3VHwCOSemvr5xIRUUzhn2GPZeXxhx4WGbierpsxucKJ4RAxA6ZgSIIVj/N
         X9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uRf08cgrA8p5upeUaZbVz+PizPDqFqlhzfv7g9D0C2s=;
        b=CYvHmX/kiI/AMJT3ptXIpoJRuV8zSJMk8x9GRosE0sTZXIjfqJSTSd3S6tHnyZDa6C
         JvCEQe1wVUsxk+pEPqObU/8rX3ElSck461SDdcdsT8eCJiOPj3HUng4mq3Pw/CSLTwP2
         V3RgdImHOM0zIEAwHNA8V3eN/jz7VHMfZ5X7sKc9hGePhKzhhRA4xkN52k70ysJbuEGQ
         v8JqE0Y0uuiEuaZZW6qJSjL80vXHhuM4pWqBFiLR7hb7DPvb1BvIYp49DfwtM8ywyY3v
         AmN2fBmOmydEgsUA+3VV/8iwub5NNC1qLQf60tV3ZMSIyd/skFDNq89qPERqvfZyY7ls
         hTIw==
X-Gm-Message-State: APjAAAUAzeDsQk4ILpSQY/IYnRaWyvabW01psHg32bvqBB1n3ufvQtyD
        9OeltYB+E4XS6hjgwvSexoUg3GnB
X-Google-Smtp-Source: APXvYqyOJPfgmbP3pzC8XspbrSTfLuT1zK+djmdavoCcBdnX6D0GxIkqrcZYNbnzgyD5ntHGjXeTsA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr8357966wrq.70.1573828979210;
        Fri, 15 Nov 2019 06:42:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm11668991wrn.21.2019.11.15.06.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:42:58 -0800 (PST)
Message-Id: <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
In-Reply-To: <pull.465.git.1573679665.gitgitgadget@gmail.com>
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:42:55 +0000
Subject: [PATCH v2 0/3] Feature: New Variable git-p4.p4program
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

Changes since v1: Commit: (dc6817e) 2019-11-14

Renamed the variable "git-p4.binary" to "git-p4.p4program" per the thread
discussion.

v1:

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

Ben Keene (3):
  Cast byte strings to unicode strings in python3
  Added general variable git-p4.binary and added a default for windows
    of 'P4.EXE'
  Changed the name of the parameter from git-p4.binary to
    git-p4.p4program

 Documentation/git-p4.txt |  5 +++++
 git-p4.py                | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-465%2Fseraphire%2Fseraphire%2Fp4-binary-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-465/seraphire/seraphire/p4-binary-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/465

Range-diff vs v1:

 1:  0bca930ff8 = 1:  0bca930ff8 Cast byte strings to unicode strings in python3
 2:  98bae92fda = 2:  98bae92fda Added general variable git-p4.binary and added a default for windows of 'P4.EXE'
 -:  ---------- > 3:  dc6817eea3 Changed the name of the parameter from git-p4.binary to git-p4.p4program

-- 
gitgitgadget
