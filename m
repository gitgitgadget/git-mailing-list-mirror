Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F8C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhLTNn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:43:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:55010 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhLTNn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:43:28 -0500
Received: (qmail 10212 invoked by uid 109); 20 Dec 2021 13:43:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Dec 2021 13:43:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2460 invoked by uid 111); 20 Dec 2021 13:43:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Dec 2021 08:43:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Dec 2021 08:43:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: taking a break from Git
Message-ID: <YcCIfrLIzCb9UFWW@coredump.intra.peff.net>
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
 <211220.867dbzwhln.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211220.867dbzwhln.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 01:45:05PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Do you have a preference either way for being kept or omitted from CC?
> I.e. if/when you'd come back to have that E-Mail backlog, or for us to
> stop CC-ing you? Clearly you'd still get some traffic, but at least us
> list regulars could take that into account.

I don't care much either way. I long ago had to start filtering the cc's
on list emails into a separate spot from my main inbox. So I can happily
ignore that separate folder. :) As far as combing through the backlog, I
expect I'd just have to declare bankruptcy anyway.

> You have various WIP code in topics at https://github.com/peff/git. Some
> of which has your SOB, some not. I keep it as a remote and sometimes run
> into prior art with "log --all <path>" and the like.
> 
> You noted a while ago (IIRC, haven't dug up where) that inline patches
> of yours to the list could be assumed to have your SOB, does the same
> apply to what's sitting in that repo?

Yes, there's nothing in there that I wouldn't sign-off. But just to make
things more clear, I went through and added one to all of the commits in
the repository.

You or anyone else is welcome to mine it for ideas or code. There are
dragons, of course, but a lot of it is working code that I just didn't
get around to polishing. Any branch not marked with "-wip" is something
that I merged into my daily-driver version of Git, and passed all tests.
So at least it shouldn't be _too_ broken. :)

Thanks for thinking about these logistical issues.

-Peff
