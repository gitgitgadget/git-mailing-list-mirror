Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656401FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 05:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbcHaFCh (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:02:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:35715 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752780AbcHaFCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:02:35 -0400
Received: (qmail 4889 invoked by uid 109); 31 Aug 2016 05:02:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 05:02:34 +0000
Received: (qmail 2959 invoked by uid 111); 31 Aug 2016 05:02:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 01:02:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2016 01:02:30 -0400
Date:   Wed, 31 Aug 2016 01:02:30 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, gitster@pobox.com
Subject: Re: [PATCH v4 0/3] diff-highlight: add support for --graph option
Message-ID: <20160831050229.cabhfzqcpcpvkugl@sigill.intra.peff.net>
References: <xmqq4m638ded.fsf@gitster.mtv.corp.google.com>
 <20160830140714.19048-1-henderson.bj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160830140714.19048-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 07:07:11AM -0700, Brian Henderson wrote:

> On Mon, Aug 29, 2016 at 02:37:46PM -0700, Junio C Hamano wrote:
> > Brian Henderson <henderson.bj@gmail.com> writes:
> >
> > > How does this look?
> > >
> > > Drawing the graph helped me a lot in figuring out what I was
> > > actually testing. thanks!
> >
> > Yeah, I also am pleased to see the picture of what is being tested
> > in the test script.
> >
> > With your sign-off, they would have been almost perfect ;-).
> 
> doh. fixed.
> 
> I left the subject as v4, probably mostly because I have this weird aversion to
> increasing version numbers :) but I justified it by thinking that the actual
> patch set isn't changing, I just added the sign-off (and updated the commit
> messages per Jeff.) Hope that's ok.

Thanks. Here are a few patches to go on top. The first one could
arguably be squashed into your first patch (and I don't mind if Junio
wants to do so while applying, but I don't think it's worth you
re-sending).

The second one fleshes out the test scripts a bit, now that we have them
(yay!).

And the third fixes a bug that was reported to me off-list. I held back
because it touches the same lines as your topic (and as a bonus, I was
now able to write a test for it). It could be its own topic branch that
graduates separately, but seeing as it's contrib, I don't mind one big
diff-highlight potpourri topic if it makes things simpler.

  [1/3]: diff-highlight: ignore test cruft
  [2/3]: diff-highlight: add multi-byte tests
  [3/3]: diff-highlight: avoid highlighting combined diffs

-Peff
