Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EBA020193
	for <e@80x24.org>; Tue, 25 Oct 2016 02:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756859AbcJYC11 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 22:27:27 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:39712 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbcJYC10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 22:27:26 -0400
Received: by mail-qk0-f179.google.com with SMTP id i34so12009883qkh.6
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 19:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vWMhoUl6dSZd6PzotVTZm8DNeND4iCOcJgRKVpTY84k=;
        b=mdu2xbrulqqwf0UAiLXyRWBxhAny6T+iPNTWaN209oJX+MGn2j1CmbQDeoAMSWl7kl
         F16xfGpCjmE8bGnIE7uHI9hJidXu20ecZTn9tqdW9vV05jeGUrIROyTFF/9Bk0HB+MCS
         XARqgWwfszMEqGW3jRUOgCHQajmx8CgdvnUVJSz2csFvanyUzNP+uPK+NtQo0BxME9Tb
         Y5v1icgyLe24Z+xZOHvCQ8id0y0dfJDLKczvyJHhUYZQutDrMJSL/Eu4dPAMHMEMc/MK
         /9NejLEddWz3ky/PmzA1PWkHu3c8PvuF/6WoVYZu58IO8HSn8MqkSlB0tTIbOlsRdCNY
         qGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vWMhoUl6dSZd6PzotVTZm8DNeND4iCOcJgRKVpTY84k=;
        b=I+bj2N4r/GYMtqG7eL5ci+9jTgvCJCLQbsnIYwitrivDgOjTUCk/SHsTBKRQMV2JXV
         DuPrQDad0qpDT8RbwUaVk5ghRLLChBrIGNaAvi0g72+eisbFQIVjRu7Z3JfK7EMQY28A
         Gw2/aeW6pE8tPALQWnwsP2GDNhUwhux/CnVlezEXqJIR0AzAP55Vp25wfcNBU6gPIXGW
         Qvv+vbC4Xo2beT0h0B7kqaWxW/Ii8nC7Z345JITC110gL7bvpiaF+MYWZMz7dpBm5rEW
         VjlL3RjkFULECCmxwLVjWb8UU+A2KORV+JAxarCdCwiJmedZelzXbDT/s6Q/6gXWaIuB
         0Utg==
X-Gm-Message-State: ABUngvc8Ie952tUsyDZdsKG87QZJwydSvD8QRTMDljYvnekXxhqyOg5CaJfRtuY4S5ci+68iYm9y9RYAaa4DfbvU
X-Received: by 10.55.56.11 with SMTP id f11mr16393741qka.255.1477362445340;
 Mon, 24 Oct 2016 19:27:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 24 Oct 2016 19:27:24 -0700 (PDT)
In-Reply-To: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Oct 2016 19:27:24 -0700
Message-ID: <CAGZ79kbtyuSXDiyi2eY6HKCAwEiKgk2KmNakSn=f+RiXCAC1bA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/submodule-ignore-trailing-slash (2016-10-18) 3 commits
>  . submodule--helper: normalize funny urls
>   (merged to 'next' on 2016-10-11 at e37425ed17)
>  + submodule: ignore trailing slash in relative url
>  + submodule: ignore trailing slash on superproject URL
>
>  A minor regression fix for "git submodule".
>
>  It seems that POSIX emulation layer of Windows is not cooperating;
>  this may have to wait (or tentatively reverted in Windows port) for
>  the resolution of the issue.
>
>  cf. <alpine.DEB.2.20.1610131255001.197091@virtualbox>
>  cf. <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
>
>  What's the current state of this topic?

The first 2 patches actually fix a bug users run into, and I these are
fine for general consumption IMHO.

The third patch only breaks tests as our test suite is holding it wrong.
I was bike shedding on the list and yak shaving here to come up with
the correct fix for the test suite.

One of the initial ways to work around the bugfix was to

    git clone . root # <- add in this step and it works again.
    git clone root super

but instead I will do the preparation for the 'super' project not
in '.' but in 'root', just called differently ("super_remote" ?)

An additional new test for cloning from '.' will be introduced, too.

I plan on working on that with highest priority for git after finishing
some attr stuff that I currently have open. So expect a patch (or two)
this week.

Thanks,
Stefan
