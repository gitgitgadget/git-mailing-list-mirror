Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF659C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA65D60E91
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhGWG6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:58:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:55418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233763AbhGWG6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:58:52 -0400
Received: (qmail 10234 invoked by uid 109); 23 Jul 2021 07:39:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 07:39:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22962 invoked by uid 111); 23 Jul 2021 07:39:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 03:39:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 03:39:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Message-ID: <YPpyLaM1Rc9+w6KT@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <YPfv0YoLtpYp9866@coredump.intra.peff.net>
 <YPfyEiXw7szt5mjl@coredump.intra.peff.net>
 <YPhYFnudmHJ9lQek@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPhYFnudmHJ9lQek@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 01:23:34PM -0400, Taylor Blau wrote:

> > I don't know if it's better to have a poorly-formatted HTML file, or
> > none at all. :)
> >
> > Personally, I would just read the source. And I have a slight concern
> > that if we start "cleaning it up" to render as asciidoc, the source
> > might end up a lot less readable (though I'd reserve judgement until
> > actually seeing it).
> 
> Yeah, the actual source is pretty readable (and it's what I had been
> looking at, although it is sometimes convenient to have a version I can
> read in my web browser). But it's definitely not good Asciidoc.
> 
> I briefly considered cleaning it up, but decided against it. Usually I
> would opt to clean it up, but this series is already so large that I
> figured it would make a negative impact on the reviewer experience to
> read a clean-up patch here.
> 
> I wouldn't be opposed to coming back to it in the future, once the dust
> settles. I guess we can consider this #leftoverbits until then.

Yeah, I definitely don't want to see that cleanup as a dependency for
this series. It's already long enough as it is. Coming back to it later
is just fine with me.

The question here is: should we continue to omit it from the html build,
since it does not render well (i.e., should we simply drop this patch).

-Peff
