Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4383420404
	for <e@80x24.org>; Tue, 10 Oct 2017 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755866AbdJJOhq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 10:37:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751364AbdJJOhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 10:37:45 -0400
Received: (qmail 14672 invoked by uid 109); 10 Oct 2017 14:37:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 14:37:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27162 invoked by uid 111); 10 Oct 2017 14:37:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 10:37:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 10:37:43 -0400
Date:   Tue, 10 Oct 2017 10:37:43 -0400
From:   Jeff King <peff@peff.net>
To:     Anthony Chevalet <anthony.chevalet@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git download issue
Message-ID: <20171010143743.trbrhiywlzcgiagy@sigill.intra.peff.net>
References: <CAMnBc7=ar=v_FSdMq44r0Lo_S35tH=UQFWvfGFF4VXoTjbg4Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMnBc7=ar=v_FSdMq44r0Lo_S35tH=UQFWvfGFF4VXoTjbg4Cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 03:45:38PM +0200, Anthony Chevalet wrote:

> I can't download git for windows from https://git-scm.com/downloads
> 
> https://git-scm.com/download/win redirects to https://git-scm.com/downloads
> 
> Any hint?

Thanks for reporting. This should be fixed now, and is related to some
database maintenance I was doing related to manpage versions[1].

-Peff

[1] https://github.com/git/git-scm.com/issues/1041#issuecomment-335437722
    if you're curious.
