Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610D41F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJXQq3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:46:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:52568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727441AbeJXQq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:46:29 -0400
Received: (qmail 10367 invoked by uid 109); 24 Oct 2018 08:19:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 08:19:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2858 invoked by uid 111); 24 Oct 2018 08:18:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 04:18:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 04:19:22 -0400
Date:   Wed, 24 Oct 2018 04:19:22 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     trickygitninja@gmail.com, git <git@vger.kernel.org>
Subject: Re: How to start contributing
Message-ID: <20181024081922.GA31885@sigill.intra.peff.net>
References: <CAJKt3eP+BZkfK_yn3KYWMgmJB8_18UFr5eizmdGOY_4vM5=AYA@mail.gmail.com>
 <CAP8UFD3CDwu7OVgVmEgP2Se_bxYszcze68_bXT7=wgZaxncpzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3CDwu7OVgVmEgP2Se_bxYszcze68_bXT7=wgZaxncpzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 08:47:35AM +0200, Christian Couder wrote:

> > Make “git tag –contains <id>” less chatty if <id> is invalid
> > “git tag – contains <id>” prints the whole help text if <id> is
> > invalid. It should only show the error message instead.
> > Thread: https://public-inbox.org/git/20160118215433.GB24136@sigill.intra.peff.net/
> >
> > This bug is solved using the 3rd option, but I suspect that it’s still
> > here because the 2nd option is preferred.
> 
> I think it should probably have been removed from the micro-project
> list. I am CC'ing Peff as he wrote the email listing the different
> options to solve the original issue and may think otherwise.

Sorry for the reply.

Yeah, I I think the solution in 3bb0923f06 (parse-options: do not show
usage upon invalid option value, 2018-03-22) is fine. Even though it may
not have been what _I_ would have done personally, I don't think it is
worth anybody spending more brain cycles on it.

-Peff
