Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A08C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB7020882
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgFPOcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:32:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33344 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPOcE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:32:04 -0400
Received: (qmail 22854 invoked by uid 109); 16 Jun 2020 14:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 14:32:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13583 invoked by uid 111); 16 Jun 2020 14:32:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 10:32:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 10:32:02 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        James Ramsay <jramsay.com.au@syl.local>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616143202.GM666057@coredump.intra.peff.net>
References: <20200615205722.GG71506@syl.local>
 <CABPp-BE3UAeMKCtwnTf-5ifVhveRPzQfT1T+sHsm_LDOubCHCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE3UAeMKCtwnTf-5ifVhveRPzQfT1T+sHsm_LDOubCHCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 03:38:08PM -0700, Elijah Newren wrote:

> As I stated in the other thread[1], I'm happy 'default' isn't winning
> because I think it can lead to ambiguity about the meaning of the
> phrase "default branch" (particularly when someone changes HEAD on the
> server to point to anything other than "refs/heads/default").  I don't
> think "main branch" poses similar issues, as it's not a phrase I've
> seen used that much (in contrast to "default branch").  Also,
> "default" being ambiguous bothers me personally more than other terms
> being ambiguous, as per my story in the other thread.  However, it's
> possible that there is documentation or guides somewhere that have
> used "main branch" in the past and could become ambiguous with the
> proposed change, and thus would benefit from updates.

Thanks for writing this out (I'm still catching up on list email after a
vacation, so I missed the earlier thread). It really cemented for me
that "main" is better than "default".

-Peff
