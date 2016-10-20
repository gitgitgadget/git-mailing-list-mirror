Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9E61F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754459AbcJTVmR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:42:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:60304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753520AbcJTVmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:42:16 -0400
Received: (qmail 4405 invoked by uid 109); 20 Oct 2016 21:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 21:42:16 +0000
Received: (qmail 30413 invoked by uid 111); 20 Oct 2016 21:42:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 17:42:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 17:42:14 -0400
Date:   Thu, 20 Oct 2016 17:42:14 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
Message-ID: <20161020214213.juoxbspa7pba5vsi@sigill.intra.peff.net>
References: <580893d5a4736_4ed37b53181837@ss1435.mail>
 <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
 <xmqqshrqhpua.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYTwsWy+oxnPKghWKGLEaO9qWZbrQOOejeEBOe0c-o0Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYTwsWy+oxnPKghWKGLEaO9qWZbrQOOejeEBOe0c-o0Pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 10:58:39AM -0700, Stefan Beller wrote:

> > By the way, do you know who is managing the service on our end
> > (e.g. approving new people to be "defect viewer")?
> 
> I do it most of the time, but I did not start managing it.
> And I have been pretty lax/liberal about handing out rights to do stuff,
> because I did not want to tip on anyone's toes giving to few rights
> and thereby annoying them.

I also do this, though I admit with more urgency when I recognize the
name as somebody who has showed up on the git list.

I wish there was a flag to simply make the results public. There is no
point in anybody logging in just to view them, but I don't think
Coverity makes that an option.

-Peff
