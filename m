Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A33F1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 07:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfIZHJC (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 03:09:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:60584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727933AbfIZHJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 03:09:02 -0400
Received: (qmail 7651 invoked by uid 109); 26 Sep 2019 07:09:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Sep 2019 07:09:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25802 invoked by uid 111); 26 Sep 2019 07:11:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 03:11:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 03:09:01 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190926070900.GA20653@sigill.intra.peff.net>
References: <20190923212834.GA19504@sigill.intra.peff.net>
 <20190924170746.100302-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924170746.100302-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 10:07:46AM -0700, Jonathan Tan wrote:

> > >  - In your reply [2] to the above [1], you mentioned the possibility of
> > >    keeping a list of cutoff points. One way of doing this, as I state in
> > >    [3], is my original suggestion back in 2017 of one such
> > >    repository-wide list. If we do this, it would be better for
> > >    fetch-pack to handle this instead of index-pack, and it seems more
> > >    efficient to me to have index-pack be able to pass objects to
> > >    fetch-pack as they are inflated instead of fetch-pack rereading the
> > >    compressed forms on disk (but again, I haven't verified this).
> > 
> > And this is the flip-side problem: we need to get data back, but we have
> > only stdout, which is already in use (so we need some kind of protocol).
> > That leads to things like the horrible NUL-byte added by 83558686ce
> > (receive-pack: send keepalives during quiet periods, 2016-07-15).
> 
> Sounds good. With this, do you think that there is enough likelihood of
> acceptance that we can move ahead with my proposed project?
> 
> Besides discussing the likelihood of patches being accepted/rejected,
> should we record the result of discussion somewhere (or, if only the
> mentor should give their ideas, for me to write in more detail)? I don't
> recall a place in the Outreachy form to write this, so I just mentioned
> the benefits in outline, but maybe I can just include it somewhere
> anyway.

Yeah, I think it's OK to go ahead. I think an intern who is interested
in the project would get in touch with you either directly, or via the
list. So that gives some opportunity to discuss the ideas with them, and
to go into more detail on the proposal in an interactive way (it would
also be fine to point at this thread, too, of course).

-Peff
