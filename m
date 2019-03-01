Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6078820248
	for <e@80x24.org>; Fri,  1 Mar 2019 02:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfCACvt (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 21:51:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37016 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfCACvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 21:51:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so20957896wrs.4
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 18:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=TLiT7mZbq9Ifa3G6xZMbIYKsP496bmRnN4k4ap2nylI=;
        b=Ig/b/fl1iRlJjDpxki4z4FgPWOv8O6AwMzJzjzT1kG8Vz3JUhvNEqzHIgyYoVEAz9A
         xRIMpzhTR1UY74TI9MpR9R1PhoaVfX0SVKNvDiH5/cR8SXsztUtr0T9WMfime97UwS/x
         gPgZ6ZJbdNNEH1yd/alpDk/8/q1SnOfqPGr0cA01ZVvbnxRMBPzibikxoNrdHuVz4EFM
         iCiFvKFjhluLCWQKQDGo3PZbixhW9RidncRcdGli7xMSxUnDxqvpEINjLvWigIM63UUy
         GfDjYiMJkdKkSlSrxK03wXN03Xe/LxHIeyXI7efniz1H+LyaeX5XMqCinKcWHiLz0Lhu
         fsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=TLiT7mZbq9Ifa3G6xZMbIYKsP496bmRnN4k4ap2nylI=;
        b=f7sbku2HVWDyZ6fH+Hs13X9gh4W4bEXKZSnaNtGLX827JVEkgXXXqpsem0Wv3/pb7C
         evt9POFUGOtSAisGoTfE7CWynu+wutK4YyDxt5F/WljWyPcQW9dHWWKBzd6pUPDcH/cB
         hjCqYQO2kjT/3InaXPCN8z2/sHHpPbqa+Bl3isIuQLKHX6LZtiFzpSAiXYSt+2aH3RKe
         hIAQaXl0xTIPnWDfd7C9/s2eQgVHuNh5OiJB5mGlBdXtr51RccOp+DtfkguPYhaz8Lrm
         MmaZNDjsCaOo+Uo21vrUgJdDDZHjRFHzSv5QWu8QrBnyOABMyGAHwozGx2aWmAeclV8n
         RKTQ==
X-Gm-Message-State: APjAAAWKF8RKDG5N5TyVqC+sz4I5Af9Jd27g0PWcFJpdnaRron68S7jf
        Mm8WyDKNHLLwVL7GAPtiPdU=
X-Google-Smtp-Source: APXvYqzweutgQ8U9aYL8mtlZBwUC7f/Xwdq8BIAYa0BbeHxDlSeXh4zDlCZeVCevA5vOYE21P8mCGQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr1702314wrx.203.1551408707093;
        Thu, 28 Feb 2019 18:51:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y20sm18180688wra.51.2019.02.28.18.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 18:51:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.com,
        szeder.dev@gmail.com, git@matthieu-moy.fr,
        Johannes.Schindelin@gmx.de
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [GSoC] acknowledging mistakes
References: <f881f01e4f05c1c9ad7e35fea5fd7db2947427a1.1551349607.git.gitgitgadget@gmail.com>
        <20190228190242.20680-1-rohit.ashiwal265@gmail.com>
Date:   Fri, 01 Mar 2019 11:51:46 +0900
Message-ID: <xmqqef7r9uil.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> 1. Commit message was less than 50 chars which should be around 72 chars
>    according to coding guide lines. Should I change this to match 72?

Simple things do not need that many letters to tell ;-)  The
suggestion of 72 is about the maximum.  

If you are doing something in a single patch that needs a longer
title, it generally is a sign that you are trying to do too much in
a single patch and should be splitting the patch into more
digestable smaller steps.  And the purpose of having a maximum is to
nudge patch authors to realize that.

> 2. My changes had some uneven use of tabs and spaces, which I made
>    considering that pre-existing code had them too. Is there a
>    possibility to change the whole code according to CodingGuidelines?
>    If yes should I only change my code according to guidelines or the
>    whole file?

I think you are talking about t3600, which uses an ancient style.
If this were a real project, then the preferred order would be

 - A preliminary patch (or a series of patches) that modernizes
   existing tests in t3600.  Just style updates and adding or
   removing nothing else.

 - Update test that use "test -f" and friends to use the helpers in
   t3600.

> 3. There is no helper function for `test -s` but Rafael suggested we can
>    make use of other helper functions to provide similar functionality,
>    if we can.

If we often see if a path is an non-empty file in our tests (not
limited to t3600), then it may make sense to add a new helper
test_path_is_non_empty_file in t/test-lib-functions.sh next to where
test_path_is_file and friends are defined.

Thanks.

[jch: I am still mostly offline til the next week, but I had a
chance to sit in front of my mailbox long enough, so...]
