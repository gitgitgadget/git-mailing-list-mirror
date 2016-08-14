Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE521FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 12:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbcHNMXy (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 08:23:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55009 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753205AbcHNMXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 08:23:54 -0400
Received: (qmail 28353 invoked by uid 109); 14 Aug 2016 12:23:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 12:23:53 +0000
Received: (qmail 8087 invoked by uid 111); 14 Aug 2016 12:23:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 08:23:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Aug 2016 08:23:51 -0400
Date:	Sun, 14 Aug 2016 08:23:51 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160814122351.oblpop2qu4wjrhdx@sigill.intra.peff.net>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
 <20160812224255.GA16250@dcvr>
 <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
 <20160813090432.GA25565@starla>
 <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net>
 <20160814012706.GA18784@starla>
 <20160814021234.GA1017@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160814021234.GA1017@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 02:12:34AM +0000, Eric Wong wrote:

> Eric Wong <e@80x24.org> wrote:
> > Thanks, should all be imported.
> 
> Oops, missed one which was missing X-Mailing-List (causing
> it to not get imported) and had "X-No-Archive: yes" set;
> which meant I couldn't get it from gmane this year.
> 
> Hmm... XNAY defeats the point of public-inbox (and probably the
> point of public-to-all mailing lists); so I don't think it's
> worth honoring.

I didn't even think to look for that header. It looks like it's
basically all one guy. I would argue that it should not be honored for
the git dev list, if only because those emails are a record of the
provenance of patches. The Signed-off-by is a certification that the
patch is OK to submit, but it's presumably worth more with an audit
trail including the email headers.

(Also, I have always found it a little silly to post publicly with a
"please don't anybody record this!" header).

-Peff
