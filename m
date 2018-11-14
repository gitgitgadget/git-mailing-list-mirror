Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618FE1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeKNKhL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:37:11 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:41441 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeKNKhL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:37:11 -0500
Received: by mail-ua1-f45.google.com with SMTP id z24so5071352ual.8
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ew5iRVzD3LDgHQzxbwh2wVEdHBqaDrLpuPbSKueZ6o=;
        b=RKkko3YOyXJlQ/vVHv7MHmnS6FeJSdzJcipiUXLif6HwxL0PhWp84OKU9RXuaXhdJx
         itqQISK7wjRKyclFiq6JQ4PGjMxVFajlCvs++iTRz4mnVte+hlwbzwAxUNFrUkDZpDUS
         /4NVMOE8jf8OtH6h1KGqB6ONoci/fCT11krYwharbyaBo6wx5o6haHxyXHISgRgH9kjs
         X9sfgSd5kne/iRICL9esMA5mTjqLz0Q1cdDkktIjxxKp/1M/vJEbseY4qJhYqPUAZ9Bi
         srCPir6832qka/sGOeHBg+LiCihcMoYdV1C6wIgX2tLFxIZJza+TQ+hB5+27/jz9ou0w
         oXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ew5iRVzD3LDgHQzxbwh2wVEdHBqaDrLpuPbSKueZ6o=;
        b=ONGhpw0f2W/OZnb9EykTj16lL18qi16E/3ax/dBgQjtKL0hm5OiOdhZrlbedv6k8KD
         QBu0u2R58Yjh5b7i4KR119GY3vr2Oo+iMZLxlUrVgap915ituL/SkvZuruf3pQ42B3UG
         y8HTZOR4JWUDIxeSKtshO5qYukT1SlG9EWbGa5w1QD0eMtnB0iP1FlaGAuDEEV95oolq
         4TCuCP3uUfZdqYpOsdbF2cN7fMH0LogpOTixRE2mcqIXevc9SsO11z+S+BGEuRk9dqUc
         h/reGwD+48yFlGvQ1WAnVGQi1tKp7K7JzRcwof2b0sqKVKCQkh9BwM0GHwrFFwP+jkBp
         p0EA==
X-Gm-Message-State: AGRZ1gKdE34KyPmIitUZI61zfakIHPIWTHnTka8GNJ0zuvZC3ZtxR5yk
        gR70DmIykKQv8QCC8ykGvxwV5U5/5WWHdMKE1sQ=
X-Google-Smtp-Source: AJdET5fOwN4B0BivmeTDMRZ/qXgk8oA3tljfNc8AAK3/8hoT2CVyd1lU6F04NfFoRxeFV/OdNWGCu26lIlPhhcN6FAU=
X-Received: by 2002:ab0:702d:: with SMTP id u13mr3552623ual.19.1542155783411;
 Tue, 13 Nov 2018 16:36:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.76.git.gitgitgadget@gmail.com> <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
 <00d9b0e4-dde5-c96d-76d7-42fb9ac393f8@talktalk.net> <nycvar.QRO.7.76.6.1811132019440.39@tvgsbejvaqbjf.bet>
 <1b8461d1-6cb7-6622-94d2-44c27623236d@talktalk.net> <87y39w1wc2.fsf@evledraar.gmail.com>
In-Reply-To: <87y39w1wc2.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Nov 2018 16:36:11 -0800
Message-ID: <CABPp-BGOq2jAp79qU-XYkCv18WLBdw7huKsmBYTJcS2e_jzvFw@mail.gmail.com>
Subject: Re: rebase-in-C stability for 2.20
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 1:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> According to Junio's calendar we're now 2 days from 2.20-rc0. We have
> the js/rebase-autostash-detach-fix bug I reported sitting in "pu" still,
> and then this.
>
> I see we still have rebase.useBuiltin in the code as an escape hatch,
> but it's undocumented.
>
> Given that we're still finding regressions bugs in the rebase-in-C
> version should we be considering reverting 5541bd5b8f ("rebase: default
> to using the builtin rebase", 2018-08-08)?

That date feels slightly misleading; it has a commit date of Oct 11,
and only merged to master less than two weeks ago.  Given how big the
two different rebase in C series were, I'd expect a couple small
things to fall out after it hit master, which is what appears to be
happening.

> I love the feature, but fear that the current list of known regressions
> serve as a canary for a larger list which we'd discover if we held off
> for another major release (and would re-enable rebase.useBuiltin=3Dtrue i=
n
> master right after 2.20 is out the door).
>
> But maybe I'm being overly paranoid. What do those more familiar with
> this think?

I probably don't qualify as more familar, but giving my $0.02
anyway...  I'm happy that setting rebase.useBuiltin=3Dfalse by default
exists an escape hatch if things don't settle down as we get closer to
the release, but I'd rather wait until further into the RC cycle
before going that route, personally.
