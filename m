Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1E0211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 21:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbeLCV1a (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:27:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:57658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725903AbeLCV1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 16:27:30 -0500
Received: (qmail 2980 invoked by uid 109); 3 Dec 2018 21:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 21:27:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14049 invoked by uid 111); 3 Dec 2018 21:26:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 16:26:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 16:27:28 -0500
Date:   Mon, 3 Dec 2018 16:27:28 -0500
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
Message-ID: <20181203212728.GC8700@sigill.intra.peff.net>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>
 <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet>
 <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
 <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
 <ab4b0a47-858e-659f-f970-944b7c5313fc@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab4b0a47-858e-659f-f970-944b7c5313fc@talktalk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 02:31:37PM +0000, Phillip Wood wrote:

> > How would I move past the test that fails to continue? I guess "git
> > rebase --edit-todo" and then manually remove it (and any other remaining
> > test lines)?
> 
> Perhaps we could teach git rebase --skip to skip a rescheduled command, it
> could be useful if people want to skip rescheduled picks as well (though I
> don't think I've ever had that happen in the wild). I can see myself turning
> on the rescheduling config setting but occasionally wanting to be able to
> skip over the rescheduled exec command.

Yeah, I agree that would give a nice user experience.

-Peff
