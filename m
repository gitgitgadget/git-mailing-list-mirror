Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F78C1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeGPTZD (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:25:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:48214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728417AbeGPTZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:25:03 -0400
Received: (qmail 9708 invoked by uid 109); 16 Jul 2018 18:56:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 18:56:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14318 invoked by uid 111); 16 Jul 2018 18:56:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 14:56:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 14:56:18 -0400
Date:   Mon, 16 Jul 2018 14:56:18 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
Message-ID: <20180716185618.GD22298@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <20180716161821.GB18150@sigill.intra.peff.net>
 <CAPig+cTVP2kubTEZBms_x1FvnqjGcX3pjTRXfjBMfMtdpbJt=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTVP2kubTEZBms_x1FvnqjGcX3pjTRXfjBMfMtdpbJt=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 02:40:21PM -0400, Eric Sunshine wrote:

> On Mon, Jul 16, 2018 at 12:18 PM Jeff King <peff@peff.net> wrote:
> > On Mon, Jul 16, 2018 at 02:54:38PM +0100, Ramsay Jones wrote:
> > > This is not your problem, but I find these GitGitGadget
> > > submissions somewhat annoying. This series has been spewed
> > > all over my in-box in, what I assume, is commit date order.
> > >
> > > So, patches #4,5 dated 19/06, then #1,2,3 dated 25/06,
> > > then #15 dated 28/06, then #6,7 dated 12/07, then #8-16
> > > dated 13/07, then 00/16 dated today.
> >
> > Yeah, they're out of order in mutt's threaded display. And the
> > back-dating means there's a much higher chance of them getting blocked
> > as spam (e.g., some of the dates are from weeks ago).
> >
> > git-send-email uses the current time minus an offset, and then
> > monotonically increases for each patch:
> 
> Junio pointed this out to gitgitgadget developers in [1], which led to
> an issue being opened[2]. That issue was merged today.
> 
> [1]: https://public-inbox.org/git/xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com/
> [2]: https://github.com/gitgitgadget/gitgitgadget/pull/15

I was going to say "oh good, fixed", but it looks like it just merged
adding that line to the TODO list. :)

Still, it looks like wheels are in motion, which is nice.

-Peff
