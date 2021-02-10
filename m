Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD40FC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34FF64E57
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhBJQGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:06:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:56458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhBJQGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:06:33 -0500
Received: (qmail 32412 invoked by uid 109); 10 Feb 2021 16:05:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 16:05:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20643 invoked by uid 111); 10 Feb 2021 16:05:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 11:05:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 11:05:49 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Bryan Turner <bturner@atlassian.com>, SURA <surak8806@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
Message-ID: <YCQEXXB5QUpVTx8/@coredump.intra.peff.net>
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
 <YB148VZJqKIPC8P2@coredump.intra.peff.net>
 <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
 <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
 <CAPig+cSdTCYV=2OMEZTqahrfBypaHeD40ToMFJ1zbRNpkiPbYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSdTCYV=2OMEZTqahrfBypaHeD40ToMFJ1zbRNpkiPbYw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 02:00:37PM -0500, Eric Sunshine wrote:

> On Tue, Feb 9, 2021 at 12:31 PM Jeff King <peff@peff.net> wrote:
> > Subject: [PATCH] mailmap: only look for .mailmap in work tree
> > [...]
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> > @@ -113,6 +113,10 @@ MAPPING AUTHORS
> > +Note that if `git shortlog` is run outside of a repository (to process
> > +log contents on stdin), it will look for a `.mailmap` file in the
> > +current directory.
> 
> Elsewhere in this same document, techy-jargon "stdin" is spelled out
> fully as "standard input".

Thanks. We seem to use "stdin" in other manpages, but I agree it makes
sense to be consistent here.

-Peff
