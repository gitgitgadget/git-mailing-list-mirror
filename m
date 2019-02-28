Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CEB20248
	for <e@80x24.org>; Thu, 28 Feb 2019 10:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfB1Khl (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 05:37:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34093 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1Khl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 05:37:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id u21so14881440lfu.1
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4QSHX2hnQWxnzUDXVMK6KP9GKbYK/iDmEdoSkkoskQ=;
        b=IHeBScYQabWpqd8Qty7rGw+enQRlacWuE6QdIXaXNpOEDLor6KsV+1IlCzukIOUEBD
         D9Fs4SITecfk8eBaA/3g9+vM7nOZibP7X8atF016KAdmXYy4FGRRHCYtScnqfXYjVzcM
         piLuKR7O3PORuducSgBPugu3PkNsXjd1w6CwvwjEq3fdwgg5EN84mSp12yzYnKszC2Bx
         OcRrYpjW4G7rlQOL26+/aRyrVP7ySCLg2zwX0dcV85hl2Dw459Y2YNI9CTC2maHvL8Wv
         fj7QgAZ6j4QQpo/9o1FMXSSMlOyMmLaVT3gQCRj837H2yPtsJK9lES/z/XjvUytST0sK
         gQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4QSHX2hnQWxnzUDXVMK6KP9GKbYK/iDmEdoSkkoskQ=;
        b=LcCazq5wam1kTRxu7WLi4yd+y9av14uQ66MaWBzeHAD03erK8vARBILEDz31ApqI5d
         dr+LHXyTTEkO46yp1QELsDoa3kbivdKbnFeWD1LnhyLU4+JMvzQWwmfo9i9BKipOLn8Y
         wKUC9pGIQEUohqRYkxhQRwLUOYI1kY34Ak0yw4JC6gloEkeHDuBYNLI59jwq5T0QgGT4
         6Win9US1C/LqPfpl4cY+Rn0rsKTt1vXGEP1KAqZ/GaUBN4grab1S37chb4VKfx1SEMto
         nUqf0iaAFqDEurHfLz9qELVF+B03stPS+MaGB2EE6f0MIL9Hbm1GZBBsK3fqgXrnDKMn
         P/cw==
X-Gm-Message-State: AHQUAuY7hR2qtmqrRic/mR6IaAaTLa7HUFCPz0EsFdi9awD4j2RDyJmu
        UtViJz/2aeOb+KeF60o2VP4cX4x7+e9xj2VG4TI=
X-Google-Smtp-Source: AHgI3IZ0Uv41rQDM0OlHFCwsas1exBBGeGZNlXWc4G6gBtJQxrAmLsW9KFJDqVajew7TFkEDs3bQjHUohY0MsdPmSA0=
X-Received: by 2002:a19:7512:: with SMTP id y18mr21615lfe.105.1551350258893;
 Thu, 28 Feb 2019 02:37:38 -0800 (PST)
MIME-Version: 1.0
References: <gitgitgadget/git/pull/152@github.com> <gitgitgadget/git/pull/152/review/208437870@github.com>
In-Reply-To: <gitgitgadget/git/pull/152/review/208437870@github.com>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Thu, 28 Feb 2019 16:06:38 +0530
Message-ID: <CAL7ArXp2VWmYmKZ2io8aV_gwMKYPsjeB+5aijbHTPxSfrYTYnA@mail.gmail.com>
Subject: Re: [gitgitgadget/git] [GSoC][PATCH] t3600: `use test_path_is_*`
 helper functions (#152)
To:     "gitgitgadget/git" 
        <reply+01d9b0f6af7d837348ddd5ec643fae63e61359ee3638c02692cf00000001188e257692a169ce18b2a661@reply.github.com>
Cc:     pclouds@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Duy

>
> On the Git mailing list, Duy Nguyen wrote (reply to this):
>
> I was a bit worried that the "test ! something" could be incorrectly
> converted because for example, "test ! -d foo" is not always the same
> as "test_path_is_missing". If "foo" is intended to be a file, then the
> conversion is wrong.
>
> But I don't think you made any wrong conversion here. All these
> negative "test" are preceded by "git rm" so the expectation is always
> "test ! -e".
>

Sorry for the late reply. Yes, I thought about it earlier and made
changes thinking this only. Also when I was going through the code
again, I replaced other conditionals `[ -f ]` with test_path_is_file
etc.

Ciao
Rohit
