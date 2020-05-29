Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6927C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1F220DD4
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436873AbgE2Dhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 23:37:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:59658 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436641AbgE2Dhl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 23:37:41 -0400
Received: (qmail 1027 invoked by uid 109); 29 May 2020 03:37:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2020 03:37:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20595 invoked by uid 111); 29 May 2020 03:37:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 23:37:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 23:37:40 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
Message-ID: <20200529033740.GD1271617@coredump.intra.peff.net>
References: <20200528231608.59507-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528231608.59507-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 04:16:08PM -0700, Emily Shaffer wrote:

> Since this patch deals with some prominent information about how to
> contact the community, I figured it was worth passing through the list
> for feedback rather than just sending a PR to the website repo.
> Discussion prior to this patch here:
> https://github.com/git/git-scm.com/issues/1464

Thanks for doing that. I'd echo my sentiment in that issue that if
anybody from list community is interested in suggesting changes to the
Community page, we're happy to take patches. The bug-reporting advice
there has been slowly added over the years, and fresh eyes may produce
useful insights.

> diff --git a/app/views/community/index.html.erb b/app/views/community/index.html.erb
> index 6927e19..bfcb089 100644
> --- a/app/views/community/index.html.erb
> +++ b/app/views/community/index.html.erb
> @@ -36,10 +36,13 @@
>  
>    <p>
>      Bugs in git can be reported directly to the mailing list (see above for
> -    details). Note that you do not need to subscribe to the list to send
> -    to it. You can help us out by attempting to reproduce the bug in the latest
> -    released version of git, or if you're willing to build git from source, the
> -    <a href="https://github.com/git/git/tree/next"><code>next</code> branch</a>.
> +    details). Note that you do not need to subscribe to the list to send to it.
> +    If you are using git 2.27.0 or later, you can run <code>git bugreport</code>,

Perhaps make this a link to /docs/git-bugreport? That's not active yet,
but will be when we release v2.27 (scheduled for Monday). We could hold
this patch until then.

Other than that, looks good to me, modulo the /break/ thing mentioned
elsewhere.

-Peff
