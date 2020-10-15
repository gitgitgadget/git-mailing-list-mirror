Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0D2C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75AA206D5
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391879AbgJOTqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:46:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33450 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391865AbgJOTqt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:46:49 -0400
Received: (qmail 24308 invoked by uid 109); 15 Oct 2020 19:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:46:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32491 invoked by uid 111); 15 Oct 2020 19:46:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:46:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:46:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
Message-ID: <20201015194648.GB1490964@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
 <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 09:20:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Oct 13, 2020 at 07:19:44PM +0000, Elijah Newren via GitGitGadget wrote:
> >
> >> Many of our test scripts have several "setup" tests.  It's a lot easier
> >> to say
> >> 
> >>    ./t0050-filesystem.sh --run=setup,9
> >
> > I like this direction very well.
> >
> > There was a small discussion recently that we might be better off
> > dropping test script numbers entirely,...
> 
> I think I missed that one.  A pointer, if you have one handy?

The sub-thread between me and Jonathan starting here:

  https://lore.kernel.org/git/20201005082448.GB2862927@coredump.intra.peff.net/

but specifically:

  https://lore.kernel.org/git/20201005084946.GE2862927@coredump.intra.peff.net/

-Peff
