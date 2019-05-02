Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5541F453
	for <e@80x24.org>; Thu,  2 May 2019 03:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfEBDJh (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 23:09:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:46640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726183AbfEBDJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 23:09:37 -0400
Received: (qmail 3212 invoked by uid 109); 2 May 2019 03:09:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 May 2019 03:09:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25539 invoked by uid 111); 2 May 2019 03:10:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 23:10:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 23:09:35 -0400
Date:   Wed, 1 May 2019 23:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
Message-ID: <20190502030935.GB25395@sigill.intra.peff.net>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
 <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net>
 <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com>
 <E6B28E44-5859-436B-A620-2FB484EEB657@gmail.com>
 <CAPc5daVL5Jn2M-pban1wPPNOnkjyvUAKynJQBtVBeSzGQoxZ+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPc5daVL5Jn2M-pban1wPPNOnkjyvUAKynJQBtVBeSzGQoxZ+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 27, 2019 at 02:06:55PM +0900, Junio C Hamano wrote:

> 2019年4月27日(土) 2:58 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>:
> >
> > May be you are searching for the following view which lists (similar to git log --one-line) the commits starting from  97dd512 which is the last in the tb/unexpected series?
> >
> > https://github.com/git/git/commits/97dd512af7ce4afb4f638ef73b4770921c8ca3aa
> 
> Yes, exactly. The problem I have is it is not obvious how to get there
> starting from
> https://github.com/git/git/

Not exactly in git.git, but I'd probably do something like:

  https://github.com/git/git/compare/master...gitster:tb/unexpected

You can get there by going to the "branches" tab in gitster/git, then
"tb/unexpected", and then "compare" (either from the branch selection
page, or if you've already clicked through from the tree view of that
branch).

From _just_ inside git.git it's trickier, since it doesn't have that
branch. I don't think there's an easy way to click through to a
compare-view there, since arbitrary commits that people are looking at
might or might not be useful tips for the compare-view (which is also
really the pull request view).

I'd probably just generate this URL myself:

  https://github.com/git/git/compare/master...c49927fca0de4c213ae9b21dcb7eafb80e453d27^2

since it's stable and pretty readable.

Probably more than you wanted to know, but I feel like I ought to be
able to drop at least a little GitHub wisdom. ;)

-Peff
