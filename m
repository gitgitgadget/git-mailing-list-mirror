Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C7A1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 19:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756255AbcHXTAo (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 15:00:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:60684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754056AbcHXTAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 15:00:42 -0400
Received: (qmail 16774 invoked by uid 109); 24 Aug 2016 18:34:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 18:34:01 +0000
Received: (qmail 5670 invoked by uid 111); 24 Aug 2016 18:34:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 14:34:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 14:33:58 -0400
Date:   Wed, 24 Aug 2016 14:33:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] for-each-ref: add %(upstream:gone) to mark missing
 refs
Message-ID: <20160824183358.ahxcgcrg7jo2rygp@sigill.intra.peff.net>
References: <20160822173528.755-1-oystwa@gmail.com>
 <20160824180730.mqlvhkthg4imd2vy@sigill.intra.peff.net>
 <CAFaJEqvm9Xj34t+F=KMtwRDEYhwHZ7=MRwsZ22-Gt_UPd4r72A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFaJEqvm9Xj34t+F=KMtwRDEYhwHZ7=MRwsZ22-Gt_UPd4r72A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 08:26:26PM +0200, Øystein Walle wrote:

> In the mean time, however, I have discovered that this conflicts with
> kn/ref-filter-branch-list in pu. In that topic this specific feature is
> implemented as well. They incorporate it into %(upstream:track) instead
> of having a separate "sub-atom" (what's the correct nomenclature, by the
> way?) more in line with with branch -vv and your idea.

Ah, right. I was feeling like this was all vaguely familiar. I think it
would be better to push forward kn/ref-filter-branch-list. According to
the last "what's cooking", I think that topic is waiting on more review.
If you're willing and able to do so, that would be a big help.

Thanks.

-Peff
