Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 179DE1F4C1
	for <e@80x24.org>; Fri, 18 Oct 2019 05:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437495AbfJRFhS (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:37:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:51824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388322AbfJRFhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:37:18 -0400
Received: (qmail 9766 invoked by uid 109); 18 Oct 2019 05:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 05:37:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14761 invoked by uid 111); 18 Oct 2019 05:40:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:40:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 01:37:17 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] doc: provide guidance on user.name format
Message-ID: <20191018053716.GA18384@sigill.intra.peff.net>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
 <20191017005330.9021-2-sandals@crustytoothpaste.net>
 <20191017054051.GA10253@sigill.intra.peff.net>
 <20191017222038.t2qlqderp44q2m7v@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017222038.t2qlqderp44q2m7v@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 10:20:38PM +0000, brian m. carlson wrote:

> > >  Documentation/git-commit-tree.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > 
> > ...I was surprised to see it here, where I think most users wouldn't
> > find it. Would it make sense in git-commit(1), or in the description of
> > the user.name config?
> 
> So the user.name config description points to git-commit-tree(1), which
> describes these in detail, which is why I put it there.  I agree that
> it's not a super discoverable place, since I don't know anyone that
> actually uses git commit-tree these days.  git-commit(1) doesn't
> describe these options at all.

Hmm, yeah. It's a little funny to point users at git-commit-tree, I
think. Some of that documentation may go better in git-commit. But
resolving that may be more than you want to bite off right now.

> There are, of course, options.  I can add this text into the `user.name`
> option in git-config(5) nevertheless, which will likely be more
> discoverable, but it will split the documentation on those into two
> separate locations.  Or we can leave it in git-commit-tree(1) anyway to
> keep it together.

I like the idea of mentioning something about it in user.name, even if
it's more brief ("Note that this doesn't impact the username used for
network authentication; see credential.username" or something).

-Peff
