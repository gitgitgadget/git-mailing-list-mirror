Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A9C388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB26920782
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKFCsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:48:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:49698 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgKFCsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 21:48:37 -0500
Received: (qmail 18204 invoked by uid 109); 6 Nov 2020 02:48:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Nov 2020 02:48:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30358 invoked by uid 111); 6 Nov 2020 02:48:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Nov 2020 21:48:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Nov 2020 21:48:35 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 00/15] Add struct strmap and associated utility
 functions
Message-ID: <20201106024835.GA153035@coredump.intra.peff.net>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
 <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
 <xmqq5z6jgs6f.fsf@gitster.c.googlers.com>
 <CABPp-BHoaqGRbfM=5SZ4+s1hQa9eRQsi4kMAb3cZFrP+dqHM0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHoaqGRbfM=5SZ4+s1hQa9eRQsi4kMAb3cZFrP+dqHM0A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 05, 2020 at 06:42:38PM -0800, Elijah Newren wrote:

> > > Changes since v4:
> > > ...
> > >  * Add a patch which updates shortlog to use the new strset API.
> >
> > This makes my life so much simpler ;-)
> >
> > Would the implementation be very different from Peff's that you can
> > take the authorship?  Thanks.
> 
> Yes; I didn't use his patch, I simply implemented what was needed from
> scratch.  I'm not attached to being author of this though; the changes
> were trivial.  Feel free to change as you see fit.

Yeah, I am fine either way with the authorship here. The patch is
trivial, and I was pretty sure you had written the same or similar
already. My main point in posting it was to push it over the finish line
so we didn't forget. ;)

-Peff
