Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D4EC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E213220795
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbgJPAqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 20:46:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:33832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388704AbgJPAqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 20:46:04 -0400
Received: (qmail 25859 invoked by uid 109); 16 Oct 2020 00:46:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 00:46:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3147 invoked by uid 111); 16 Oct 2020 00:46:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 20:46:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 20:46:03 -0400
From:   Jeff King <peff@peff.net>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: Clarify and expand description of
 --signoff
Message-ID: <20201016004603.GC2932796@coredump.intra.peff.net>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
 <20201015215933.96425-2-bkuhn@sfconservancy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015215933.96425-2-bkuhn@sfconservancy.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 02:59:33PM -0700, Bradley M. Kuhn wrote:

> Building on past documentation improvements in Commit
> b2c150d3aa (Expand documentation describing --signoff, 2016-01-05),
> further clarify that any project using Git may and often does set its
> own policy.
> 
> However, leave intact reference to the Linux DCO, which Git also
> uses.  It is reasonable for Git to advocate for its own Signed-off-by
> methodology in its documentation, as long as the documentation
> remains respectful that YMMV and other projects may well have very
> different contributor representations tied to Signed-off-by.

I think this is worth doing, and doesn't really change the intent of
what we were trying to do with b2c150d3aa. It just says it a bit more
clearly, IMHO.

Except for one minor nit below, the patch looks good to me.
Unsurprisingly, since as you mentioned we discussed it off-list
already. :)

To be clear, it's...

  Signed-off-by: Jeff King <peff@peff.net>

as far as any words I contributed.

As far as your patch formatting, submission, etc, it looks OK. I
probably would've kept "clarify" in the title as lowercase. I'd also
usually not do a separate cover letter for a single-patch series (and
instead put anything not meant for the commit message after the "---"
line). But that's mostly a matter of taste (a lot of people do separate
cover letters).

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 80d4831662..c9df9cc0f4 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> [...]
> +	leadership of the project to which you're contributing to understand
> +	 how the signoffs are used in that project.

Extra leading space on this final line.

-Peff

PS Since this is your first patch submission, welcome to the Git
   project. ;)
