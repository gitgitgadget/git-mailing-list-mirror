Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7689EC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544F861004
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbhERCKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 22:10:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:57162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346215AbhERCJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 22:09:59 -0400
Received: (qmail 8581 invoked by uid 109); 18 May 2021 02:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 02:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2987 invoked by uid 111); 18 May 2021 02:08:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 22:08:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 22:08:41 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Message-ID: <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a2daa57d8a6_13c370208f3@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 04:05:41PM -0500, Felipe Contreras wrote:

> > >> Nobody uses "origin" (what does that even mean?), [...]
> > >
> > > I guess I'm "nobody" then, because I use it all the time.
> > 
> > Oh, I'm nobody, too, and so are many others ;-)
> 
> That depends on the definition of "many". My guess is that it's less
> than 1% of users (probably 0.01%), and for me that's not many.
> 
> If you google for `git remote "set-head"` there's barely any
> information. It's basically all online man pages.

Why would people need to use "git remote set-head" most of the time? The
symlink is set up properly by git-clone, and has been for many years.
For most people, using "origin" just works (the exception is people who
"git init" and then "git remote add origin" themselves; since we're
guessing at numbers, I would guess that _that_ population is less than
1% of users).

-Peff
