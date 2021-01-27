Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FCC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A122B64D7F
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhA0XiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:38:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:41418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235669AbhA0Xh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 18:37:28 -0500
Received: (qmail 7537 invoked by uid 109); 27 Jan 2021 23:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jan 2021 23:36:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21465 invoked by uid 111); 27 Jan 2021 23:36:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Jan 2021 18:36:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Jan 2021 18:36:45 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] rev-list: add --disk-usage option for calculating
 disk usage
Message-ID: <YBH5DarZvg/phGjP@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
 <87mtwuvva8.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtwuvva8.fsf@kyleam.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 06:01:51PM -0500, Kyle Meyer wrote:

> > +--disk-usage::
> > +	Suppress normal output; instead, print the sum of the bytes used
> > +	for on-disk storage by the selected objects. This is equivalent
> > +	to piping the output of `rev-list --objects` into
> > +	`git cat-file --batch-check='%(objectsize:disk)', except that it
> 
> [ Just a drive-by typo comment from a reader not knowledgeable enough to
>   review the code change :) ]
> 
> The cat-file command is missing its closing quote.

Thanks for catching that. I should have looked at the output of
doc-diff, which does reveal it.

-Peff
