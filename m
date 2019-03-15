Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A104720248
	for <e@80x24.org>; Fri, 15 Mar 2019 18:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfCOSlF (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 14:41:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:52864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726431AbfCOSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 14:41:05 -0400
Received: (qmail 1408 invoked by uid 109); 15 Mar 2019 18:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 18:41:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2454 invoked by uid 111); 15 Mar 2019 18:41:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Mar 2019 14:41:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2019 14:41:03 -0400
Date:   Fri, 15 Mar 2019 14:41:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: GitGitGadget on github.com/git/git?, was Re: [RFC/PATCH] point
 pull requesters to Git Git Gadget
Message-ID: <20190315184103.GB4941@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet>
 <20190315033020.GE28943@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903151443420.41@tvgsbejvaqbjf.bet>
 <87va0k9k6f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va0k9k6f.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 05:28:08PM +0100, Ævar Arnfjörð Bjarmason wrote:

> FWIW I'd love to see it on git/git for discoverability. From the rest of
> your E-Mail it sounds like you're working on that. So just a +1.
> 
> If that doesn't work for whatever reason maybe we can amend git.git with
> this to point people to it:
> https://help.github.com/en/articles/creating-a-pull-request-template-for-your-repository
> 
> We have one in .github/PULL_REQUEST_TEMPLATE.md, maybe along with *.txt
> docs we should amend that, unless of course real GGG on git/git is
> imminent...

I think maybe you missed the patch that started this thread, which
proposes exactly that. :)

It should point people in the right direction, but of course getting GGG
directly on git/git means that they don't have to re-make their PR on a
different repo (though I guess they'd see the template while they're
making the PR, and IIRC it's no more difficult at that point than
clicking the destination repo box at the top of the page?).

> I've also noticed that for 1/1 patches it sends a 0/1, I don't do that,
> and personally wouldn't want to (just add any comments below "---").

There was some discussion of that elsewhere recently:

  https://public-inbox.org/git/20190311202441.GB18263@sigill.intra.peff.net/

> But I'm really happy it's there & useful to people, just not tempted to
> use it myself because I have a workflow I use already, and from
> observing it in action I couldn't losslessly move 100% of my submissions
> to it.

That's where I'm at, too. I doubt I'd ever use it, because I really like
my workflow. But if it is working for other people, especially people
who might otherwise be turned off of contributing, that seems like a
good thing (as long as the quality of submissions is in the same
ballpark; I think it is, and improving the tooling should keep that
moving in the right direction).

-Peff
