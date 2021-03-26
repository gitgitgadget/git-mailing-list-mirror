Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD7C433E0
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DFB61A18
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZIpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:45:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:49664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhCZIpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 04:45:24 -0400
Received: (qmail 29841 invoked by uid 109); 26 Mar 2021 08:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 08:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2306 invoked by uid 111); 26 Mar 2021 08:45:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 04:45:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 04:45:22 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: give an overview of what a "patch" message
 is
Message-ID: <YF2fIhVUwBim47Wq@coredump.intra.peff.net>
References: <20210325105433.43310-1-bagasdotme@gmail.com>
 <xmqqmturuh8o.fsf@gitster.g>
 <7c0aabe0-9240-950e-912f-0a195db7a144@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c0aabe0-9240-950e-912f-0a195db7a144@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 03:26:25PM +0700, Bagas Sanjaya wrote:

> On 26/03/21 03.10, Junio C Hamano wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> > 
> > > The text says something called a "patch" is prepared one for each
> > > commit, it is suitable for e-mail submission, and "am" is the
> > > command to use it, but does not say what the "patch" really is.  The
> > > description in the page also refers to "three-dash" line, but that
> > > is totally unclear unless the reader is given a more detailed
> > > overview of what the "patch" the first paragraph refers to.
> > > 
> > > Co-authored-by: Junio C Hamano <gitster@pobox.com>
> > > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > ---
> > 
> > I do not think this was co-authored; you are forwarding somebody
> > else's patch that was written without any input from you.
> > 
> Oh dear...
> 
> Next time when I need to send patches forwarded from you (or others),
> but not necessarily Co-authored-by, what should I do? Something like
> this note below?
> 
> [forwarded from someone]

You should start the first line of the message body with:

  From: Original Author <orig@example.com>

git-send-email will do this automatically if the author of the commit you
are sending does not match your identity (you may also need to use "git
commit --author" to make sure the author is set correctly in the
commit).

-Peff
