Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC8C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F290D613E9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 14:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhE1O5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 10:57:06 -0400
Received: from vps.thesusis.net ([34.202.238.73]:43930 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhE1O5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 10:57:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id BDA8923E25;
        Fri, 28 May 2021 10:55:30 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8BoC7pFlEham; Fri, 28 May 2021 10:55:30 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 6BE3223DE4; Fri, 28 May 2021 10:55:30 -0400 (EDT)
References: <20210520221359.75615-5-lenaic@lhuard.fr> <715d8115-641b-5c06-d514-36911eb169ef@gmail.com> <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com> <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet> <60aaa09aebce4_454920811@natae.notmuch> <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net> <87wnrooa17.fsf@evledraar.gmail.com> <xmqqim38jfja.fsf@gitster.g> <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet> <87mtshn3vj.fsf@evledraar.gmail.com> <YK+rmNWh+jPais9P@coredump.intra.peff.net>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOp?= =?utf-8?B?bmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: CoC, inclusivity etc. (was "Re: [...] systemd timers on Linux")
Date:   Fri, 28 May 2021 10:44:25 -0400
In-reply-to: <YK+rmNWh+jPais9P@coredump.intra.peff.net>
Message-ID: <87h7imaowt.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff King writes:

>   - temper small corrections with positive feedback. Especially for new
>     contributors, being told explicitly "yes, what you're trying to do
>     here overall is welcome, and it all looks good except for this..."
>     is much more encouraging than "this part is wrong". In the latter,
>     they're left to guess if anybody even values the rest of the work at
>     all.

When I see only a minor nit like that I assume that by default, that
means there are no more serious issues, fix the typo, and resubmit.  If
a new contributor thinks that means they aren't welcome then I think
they have an expectation mismatch.

>   - likewise, I think it helps to give feedback on expectations for the
>     process. Saying explicitly "this looks good; I think with this style
>     change, it would be ready to get picked up" helps them understand
>     that the fix will get them across the finish line (as opposed to
>     just getting another round of fix requests).

That would be nice, but such comments can really only come from a
maintainer that plans on pushing the patch.  Most comments come from
bystanders and so nessesarily only consist of pointing out flaws, and
don't really need to be bloated with a bunch of fluff.  I prefer short,
and to the point communication.

> I would even extend some of those into the code itself. Obviously we
> don't want to lower the bar and take incorrect code, or even typos in
> error messages. But I think we could stand to relax sometimes on issues
> of style or "I would do it like this" (and at the very least, the
> "temper small corrections" advice may apply).

Isn't saying "I would do it like this" already a tempering statement?  I
take that as meaning there isn't anything neccesarily wrong with what
you did, but you might consider this advice.

