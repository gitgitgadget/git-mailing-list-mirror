Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FFC211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 06:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfAFGWc (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 01:22:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:55748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726394AbfAFGWc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 01:22:32 -0500
Received: (qmail 1702 invoked by uid 109); 6 Jan 2019 06:22:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 06 Jan 2019 06:22:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27109 invoked by uid 111); 6 Jan 2019 06:22:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 06 Jan 2019 01:22:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2019 01:22:30 -0500
Date:   Sun, 6 Jan 2019 01:22:30 -0500
From:   Jeff King <peff@peff.net>
To:     Erin Dahlgren <eedahlgren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] Simplify handling of setup_git_directory_gently()
 failure cases.
Message-ID: <20190106062229.GB4207@sigill.intra.peff.net>
References: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
 <1545953789-15040-1-git-send-email-eedahlgren@gmail.com>
 <20190103051432.GE20047@sigill.intra.peff.net>
 <xmqqy381haup.fsf@gitster-ct.c.googlers.com>
 <20190104082558.GB26014@sigill.intra.peff.net>
 <CAP_Smy0Phh83XW-m0_cGg6WuLpDySshP7Ys2OrD8no1hJzohpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP_Smy0Phh83XW-m0_cGg6WuLpDySshP7Ys2OrD8no1hJzohpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 05, 2019 at 08:57:32AM -0800, Erin Dahlgren wrote:

> > So what next? Erin, are you interested in using the details of this
> > conversation to take the cleanups a bit further?
> 
> Sure, no problem. If this is urgent, then I would probably be more
> inclined to keep this small and do more cleanup in followup patches.
> But if it's not urgent (that is my understanding), I'd be happy to
> take the cleanups further. I'm traveling today through next week but
> I'll try to post another version addressing the comments in the next
> couple of days.

Nope, I don't think it's urgent at all.  I just didn't want to dump work
on you if you were losing interest in the topic. :)

-Peff
