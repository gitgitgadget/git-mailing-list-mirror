Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F701F661
	for <e@80x24.org>; Wed, 12 Jul 2017 20:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbdGLU5h (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:57:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:38448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752363AbdGLU5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:57:36 -0400
Received: (qmail 9994 invoked by uid 109); 12 Jul 2017 20:57:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 20:57:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27283 invoked by uid 111); 12 Jul 2017 20:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 16:57:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 16:57:34 -0400
Date:   Wed, 12 Jul 2017 16:57:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
Message-ID: <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
References: <20170711233827.23486-1-sbeller@google.com>
 <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 01:44:46PM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> >   I want to force myself to think about the design before pointing out
> >   memory leaks and coding style, so the least I would wish for is:
> >     *.h
> >     *.c
> >   but as we have more to look at, I would want to have the most abstract
> >   thing to come first. And most abstract from the actual code is the
> >   user interaction, the documentation.
> 
> This is exactly why I invented the orderfile in the first place.
> But such a "policy" is not something a project would want to enforce
> its users all the time; it is left to personal preference of the
> participants.
> 
> Just set diff.orderFile to suit your taste without bothering other
> people, I would say.

I could see somebody arguing that format-patch should respect a project
preference, since its primary purpose is to communicate your work to the
rest of the project.

But then you could make a similar argument for other diff options, too.

-Peff
