Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7E6C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92492076A
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgI3Wew (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:34:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:46038 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbgI3Wew (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:34:52 -0400
Received: (qmail 26771 invoked by uid 109); 30 Sep 2020 22:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 22:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1131 invoked by uid 111); 30 Sep 2020 22:34:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 18:34:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 18:34:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/5] Inclusive naming, part II
Message-ID: <20200930223451.GA1908000@coredump.intra.peff.net>
References: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
 <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
 <xmqqimbugb3l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimbugb3l.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 03:21:02PM -0700, Junio C Hamano wrote:

> > Changes since v2:
> >
> >  * Extended the idea of using topic instead of main to patch 4/5.
> >  * Explained in the commit message of patch 5/5 why we cannot use topic 
> >    instead of main here.
> 
> This round hasn't seen any new comments.  I quickly scanned them one
> more time, and it seems to be in good shape.
> 
> Shall we merge it down to 'next'?

I had an "all of v3 looks good to me" comment, but it was perhaps a bit
buried. So yes, I think this is ready for 'next'.

-Peff
