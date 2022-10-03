Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24982C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 17:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJCRQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiJCRPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 13:15:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B56220F0
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 10:15:35 -0700 (PDT)
Received: (qmail 32360 invoked by uid 109); 3 Oct 2022 17:15:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Oct 2022 17:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27022 invoked by uid 111); 3 Oct 2022 17:15:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Oct 2022 13:15:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Oct 2022 13:15:33 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     "Michael V. Scovetta" <michael.scovetta@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
Message-ID: <YzsYtXr6QM7LpExV@coredump.intra.peff.net>
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
 <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
 <f0a5abe5-761d-4c92-68df-cfd26a414c23@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0a5abe5-761d-4c92-68df-cfd26a414c23@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 10:29:24AM +0100, Phillip Wood wrote:

> > The bug goes back to 442c36bd08 (am: improve author-script error
> > reporting, 2018-10-31), though the code was soon after moved to this
> > spot by bcd33ec25f (add read_author_script() to libgit, 2018-10-31).
> > It was presmably just a typo in 442c36bd08.
> 
> s/presmbly/presumably/

Yep.

> > We'll add test coverage for all the error cases here, though only the
> > GIT_AUTHOR_NAME ones fail (even in a vanilla build they to segfault
> 
> Do you mean "they ought to segfault"?

I think it's just s/to//. I.e., "even in a vanilla build they segfault
consistently".

I rewrote that sentence a few times trying to make it as not-confusing
as possible, but managed to leave in an editing error anyway. ;)

-Peff
