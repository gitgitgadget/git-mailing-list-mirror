Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B798201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 07:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbdBTH6B (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 02:58:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:58604 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdBTH6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 02:58:00 -0500
Received: (qmail 6638 invoked by uid 109); 20 Feb 2017 07:57:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 07:57:44 +0000
Received: (qmail 14264 invoked by uid 111); 20 Feb 2017 07:57:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 02:57:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 02:57:42 -0500
Date:   Mon, 20 Feb 2017 02:57:42 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/6] stash: support pathspec argument
Message-ID: <20170220075742.6a2irsjlukobnju4@sigill.intra.peff.net>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 11:03:07AM +0000, Thomas Gummerer wrote:

> Thanks Junio and Peff for comments on the last round.
> 
> Changes since then:
> 
> - removed mention of the "new form" of git stash create from the
>   Documentation.
> - Changed documentation for git stash without a verb, mentioning
>   stash -p now being an alias for git stash push -p and that -- can be
>   used as disambiguation for for pathspecs
> - Fixed ${1-...} which should have been ${1?...}
> - Removed unused new_style variable from create_stash, which was a
>   leftover from perious rounds.

I gave it one more read-through, and didn't see anything objectionable.
Thanks for seeing this through!

-Peff
