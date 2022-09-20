Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86152C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiITUnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiITUnA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:43:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6138376954
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:42:59 -0700 (PDT)
Received: (qmail 31143 invoked by uid 109); 20 Sep 2022 20:42:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 20:42:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14836 invoked by uid 111); 20 Sep 2022 20:42:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 16:42:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 16:42:57 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t/Makefile: remove 'test-results' on 'make clean'
Message-ID: <Yyol0c2op5Z2BeK1@coredump.intra.peff.net>
References: <patch-v3-07.15-c7ea6dc013b-20220727T230800Z-avarab@gmail.com>
 <20220920105407.4700-1-szeder.dev@gmail.com>
 <YyoZsjf3FSxLuuKY@coredump.intra.peff.net>
 <20220920201150.GB1704@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920201150.GB1704@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 10:11:50PM +0200, SZEDER Gábor wrote:

> On Tue, Sep 20, 2022 at 03:51:14PM -0400, Jeff King wrote:
> > On Tue, Sep 20, 2022 at 12:54:07PM +0200, SZEDER Gábor wrote:
> > 
> > > The 't/test-results' directory and its contents are by-products of the
> > > test process, so 'make clean' should remove them, but, alas, this has
> > > been broken since ee65b194d (t/Makefile: don't remove test-results in
> > > "clean-except-prove-cache", 2022-07-28).
> > 
> > I don't have that commit.
> 
> Uh-oh.  Me neither :)
> 
> > I assume you mean fee65b194d, and what you
> > have here was a version before it hit 'next'.
> 
> Looking at the reflog, it seems that while rewording the commit
> message I inadvertently deleted the first character of the SHA1.

Heh. You'd think I would have notice the similarity when pasting in the
new one. :) But yeah, that is definitely what happened.

-Peff
