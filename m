Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A20DC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343FD6142E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFOJ0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:26:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:55754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhFOJ0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:26:46 -0400
Received: (qmail 7170 invoked by uid 109); 15 Jun 2021 09:24:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Jun 2021 09:24:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12119 invoked by uid 111); 15 Jun 2021 09:24:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Jun 2021 05:24:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Jun 2021 05:24:40 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Message-ID: <YMhx2BFlwUxZ2aFJ@coredump.intra.peff.net>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
 <60c647c1d9b5c_41f452089@natae.notmuch>
 <YMbexfeUG78yBix4@coredump.intra.peff.net>
 <60c82a622ae66_e5292087f@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60c82a622ae66_e5292087f@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 11:19:46PM -0500, Felipe Contreras wrote:

> > My point is that if you are going to repost a patch that has known
> > problems,
> 
> It was not known that it had problems.
> 
> That fact that person X said patch Y had a problem doesn't necessarily
> mean that patch Y has a problem.
> 
>   1. The problem in the past might not apply in the present
>   2. The problem X person had might be specific to his/her setup
>   3. The problem might be due a combination of patches, not the patch
>      itself
> 
> Plus many others.
> 
> A logical person sees evidence for what it is, and the only thing that
> person X saying patch Y had a problem means, is that person X said patch
> Y had a problem.

Wow.

For one thing, you could still relay the _report_ of a problem along
with the patch, which would be valuable information for reviewers.

But much more important, in my opinion: that you would dismiss without
further investigation a report of a bug from the one person who actually
had experience running with the patch implies a level of carelessness
that I'm not comfortable with for the project.

I had already given up on having substantive discussion with you, but I
had hoped I could help the project by pointing out relevant facts in
areas that you were working in. But if a simple statement like "this
segfaulted for me" is not even useful, then I don't see much point in
communicating with you at all.

-Peff
