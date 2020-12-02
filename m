Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4BC64E7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C105721D7E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgLBBpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:45:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:48164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgLBBpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 20:45:09 -0500
Received: (qmail 29714 invoked by uid 109); 2 Dec 2020 01:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 01:44:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2645 invoked by uid 111); 2 Dec 2020 01:44:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 20:44:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 20:44:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cook: add github.com/git-vcs/git as a URL
Message-ID: <X8bxfGP0b6v3rM9/@coredump.intra.peff.net>
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
 <20201201094623.4290-1-avarab@gmail.com>
 <X8Ytbbvp7SjrN2g5@coredump.intra.peff.net>
 <xmqqy2ihpck7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2ihpck7.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 11:10:32AM -0800, Junio C Hamano wrote:

> > Would you want to get the maintainer to also push to it as part of the
> > regular push-out, so there is never any mirror lag?
> 
> The maintainer does not want to push to more repositories than he
> currently does.  I think the one at googlesource.com is a mere
> mirror out of k.org and not something I push directly into.

That's fair. I definitely don't want to create more work for you. My
only concern would be if the mirror is lagged, etc; but you covered all
of that and more in your other response, so I can shut up now. :)

-Peff
