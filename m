Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA9C433E4
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58D761A02
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhCXTPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:15:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:47842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237864AbhCXTOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:14:53 -0400
Received: (qmail 14502 invoked by uid 109); 24 Mar 2021 19:14:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 19:14:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20987 invoked by uid 111); 24 Mar 2021 19:14:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 15:14:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 15:14:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 00/10] userdiff: refactor + test improvements
Message-ID: <YFuPrJUgAY3B0nRw@coredump.intra.peff.net>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <7c560336-c087-5159-06c2-5b22e949902e@kdbg.org>
 <xmqq5z1gz869.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5z1gz869.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 12:02:54PM -0700, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 24.03.21 um 02:48 schrieb Ævar Arnfjörð Bjarmason:
> >> This is a restart of the 35-patch v3 of this topic at
> >> https://lore.kernel.org/git/20210224195129.4004-1-avarab@gmail.com/
> >> 
> >> I still plan on submitting the rest of it, but wanted to start with
> >> the early parts of that series that hasn't been controversial or has
> >> outstanding feedback I haven't addressed.
> >> 
> >> The range-diff to v3 is just for those patches I'm re-rolling here.
> >
> > I'm mostly relying on the interdiff below. I think I had no comments on
> > these patches in the earlier round, so:
> >
> > Acked-by: Johannes Sixt <j6t@kdbg.org>
> 
> Thanks.  I've read through everything in the patch this round,
> ignoring anything that came before, and them looked mostly fine.
> Peff's comment on 01/10 to make it if/else if cascade does make
> sense to me, too, though.

I left some other comments on patch 4, mostly about clarity. But just to
be clear, I don't think there's anything incorrect there, and I wouldn't
be offended if it gets picked up as-is.

-Peff
