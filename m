Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C405C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8BE613F6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbhELXZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:25:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:52894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349434AbhELWi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:38:27 -0400
Received: (qmail 29937 invoked by uid 109); 12 May 2021 22:37:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 22:37:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10013 invoked by uid 111); 12 May 2021 22:37:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 18:37:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 18:37:16 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJxYnCg5y4DT+J9H@coredump.intra.peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net>
 <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
 <CAPig+cQ6xw_RDmStExWGjmwuQQP+q5F5wCMtrMvtDt4GaAKXUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ6xw_RDmStExWGjmwuQQP+q5F5wCMtrMvtDt4GaAKXUg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 03:53:09PM -0400, Eric Sunshine wrote:

> On Wed, May 12, 2021 at 2:30 AM Jeff King <peff@peff.net> wrote:
> > The new option enables both asciidoctor as well as its direct-to-manpage
> > mode that skips xmlto. This lets you view the rendered difference
> > between the two pipelines with something like:
> >
> >   ./doc-diff --from-asciidoctor --to-asciidoctor-direct HEAD HEAD
> >
> > Note that we have to add quotes when passing around $makemanflags, as it
> > now may contain whitespace due to multiple arguments (but the deference
> 
> I suppose you meant s/deference/dereference/ ?

Yep, thanks.

-Peff
