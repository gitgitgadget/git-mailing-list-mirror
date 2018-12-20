Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6841F405
	for <e@80x24.org>; Thu, 20 Dec 2018 02:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeLTCvO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 21:51:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:46462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726604AbeLTCvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 21:51:14 -0500
Received: (qmail 1149 invoked by uid 109); 20 Dec 2018 02:51:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 02:51:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27415 invoked by uid 111); 20 Dec 2018 02:50:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 21:50:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 21:51:12 -0500
Date:   Wed, 19 Dec 2018 21:51:12 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
Message-ID: <20181220025111.GA24002@sigill.intra.peff.net>
References: <20181217165957.GA60293@google.com>
 <877eg5fwd5.fsf@evledraar.gmail.com>
 <20181219182216.GA17309@sigill.intra.peff.net>
 <20181219183927.GA228469@google.com>
 <20181219224810.GA20888@sigill.intra.peff.net>
 <20181219232948.GD228469@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219232948.GD228469@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 03:29:48PM -0800, Jonathan Nieder wrote:

> > I'm also not sure it really matters all that much either way. If you buy
> > my argument that this is just about placing the general era of the
> > commit in the mind of the reader, then "just before v2.11" or "just
> > after v2.11" are about the same.
> 
> If it's that unreliable, I'd rather just have the hash, to be honest.

Well, that was sort of my point. :) I think the hash is the most
interesting part, and everything else is gravy for the reader to save
them time digging into the commit.

> > I think that's a good idea if something is in fact being fixed. But
> > there are many other reasons to refer to another commit in prose (or
> > even outside of a commit message entirely).
> 
> Sure, but in those cases do we need the ability to query on them?

I'm not sure what you mean. We were talking about how to reference
commits in prose. I think a "Fixes" trailer eliminates the need to do so
(or least makes it redundant) in _some_ cases, but the other cases are
still of interest.

> To me it seems similar to having a policy on how to reference people
> in commit messages (e.g. "always include their email address"), so
> that I can grep for a contributor to see how they were involved in a
> patch.  If it's not structured data, then at some point I stop
> worrying so much about machine parsability.

Sure. All I'm really saying is "always include the hash".

-Peff
