Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594AD1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 22:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeFKWaE (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 18:30:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:41940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751968AbeFKWaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 18:30:03 -0400
Received: (qmail 18391 invoked by uid 109); 11 Jun 2018 22:30:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 22:30:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19221 invoked by uid 111); 11 Jun 2018 22:30:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 18:30:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 18:30:01 -0400
Date:   Mon, 11 Jun 2018 18:30:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2018, #02; Mon, 4)
Message-ID: <20180611223000.GA29549@sigill.intra.peff.net>
References: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
 <20180604141230.GA26961@sigill.intra.peff.net>
 <xmqqmuw1asd1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuw1asd1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 03:08:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Jun 04, 2018 at 10:57:30PM +0900, Junio C Hamano wrote:
> >
> >> * jk/index-pack-maint (2018-06-01) 2 commits
> >>   (merged to 'next' on 2018-06-04 at c553a485e8)
> >>  + index-pack: handle --strict checks of non-repo packs
> >>  + prepare_commit_graft: treat non-repository as a noop
> >> 
> >>  "index-pack --strict" has been taught to make sure that it runs the
> >>  final object integrity checks after making the freshly indexed
> >>  packfile available to itself.
> >> 
> >>  Will cook in 'next'.
> >
> > This second patch fixes a regression in v2.18.0-rc1 and in v2.17.1. I
> > don't know if we'd want to consider it for v2.18 or not (it should be
> > able to be applied independently from the first).
> 
> I gave the topic -maint suffix, but I'd need a little fix-up patch
> on top to actually make it mergeable to the maintenance track.  With
> that, let's merge it to 'master' before v2.18 final happens and then
> also to 'maint'.

Thanks, your fixup looks good.

-Peff
