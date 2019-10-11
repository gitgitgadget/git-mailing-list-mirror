Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1E81F4C1
	for <e@80x24.org>; Fri, 11 Oct 2019 05:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfJKF63 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 01:58:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:45348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726174AbfJKF63 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 01:58:29 -0400
Received: (qmail 13097 invoked by uid 109); 11 Oct 2019 05:58:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 05:58:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30284 invoked by uid 111); 11 Oct 2019 06:01:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 02:01:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 01:58:28 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
Message-ID: <20191011055827.GA20094@sigill.intra.peff.net>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
 <20191010001853.h2pepvg7yilevipv@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191010001853.h2pepvg7yilevipv@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 12:18:53AM +0000, Eric Wong wrote:

> > The project leadership team can be contacted by email as a whole at
> > git@sfconservancy.org, or individually:
> > 
> >   - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >   - Christian Couder <christian.couder@gmail.com>
> >   - Jeff King <peff@peff.net>
> >   - Junio C Hamano <gitster@pobox.com>
> 
> All folks that have proven to exhibit good judgement in the past,
> and hope they continue to exhibit that in the future.

I snipped your concerns with some of the language. I do agree with you
that a lot of is open to interpretation. But I also think it's
impossible to get it 100% airtight. My feeling was that it was a good
idea to go with some existing, well-established text, even if it has
some wiggle room. And then rely on the existing community and especially
the people listed above to do that interpretation.

So...

> Just pointing out some concerns of mine.  No ack from me
> (but it's not a NACK, either).  I'm pretty ambivalent...

For me it is obviously an ack, but I wanted to make clear that I think
your concerns (and those of others who spoke up, like René and Gábor)
are certainly _valid_. I just think that adopting this CoC is, while not
perfect, the least-bad option.

I'd also say that we might consider living with it for a while (6
months? a year?) and seeing if people have an interest in revising it
after that point based on experience.

This is the same text used by the kernel, btw.  I think somebody
mentioned to me (but I think it may have been off-list) that the kernel
has an "interpretation" document:

  https://www.kernel.org/doc/html/latest/process/code-of-conduct-interpretation.html

which clarifies a few terms with respect to that specific community. I
didn't feel that we particularly needed to do that for our community,
but if somebody wants to work up a clarifying document, I'd be happy to
review it.

-Peff
