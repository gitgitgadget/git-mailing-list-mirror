Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B47C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7C760FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbhJHXDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:03:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:36240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhJHXDD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 19:03:03 -0400
Received: (qmail 6822 invoked by uid 109); 8 Oct 2021 23:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 23:01:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24381 invoked by uid 111); 8 Oct 2021 23:01:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 19:01:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 19:01:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alan Mackenzie <acm@muc.de>, git@vger.kernel.org
Subject: Re: How do I get the file contents from an arbitrary revision to
 stdout?
Message-ID: <YWDM0HASo7VMwnz1@coredump.intra.peff.net>
References: <YWCFFcNeNVTYcELN@ACM>
 <YWCj6NqMrxksN1V8@coredump.intra.peff.net>
 <xmqqtuhri3mc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuhri3mc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 02:54:51PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   git cat-file -p bar-branch:foo.c
> >
> > (the "-p" is "pretty-print based on the object's type", so the two are
> > equivalent).
> 
> IIRC, "cat-file -p" doesn't do textconv, but "show" would, and
> depending on the use case the difference may matter.

Sorry, I should have been more clear. I meant that the two cat-file
invocations are equivalent (using "blob" versus "-p").

I agree that for human consumption, "show" is preferable.

-Peff
