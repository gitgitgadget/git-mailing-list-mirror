Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF93C1FC44
	for <e@80x24.org>; Mon,  8 May 2017 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756773AbdEHUTB (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 16:19:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:47611 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754588AbdEHUTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 16:19:00 -0400
Received: (qmail 19466 invoked by uid 109); 8 May 2017 20:18:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 20:18:58 +0000
Received: (qmail 16319 invoked by uid 111); 8 May 2017 20:19:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 16:19:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 16:18:56 -0400
Date:   Mon, 8 May 2017 16:18:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: git and the Clang Static Analyzer
Message-ID: <20170508201855.ki4rqry47pdt5u26@sigill.intra.peff.net>
References: <5696a8a3-0a17-18ac-8da4-4556586acee7@aegee.org>
 <alpine.DEB.2.21.1.1705081250550.146734@virtualbox>
 <373a6f4b-1b4d-6c75-30b1-c2498555c3d9@aegee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <373a6f4b-1b4d-6c75-30b1-c2498555c3d9@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 09:26:11PM +0200, Дилян Палаузов wrote:

> Click on  https://mail.aegee.org/dpa/scan-build-git-4fa66c85f11/ and
> then on "fast-import.c: line 2057 -> View Report" and you will see
> pointless assignment.
> 
> I cannot organize the report much better, as filtering out the false
> positives requires usually too deep understanding of the code
> organization of git, which I do not have.

Right, but I think Johannes's point is that we already know about
scan-build. It's been discussed on the list multiple times. The next
step is somebody actually looking at each reported issue, fixing any
problematic ones, and suppressing (or at least cataloging) the false
positives.

Here's a link to the last discussion on this topic, from a few months
ago:

  http://public-inbox.org/git/CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com/T/#u

It even involves a Travis build. :)

-Peff
