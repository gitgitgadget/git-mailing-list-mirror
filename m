Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791DF20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 15:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbdK0P1w (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 10:27:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:41432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752597AbdK0P1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 10:27:51 -0500
Received: (qmail 24786 invoked by uid 109); 27 Nov 2017 15:27:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 15:27:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3227 invoked by uid 111); 27 Nov 2017 15:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 10:28:08 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 10:27:49 -0500
Date:   Mon, 27 Nov 2017 10:27:49 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171127152748.GA23218@sigill.intra.peff.net>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
 <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
 <20171126191510.GA1501@sigill>
 <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com>
 <xmqqshd0e41a.fsf@gitster.mtv.corp.google.com>
 <20171127043502.GA5946@sigill>
 <CAP8UFD2tB_CpopP5OuqPSBfeeGzXfoC_Hz-UeT=eNW1fU6zyzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2tB_CpopP5OuqPSBfeeGzXfoC_Hz-UeT=eNW1fU6zyzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 09:24:47AM +0100, Christian Couder wrote:

> > Yeah, this side-steps the "other half" of the issue that Christian's
> > patch addresses, which seems like the more controversial part (I don't
> > have a strong opinion myself, though).
> 
> I don't think any part of my patch should be controversial. I
> repeatedly wrote very long messages to show all the possible cases, so
> that it is easy to see that we are not worse in any case. And all the
> competing suggestions, even the above from Junio either have
> significant problems or address a different problem.

Sorry, controversial may not have been the right word. It's just that
the review discussion focused around packagers who may want to build git
without having "wish" on the build machine. If everybody is happy with
the BYPASS mechanism you added to address that, then I'm perfectly fine
with it.

-Peff
