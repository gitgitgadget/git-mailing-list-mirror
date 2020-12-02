Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE0C64E7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD2621D7E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 02:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgLBCB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 21:01:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:48230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgLBCBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 21:01:55 -0500
Received: (qmail 29812 invoked by uid 109); 2 Dec 2020 02:01:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 02:01:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2852 invoked by uid 111); 2 Dec 2020 02:01:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 21:01:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 21:01:14 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] refspec: trivial cleanup
Message-ID: <X8b1au+GDihNvhIQ@coredump.intra.peff.net>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-2-felipe.contreras@gmail.com>
 <X8YsXjN7MQrLnytw@coredump.intra.peff.net>
 <CAMP44s3usd5EW4sA6_qapnDBVRAWg4nk5ZSxAPPQN1UygD=ctA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s3usd5EW4sA6_qapnDBVRAWg4nk5ZSxAPPQN1UygD=ctA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 05:25:53PM -0600, Felipe Contreras wrote:

> > I know your question was rhetorical, but a good reason not to do so in
> > general is that the existing pattern reveals some intent. E.g., it
> > sometimes is the case that with the _current_ code we can return early
> > from a function or loop, but that is not inherent to what the code is
> > doing, and the early return or continue makes it harder to understand
> > that.
> 
> Yes, but even in those cases it arguably helps readability.
> 
> Anyway, I prefer to argue on the tangible rather than hypotheticals
> because the hypotheticals are infinite.
>
> In this particular case there's no particular reason to just continue
> if there's no prefix.

Right, which I already agreed with.

I hesitated on responding at all, because you and I have not had a good
history of agreeing on commit messages. But my comment was primarily for
other readers on the list. I do not want people blindly applying a rule
like "less indentation is good" without thinking about the code overall
(I don't know whether you thought about it or not, but it was not
apparent from your commit message).

-Peff
