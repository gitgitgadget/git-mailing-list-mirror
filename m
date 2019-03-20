Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA17F20248
	for <e@80x24.org>; Wed, 20 Mar 2019 05:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCTFJs (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 01:09:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:57330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725986AbfCTFJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 01:09:46 -0400
Received: (qmail 18684 invoked by uid 109); 20 Mar 2019 05:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 05:09:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5317 invoked by uid 111); 20 Mar 2019 05:10:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 01:10:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 01:09:44 -0400
Date:   Wed, 20 Mar 2019 01:09:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m
 1' is specified
Message-ID: <20190320050944.GB6401@sigill.intra.peff.net>
References: <87efh0pdln.fsf@javad.com>
 <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
 <8736nj2jcl.fsf@javad.com>
 <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 09:38:57AM +0900, Junio C Hamano wrote:

> "git log -p --first-parent" that requires "-m" to show the single
> ball of wax diff for a merge is a separate matter.  When the user
> explicitly says "log --first-parent", it is a clear indication that
> the user does not want to see individual steps of how side branches
> built what each merge brings into the mainline.  From that point of
> view, ever sice I introduced "--first-parent" traversal, I've been
> wondering what the true downside would be if we turned "-m" on
> automatically when these two options are used without "-m".

Sort of a drive-by two cents, but I have often wondered the same thing.
I cannot think of a time when I wanted "--first-parent" without "-m"
(unless I was not viewing diffs at all).

(And I agree with everything else you said :) ).

-Peff
