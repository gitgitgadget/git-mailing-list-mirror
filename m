Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB8120958
	for <e@80x24.org>; Tue, 21 Mar 2017 02:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755585AbdCUCAp (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 22:00:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48365 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755123AbdCUCAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 22:00:45 -0400
Received: (qmail 12778 invoked by uid 109); 21 Mar 2017 01:54:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:54:01 +0000
Received: (qmail 10124 invoked by uid 111); 21 Mar 2017 01:54:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:54:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:53:56 -0400
Date:   Mon, 20 Mar 2017 21:53:56 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] t1400: use test_when_finished for cleanup
Message-ID: <20170321015356.3unr3ptwaaerfu2y@sigill.intra.peff.net>
References: <20170321005616.31324-1-kyle@kyleam.com>
 <20170321005616.31324-6-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321005616.31324-6-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 08:56:16PM -0400, Kyle Meyer wrote:

> Move cleanup lines that occur after test blocks into
> test_when_finished calls within the test bodies.  Don't move cleanup
> lines that seem to be related to mutiple tests rather than a single
> test.

Sounds logical. The patch looks good to me (though I'll admit my eyes
may have glazed a little in the middle).

-Peff
