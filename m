Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE87C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiITTzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiITTzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 15:55:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657B6422F0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:55:47 -0700 (PDT)
Received: (qmail 30907 invoked by uid 109); 20 Sep 2022 19:55:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Sep 2022 19:55:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14381 invoked by uid 111); 20 Sep 2022 19:55:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Sep 2022 15:55:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Sep 2022 15:55:46 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] gc: don't translate literal commands
Message-ID: <Yyoawl2UyU/kEX+j@coredump.intra.peff.net>
References: <20220920050725.326383-1-alexhenrie24@gmail.com>
 <YyoPXmNGAvl6p+C2@coredump.intra.peff.net>
 <CAMMLpeRCHbp0OgsXOoMhJcUjS=sUCDJmcA=S1_dbd6Vk31C3+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMMLpeRCHbp0OgsXOoMhJcUjS=sUCDJmcA=S1_dbd6Vk31C3+w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 01:43:56PM -0600, Alex Henrie wrote:

> > So maybe something like:
> >
> >   There are no human-readable parts of these strings; the command you
> >   type is still "git maintenance" even in other languages.
> 
> By "placeholders" I mean "things in angle brackets", like some of the
> other usage strings in this file have. Maybe "argument placeholders"
> would be more clear. I like that term a little better than the term
> "human-readable parts" because these strings are part of the user
> interface, so humans have to read them. But I really don't care
> whether there's any explanation in the commit message at all. Junio
> could just drop the sentence altogether when he commits the patch.

Yeah. It was mostly that the term actively misled me. ;) Just the
subject (with "literal command") would probably be enough in this case.

-Peff
