Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE9620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 08:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeLMILA (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 03:11:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:40356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726500AbeLMILA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 03:11:00 -0500
Received: (qmail 24193 invoked by uid 109); 13 Dec 2018 08:10:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Dec 2018 08:10:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22493 invoked by uid 111); 13 Dec 2018 08:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Dec 2018 03:10:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2018 03:10:58 -0500
Date:   Thu, 13 Dec 2018 03:10:58 -0500
From:   Jeff King <peff@peff.net>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
Subject: Re: [PATCH] run-command: report exec failure
Message-ID: <20181213081057.GC12132@sigill.intra.peff.net>
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet>
 <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com>
 <CAJdN7Khf+Y_jyyG2qoqiMHYPCHHSws15EDftOQni=gFJ7SoMXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJdN7Khf+Y_jyyG2qoqiMHYPCHHSws15EDftOQni=gFJ7SoMXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 10:27:40AM -0500, John Passaro wrote:

> Thank you for this incredibly quick fix.
> 
> I see the fix made it to pu as 6b206be3e5 ("run-command: report exec
> failure" 2018-12-11).  For what it's worth, it fixes the issue as far
> as I'm concerned and I'm very glad to see the behavior is covered by
> tests now.
> 
> As a procedural question: I'd like to reference this patch in one of
> my own. Can I reference it as I typed it above? Or is there a chance
> of the SHA1 changing before it goes into some sort of a main history?

Commits in "pu" are still subject to change (and indeed, this one was
amended to e5a329a279 to fix the grep issue on Windows).

Once it hits "next" it is generally stable. That hasn't happened yet,
but I think what's there now is likely to get merged as-is (and will
retain that commit id).

-Peff
