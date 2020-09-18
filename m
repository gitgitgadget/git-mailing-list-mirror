Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4BC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 23:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFAC21734
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 23:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIRX2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 19:28:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:33948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgIRX2G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 19:28:06 -0400
Received: (qmail 14140 invoked by uid 109); 18 Sep 2020 23:28:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 23:28:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29223 invoked by uid 111); 18 Sep 2020 23:28:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 19:28:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 19:28:05 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     postmaster@vger.kernel.org,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Has there been a change in Git Mailing List settings?  From list
 as sender to originator as sender?
Message-ID: <20200918232805.GA1197580@coredump.intra.peff.net>
References: <AM0PR02MB408170D1A71FB8C0E82A14789C3E0@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <20200917130139.GB3024501@coredump.intra.peff.net>
 <20200918225326.GA1367@pug.qqx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918225326.GA1367@pug.qqx.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc postmaster@vger; it looks like messages to the git-list stopped
including a Sender header as of a few days ago]

On Fri, Sep 18, 2020 at 06:53:26PM -0400, Aaron Schrab wrote:

> > Not to my knowledge. The smtp-level envelope from on all of the messages
> > I've received is git-owner@vger.kernel.org. Is there some other
> > mechanism you might be filtering on?
> 
> Comparing <20200911143321.GA2374950@coredump.intra.peff.net> with the
> message I'm replying to so that I'd have messages which I would expect to be
> similar before the list handling I see that that older message included the
> header
> 
>   Sender: git-owner@vger.kernel.org
> 
> But the newer message does not have a Sender: header.

Ah, thanks. I even looked for a Sender header, but I stupidly looked at
too-recent messages, which of course didn't have one. :)

According to my local archive, we stopped getting Sender headers around
1600296026 (that's the timestamp when I received it), which was

  Date:   Wed, 16 Sep 2020 17:11:50 -0400
  Subject: Re: [PATCH 3/5] t3200: avoid variations of the `master` branch name
  https://lore.kernel.org/git/20200916211150.GA617237@coredump.intra.peff.net/

The message I received right before that was:

  Date: Wed, 16 Sep 2020 14:25:42 -0700
  Subject: Re: [PATCH 2/5] t/test-terminal: avoid non-inclusive language
  https://lore.kernel.org/git/xmqqo8m5v2g9.fsf@gitster.c.googlers.com/

which does have a Sender header (note those are out of order if you
believe the client-side Date headers).

> I don't know if that was a deliberate change.

I don't know, but we don't really admin the list ourselves. kernel.org
folks do, so they might have input.

-Peff
