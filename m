Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E886DC47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B184E610A1
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhE3V75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:59:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:41578 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhE3V75 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:59:57 -0400
Received: (qmail 19040 invoked by uid 109); 30 May 2021 21:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 May 2021 21:58:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22267 invoked by uid 111); 30 May 2021 21:58:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 May 2021 17:58:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 30 May 2021 17:58:15 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Susi <phill@thesusis.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
Message-ID: <YLQKd5wzN5iESxvQ@coredump.intra.peff.net>
References: <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
 <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
 <87wnrooa17.fsf@evledraar.gmail.com>
 <xmqqim38jfja.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
 <87mtshn3vj.fsf@evledraar.gmail.com>
 <YK+rmNWh+jPais9P@coredump.intra.peff.net>
 <87h7imaowt.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7imaowt.fsf@vps.thesusis.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 10:44:25AM -0400, Phillip Susi wrote:

> >   - temper small corrections with positive feedback. Especially for new
> >     contributors, being told explicitly "yes, what you're trying to do
> >     here overall is welcome, and it all looks good except for this..."
> >     is much more encouraging than "this part is wrong". In the latter,
> >     they're left to guess if anybody even values the rest of the work at
> >     all.
> 
> When I see only a minor nit like that I assume that by default, that
> means there are no more serious issues, fix the typo, and resubmit.  If
> a new contributor thinks that means they aren't welcome then I think
> they have an expectation mismatch.

Sure, that may be your intent as a reviewer. My point was that the
recipient of the review does not always know that. Helping them
understand those expectations is part of welcoming them into the
community.

And even as somebody who has been part of the community for a long time
and understands that, it is still comforting to get actual positive
feedback, rather than an assumed "if I did not complain, it is OK".

> >   - likewise, I think it helps to give feedback on expectations for the
> >     process. Saying explicitly "this looks good; I think with this style
> >     change, it would be ready to get picked up" helps them understand
> >     that the fix will get them across the finish line (as opposed to
> >     just getting another round of fix requests).
> 
> That would be nice, but such comments can really only come from a
> maintainer that plans on pushing the patch.  Most comments come from
> bystanders and so nessesarily only consist of pointing out flaws, and
> don't really need to be bloated with a bunch of fluff.  I prefer short,
> and to the point communication.

Yes, I hesitated a little bit on this advice for that reason: it may be
even worse to mislead people about the state of a patch series, if you
the reviewer and the maintainer do not agree. IMHO it is still good for
reviewers to try to help manage newcomers through the process, but it
does make sense for them to be careful not to over-promise.

> > I would even extend some of those into the code itself. Obviously we
> > don't want to lower the bar and take incorrect code, or even typos in
> > error messages. But I think we could stand to relax sometimes on issues
> > of style or "I would do it like this" (and at the very least, the
> > "temper small corrections" advice may apply).
> 
> Isn't saying "I would do it like this" already a tempering statement?  I
> take that as meaning there isn't anything neccesarily wrong with what
> you did, but you might consider this advice.

Here I more meant cases where the two approaches have about the same
value. If your "I would do it like this" can be backed up with reasons
why it might be better (more efficient, more maintainable, and so on),
then that's probably helpful review to give. If it can't, then I'd
question whether it is worth the time to even bring up.

There's a big gray area, of course. Saying "it would be more readable
like this..." is sometimes a nuisance, and sometimes great advice. One
extra complication is that new contributors are often unsure how strong
the request is (e.g., if they disagree, do they _need_ to change it for
the patch to be accepted, or is it OK). I'll often qualify comments with
an explicit "I'm OK with doing it this way, but in case you really like this
other direction, I thought I'd mention it...".

Another complication with all of this advice is that sometimes new
contributors are in a mentoring relationship with one or more reviewers
(e.g., GSoC, Outreachy, or just people who have asked for help). And
there the cost/benefit tradeoff is different between frustrating a new
contributor and teaching them our style, norms, etc.

-Peff
