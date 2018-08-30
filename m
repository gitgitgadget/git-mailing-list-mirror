Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B141F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeHaAyg (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:54:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:34662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725893AbeHaAyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:54:36 -0400
Received: (qmail 10727 invoked by uid 109); 30 Aug 2018 20:50:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 20:50:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31677 invoked by uid 111); 30 Aug 2018 20:50:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 16:50:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 16:50:34 -0400
Date:   Thu, 30 Aug 2018 16:50:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
Message-ID: <20180830205033.GA27399@sigill.intra.peff.net>
References: <20180622092327.GA8361@sigill.intra.peff.net>
 <20180622092459.GD13573@sigill.intra.peff.net>
 <87wos8cjt8.fsf@evledraar.gmail.com>
 <xmqq4lfb667c.fsf@gitster-ct.c.googlers.com>
 <87in3rd422.fsf@evledraar.gmail.com>
 <20180830200452.GB22407@sigill.intra.peff.net>
 <xmqqo9dj4mym.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo9dj4mym.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 01:29:53PM -0700, Junio C Hamano wrote:

> >> > I do not know if the documentation that is shipped in 2.20 should
> >> > talk about how the old world looked like, though.  `-l` was a short
> >> > for `--create-reflog` is worth saying, but I do not see much value
> >> > in talking about the warning given in 2.19.
> >> 
> >> I'm anticipating that there will be users in the wild with similar -l
> >> invocations, noting this helps them, because they'll be wondering what
> >> some script that does "git branch -l <name>" is trying to do while
> >> reading our docs.
> >
> > I don't have a strong opinion either way. If we do mention it, it should
> > probably be short ("Until Git v2.20, the `-l` option was a synonym for
> > `--create-reflog").
> 
> I agree that the short one would of course be good.  I am on the
> fence about mentioning the warning only given in 2.19.

Yeah, I was confused about that part of the thread. Is there something
proposed to (additionally) go into v2.19? Ævar, can you elaborate?

-Peff
