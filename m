Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B4D1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 11:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeKIVL1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 16:11:27 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:41091 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeKIVL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 16:11:27 -0500
Received: by mail-pg1-f174.google.com with SMTP id 70so740384pgh.8
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MLd6/C/LEYnlqqFvrOfHXgQYu0A0EPxRBqCE49TNM4o=;
        b=gmDabxEbtzi/rFeDcXJtcJcbB2hKGElrheubnutJf77HX19CftSt4zVygy4jcPvzfp
         yBd/tPq2sObd47DhKri6GlB1U1KKgoY3b3d5eJeSwYVVR0LPvxJXRAZ9M85/FU5SOzZ9
         GM93GZCwC8kRohq+hnV+ilWo4QrKpTA6lfq6qx1rgC4Hx3jOvJkfCKt1fo4yxiea7TuB
         O0l++vZ7m+7HJkSZ253+VwF0uismx/nON/m8jKd9c3vyDFLSE2+hIjQmfV0bmlMTUs+n
         YpXE1HM4Pu6ozKNLOqtY6l4hRlE3Pq72WQNwwatju+cnqyD2N5aa6DIxr6QYEMt6lSuz
         XNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MLd6/C/LEYnlqqFvrOfHXgQYu0A0EPxRBqCE49TNM4o=;
        b=U/pUkyrzmnYeOsrYi2CoZ20Q4mkPPYlUD8PdKlQXldjU3Ec2K76SxoxzhrAPtXbw1A
         EUhhvvszjnoHT0IIKx4kbwCdalXZuYQLzgj5PeaXph64HkQsbgYETvXYesuyyoZ2qdu1
         IO7wHpa5XrcOraYXgv+qp/Fu3C8xrSHz1bflhmCXI1kEK503LEeiorSWiUkehhy8IEpH
         nxKLwohJ+yVKNgKzfFQ2lTKOSod0O1KKzt8Rrkx2o+Wd8422xsLBvoKgZFjY8+UVx/nq
         QNeugukjQ6jMk432RSdi2GNLyC/riCCyuJoGnvvR1x+HH/5YRS4PRexbfAQj8+bQeJ84
         BweQ==
X-Gm-Message-State: AGRZ1gIRp4oUcDQs3Ym+51vA3koHHVBLbA+NPFH2VAjODJqc18jbJT7J
        l63X8M7Ykj7lfCealPOLsLMIp8+VA9A=
X-Google-Smtp-Source: AJdET5cqJpkFLlvTEnTLlhAv8ht0m6gS5ymod+EtMr7JYoIW3lNupRY0DPiFPB50vA0x4xfY4mT6Zw==
X-Received: by 2002:a62:1dd5:: with SMTP id d204-v6mr8431952pfd.157.1541763073648;
        Fri, 09 Nov 2018 03:31:13 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id b14-v6sm6399576pgn.49.2018.11.09.03.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 03:31:13 -0800 (PST)
Date:   Fri, 09 Nov 2018 03:31:13 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 11:31:10 GMT
Message-Id: <pull.71.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.71.git.gitgitgadget@gmail.com>
References: <pull.71.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Update .mailmap
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

I noticed that there were a couple of duplicate entries in git shortlog -nse
v2.19.1.., and then continued a bit to remove the duplicate entries even for
v2.10.0..

Changes relative to v1:

 * Fixed the commit message (it talked about the opposite commit range than
   intended).
 * Added a formerly missing space between the email addresses of Masaya.

Johannes Schindelin (1):
  Update .mailmap

 .mailmap | 13 +++++++++++++
 1 file changed, 13 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-71%2Fdscho%2Fmailmap-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-71/dscho/mailmap-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/71

Range-diff vs v1:

 1:  b590a9bebf ! 1:  c121ebc474 Update .mailmap
     @@ -2,7 +2,7 @@
      
          Update .mailmap
      
     -    This patch makes the output of `git shortlog -nse v2.10.0`
     +    This patch makes the output of `git shortlog -nse v2.10.0..master`
          duplicate-free.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ -47,7 +47,7 @@
       Mark Rada <marada@uwaterloo.ca>
       Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
       Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gmail.com>
     -+Masaya Suzuki <masayasuzuki@google.com><draftcode@gmail.com>
     ++Masaya Suzuki <masayasuzuki@google.com> <draftcode@gmail.com>
       Matt Draisey <matt@draisey.ca> <mattdraisey@sympatico.ca>
       Matt Kraai <kraai@ftbfs.org> <matt.kraai@amo.abbott.com>
       Matt McCutchen <matt@mattmccutchen.net> <hashproduct@gmail.com>

-- 
gitgitgadget
