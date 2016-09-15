Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AF62070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbcIOSuH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:50:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:43847 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbcIOSuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:50:05 -0400
Received: (qmail 21950 invoked by uid 109); 15 Sep 2016 18:50:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 18:50:05 +0000
Received: (qmail 11245 invoked by uid 111); 15 Sep 2016 18:50:15 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 14:50:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 11:50:01 -0700
Date:   Thu, 15 Sep 2016 11:50:01 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathon Mah <me@jonathonmah.com>, git@vger.kernel.org
Subject: Re: Tracking down a segfault in delta_base_cache
Message-ID: <20160915185001.23mhj6qkvd4kskkp@sigill.intra.peff.net>
References: <3946EE74-219D-4E9C-9CED-69D53B940955@jonathonmah.com>
 <20160915005640.3ui4qfmiqjz2lsov@sigill.intra.peff.net>
 <6FA0A47C-61CB-4602-8629-46448E582292@jonathonmah.com>
 <xmqqa8f9oymk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8f9oymk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 10:34:43AM -0700, Junio C Hamano wrote:

> Jonathon Mah <me@jonathonmah.com> writes:
> 
> >> On 2016-09-14, at 17:56, Jeff King <peff@peff.net> wrote:
> >> 
> >> Have you tried with the patch in:
> >> 
> >>  http://public-inbox.org/git/20160912164616.vg33kldazuthff3d@sigill.intra.peff.net/
> > All the examples I've tried work when I use that. Thanks!
> 
> Peff, thanks for a quick suggestion and Jonathon, thanks for a quick
> confirmation.

Better still would have been for me not to introduce the segfault in the
first place. ;)

-Peff
