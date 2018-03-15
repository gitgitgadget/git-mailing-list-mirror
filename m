Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D401F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCOQZF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:25:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:58080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750987AbeCOQZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:25:00 -0400
Received: (qmail 30934 invoked by uid 109); 15 Mar 2018 16:25:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Mar 2018 16:25:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16420 invoked by uid 111); 15 Mar 2018 16:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Mar 2018 12:25:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2018 12:24:58 -0400
Date:   Thu, 15 Mar 2018 12:24:58 -0400
From:   Jeff King <peff@peff.net>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
Message-ID: <20180315162457.GA31351@sigill.intra.peff.net>
References: <20180315130359.6108-1-michele@locati.it>
 <20180315141220.GB27748@sigill.intra.peff.net>
 <xmqqa7v973b5.fsf@gitster-ct.c.googlers.com>
 <20180315154815.GA29874@sigill.intra.peff.net>
 <xmqq605x72qs.fsf@gitster-ct.c.googlers.com>
 <CAGen01hodC=z_74z+7fSSrx2kvPnSbOQaML9kBb9iO6xCvWHQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGen01hodC=z_74z+7fSSrx2kvPnSbOQaML9kBb9iO6xCvWHQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 05:18:59PM +0100, Michele Locati wrote:

> Great! So, I'm ready to update the patch, including the doc changes,
> which will be
> the one suggested by Jeff:
> [...]

Sounds good.

> And yes, I'm a brand new contributor, so here's my question: how should I
> send an updated patch? I can't find anything related to this in
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches

Usually you'd just send it in reply to the original thread with "[PATCH
v2]" instead of just "[PATCH]" in the subject line.  If you're using
format-patch or send-email, you should be able to just add "-v2" (and
--in-reply-to if you want to join the existing thread).

I thought SubmittingPatches discussed patch "re-rolls" like this, but I
don't see any mention of it from a quick grep.

-Peff
