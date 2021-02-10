Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F56C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F8B60201
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhBJUjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:39:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:56828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhBJUjk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:39:40 -0500
Received: (qmail 1109 invoked by uid 109); 10 Feb 2021 20:38:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 20:38:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23451 invoked by uid 111); 10 Feb 2021 20:38:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 15:38:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 15:38:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
Message-ID: <YCREYmBsnv2wgvXZ@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
 <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
 <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 08:31:08AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But in practice, we've found this kind of naive --disk-usage useful for
> > answering questions like:
> [...]
>
> I kind of feel sad to have a nice write-up like this only in the
> list archive.  Is there a section in our documentation set to keep
> collection of such a real-life use cases?  Perhaps the examples
> section of manpages is the closest thing, but it looks a bit too
> narrowly scoped for the example section of "rev-list" manpage.

Agreed on both counts. If this gets put into a release, I suspect Taylor
would cover it in a release blog post. That is not quite the same thing
as having it in the documentation, but it may provide more search engine
boost than the list archive. I dunno.

-Peff
