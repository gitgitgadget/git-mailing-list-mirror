Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FCEC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F2421D6C
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbgJIR7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 13:59:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbgJIR7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 13:59:19 -0400
Received: (qmail 9183 invoked by uid 109); 9 Oct 2020 17:59:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Oct 2020 17:59:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4604 invoked by uid 111); 9 Oct 2020 17:59:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Oct 2020 13:59:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Oct 2020 13:59:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Webster <chris@webstech.net>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
Message-ID: <20201009175917.GA963340@coredump.intra.peff.net>
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
 <20200922170745.GA541915@coredump.intra.peff.net>
 <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
 <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
 <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet>
 <xmqqtuv3tlkv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuv3tlkv.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 09:23:28AM -0700, Junio C Hamano wrote:

> I think this is exactly the use case that
> 
>     After the list reached a consensus that it is a good idea to apply the
>     patch, re-send it with "To:" set to the maintainer{current-maintainer}
>     and "cc:" the list{git-ml} for inclusion.
> 
> in Documentation/SubmittingPatches was written to address.
> 
> I usually pay attention to majority of topics and have them on my
> radar by getting involved in _some_ way in the discussion thread, so
> I often know when the patch(es) matured enough to be picked up
> without such a "this is the version after our discussion and it is
> as close to perfect as we can possibly make" resend.
> 
> But for some topics, I have no strong opinion on the exact shape of
> the final patch(es), and/or I have no expertise to offer to help the
> discussion to reach the final product.  In such a case, I'd be just
> waiting, without getting involved in the discussion, for trusted
> others to bring the posted patch to a completed form.  I think this
> is such a case.

As the other person in the discussion, I'm sufficiently convinced that
doing this just for PRs is a good step for now. I.e., I think the
"completed form" is just what was posted already (though I agree it is
often convenient to the maintainer to re-post the patch as part of the
ping).

-Peff
