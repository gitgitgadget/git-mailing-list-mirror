Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8791FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764340AbdJQVIh (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:08:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:55950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1764125AbdJQVIg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:08:36 -0400
Received: (qmail 16408 invoked by uid 109); 17 Oct 2017 21:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 21:08:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27380 invoked by uid 111); 17 Oct 2017 21:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 17:08:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Oct 2017 17:08:34 -0400
Date:   Tue, 17 Oct 2017 17:08:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: Re* Is t5601 flaky for anybody else?
Message-ID: <20171017210833.n5vgly7z2zi5dhuh@sigill.intra.peff.net>
References: <xmqq376ipdpx.fsf@gitster.mtv.corp.google.com>
 <20171017171046.GA48544@google.com>
 <xmqqshehmqrg.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshehmqrg.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 06:02:59AM +0900, Junio C Hamano wrote:

> Brandon Williams <bmwill@google.com> writes:
> 
> > I haven't noticed any issues myself but maybe this has something to do
> > with my changes to this test in the 'bw/protocol-v1' topic?
> 
> As I've seen this on 'master', too, I suspect the topic has nothing
> to do with it.
> 
> Here is what I have on 'pu'.

FWIW, I can't replicate the problem on either "master" or "pu". I wonder
why.

-Peff
