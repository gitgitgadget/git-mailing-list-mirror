Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3F91F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJ0Pjw (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:39:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:56866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727844AbeJ0Pjw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:39:52 -0400
Received: (qmail 24554 invoked by uid 109); 27 Oct 2018 06:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 06:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4102 invoked by uid 111); 27 Oct 2018 06:59:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 02:59:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 02:59:52 -0400
Date:   Sat, 27 Oct 2018 02:59:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
Message-ID: <20181027065952.GA17203@sigill.intra.peff.net>
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
 <20181023210154.32507-1-avarab@gmail.com>
 <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
 <20181024074400.GA31239@sigill.intra.peff.net>
 <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com>
 <20181025010905.GA4458@sigill.intra.peff.net>
 <a5535030-65c1-613c-e4ea-d4379b243b87@ramsayjones.plus.com>
 <20181025212358.GA23257@sigill.intra.peff.net>
 <87pnvwldk7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnvwldk7.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 09:20:56PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> I was thinking:
> >>
> >>   $ git var -e GIT_WHATEVER_ENV
> >>
> >> [-e for environment].
> >>
> >> ... but that is really no different than git-config. ;-)
> >
> > Actually, "git var" already does pull bits from the environment. It
> > doesn't know about all of the type-specific parsing that git-config
> > does, but it might be a reasonable path forward to teach it that. (But I
> > still think we should do nothing for now and see how often this comes
> > up).
> 
> For myself / Junio picking this up: Does that mean you've read v2 and
> think it's OK to pick up in its current form? I think it is, just
> looking for some Acks on that since it's not in the latest "What's
> Cooking".

I'm not sure if you're asking whether I looked at the rest of the patch.
If so, then no, not really (so no objection, but I also did not review
it).

-Peff
