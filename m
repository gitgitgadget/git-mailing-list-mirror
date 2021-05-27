Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB9C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F3D613B4
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhE0OZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:25:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:38794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236350AbhE0OZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:25:59 -0400
Received: (qmail 4822 invoked by uid 109); 27 May 2021 14:24:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 May 2021 14:24:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3292 invoked by uid 111); 27 May 2021 14:24:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 May 2021 10:24:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 May 2021 10:24:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: CoC, inclusivity etc. (was "Re: [...] systemd timers on Linux")
Message-ID: <YK+rmNWh+jPais9P@coredump.intra.peff.net>
References: <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
 <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
 <87wnrooa17.fsf@evledraar.gmail.com>
 <xmqqim38jfja.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
 <87mtshn3vj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtshn3vj.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 12:29:01PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The reason I chimed in on this thread was that I thought concern over
> one such topic had started to negatively impact another. We've got a lot
> of people trying to contribute who aren't comfortable contributing in
> English, or whose proficiency doesn't extend to the latest linguistic
> trends.
> 
> I'm suggesting that it's more helpful to leave certain things be than to
> pounce on contributors about things that are ultimately not integral to
> their work, and which can be readily understood.

Yes, I want to express my support of this point, and not just for this
particular issue.

If you're a new contributor (or even an old one), it can be frustrating
to spend a lot of time working on and polishing up an improvement to the
software, to be met with feedback that mostly consists of "there's a
typo in your commit message". Whether that's true or not, or whether it
improves the commit message or not, it can feel like reviewers are
missing the point of the patch, which will discourage contributors.

As reviewers, I think we can do a few things to encourage people,
especially new contributors:

  - let little errors slide if they're not important. I think sometimes
    we get into a mentality that the commit message is baked into
    history, and thus needs to be revised and perfected. But commit
    messages are also just a conversation that's happening and being
    recorded. There will be hiccups, and polishing them forever has
    diminishing returns.

    (Of course this requires judgement; some commit messages really are
    just hard to follow, and I think you made that distinction with the
    phrase "make sure understand what's being said").

  - temper small corrections with positive feedback. Especially for new
    contributors, being told explicitly "yes, what you're trying to do
    here overall is welcome, and it all looks good except for this..."
    is much more encouraging than "this part is wrong". In the latter,
    they're left to guess if anybody even values the rest of the work at
    all.

  - likewise, I think it helps to give feedback on expectations for the
    process. Saying explicitly "this looks good; I think with this style
    change, it would be ready to get picked up" helps them understand
    that the fix will get them across the finish line (as opposed to
    just getting another round of fix requests).

I would even extend some of those into the code itself. Obviously we
don't want to lower the bar and take incorrect code, or even typos in
error messages. But I think we could stand to relax sometimes on issues
of style or "I would do it like this" (and at the very least, the
"temper small corrections" advice may apply).

I'm not really targeting anybody in particular in this thread (and
Lénaïc seems to have taken it all in stride in this case). It's more
just a reminder that it's easy to forget to do these kinds of things,
and keep this kind of perspective. I know I have not always done it
perfectly at times.

-Peff
