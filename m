Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99AE1FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbdEICVW (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:21:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:47769 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753846AbdEICVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:21:21 -0400
Received: (qmail 9414 invoked by uid 109); 9 May 2017 02:21:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 02:21:16 +0000
Received: (qmail 18511 invoked by uid 111); 9 May 2017 02:21:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 22:21:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 22:21:14 -0400
Date:   Mon, 8 May 2017 22:21:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection
 options
Message-ID: <20170509022114.s3tpxrgtplsopr4x@sigill.intra.peff.net>
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
 <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
 <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
 <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
 <20170509020010.meefcustv7uufard@sigill.intra.peff.net>
 <xmqqfuge6akl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuge6akl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 11:14:18AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Ah, OK, and now I understand why you called this a "bug" (which is
> >> older and do not need to be addressed as part of 2.13) in the
> >> original message.  The new tests check requests that ought to
> >> produce an empty packfile as the result actually do, but with the
> >> current code, the reuse code does not work with --local and friends
> >> and ends up including what was requested to be excluded.
> >
> > Right. Did you want me to try re-wording the commit message, or does it
> > make sense now?
> 
> It does make sense to me now, but I do not speak for all future
> readers of "git log", so...

I guess what I was asking was: do you still think it was unclear, or do
you think you were just being dense?

I don't feel like I gave any information in the follow-on explanation
that wasn't in the commit message, so I wasn't clear if I worded it
better or if it just sunk in better.

-Peff
