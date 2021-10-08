Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E5FC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 05:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BF960F3A
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 05:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJHFnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 01:43:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:35616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhJHFnb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 01:43:31 -0400
Received: (qmail 2838 invoked by uid 109); 8 Oct 2021 05:41:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 05:41:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31382 invoked by uid 111); 8 Oct 2021 05:41:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 01:41:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 01:41:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de
Subject: Re: [PATCH] t/perf: do not run tests in user's $SHELL
Message-ID: <YV/aD6NKdG+w9ghr@coredump.intra.peff.net>
References: <20211002112640.hrn2ojndhoa2dd4c@gmail.com>
 <20211007184716.1187677-1-aclopte@gmail.com>
 <YV+1/0b5bN3o6qRG@coredump.intra.peff.net>
 <20211008053450.wjttkhsbbsnuwwpt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008053450.wjttkhsbbsnuwwpt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 07:34:50AM +0200, Johannes Altmanninger wrote:

> On Thu, Oct 07, 2021 at 11:07:43PM -0400, Jeff King wrote:
> 
> > I wondered if we would always have TEST_SHELL_PATH set, but we should:
> > it is put unconditionally into GIT-BUILD-OPTIONS, and we will always
> > load that via test-lib.sh, even if the test is run outside of "make".
> 
> Yeah I was gonna add this to the commit message but didn't because it's fairly
> easy to check. Probably still better to include it. I can resend if that helps.

I think it's probably fine as-is. Mostly I was talking to myself out
loud to let people follow along my review process. :)

-Peff
