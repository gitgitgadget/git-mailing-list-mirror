Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F9C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F5A20709
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgLBBo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:44:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:48158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgLBBo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 20:44:27 -0500
Received: (qmail 29708 invoked by uid 109); 2 Dec 2020 01:43:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 01:43:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2640 invoked by uid 111); 2 Dec 2020 01:43:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 20:43:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 20:43:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] MaintNotes: use https:// instead of git:// when possible
Message-ID: <X8bxUsHN8JcyEKHh@coredump.intra.peff.net>
References: <20201201094623.4290-1-avarab@gmail.com>
 <20201201095815.12850-1-avarab@gmail.com>
 <X8Yu5CephK3uvMeV@coredump.intra.peff.net>
 <xmqq360pqra2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq360pqra2.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 11:07:17AM -0800, Junio C Hamano wrote:

> > s/not/note/ in this last line?
> 
> With or without the tweak, I couldn't figure out what the paragraph
> wanted to say.  On the other hand, I didn't quite get why "friendly
> web interfaces" matters until trying to read the paragraph again to
> realize that it was talking about repository browser like gitweb and
> cgit.
> 
> I'd probably rephrase the entire proposed commit log message to
> something like:
> 
> 	Most git:// URLs listed for the copies of the Git repository
> 	have working corresponding https:// URLs that can be given
> 	to a browser to browse the repository interactively.  List
> 	https:// URL instead of git:// URL for such repositories.
> 	The former is also more secure, even though it may be more
> 	expensive.
> 
> without mentioning ozlabs at all.

Yeah, I agree that is the important part.

-Peff
