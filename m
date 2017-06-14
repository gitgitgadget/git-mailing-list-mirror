Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8591FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 06:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdFNGFF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 02:05:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:39715 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbdFNGFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 02:05:04 -0400
Received: (qmail 901 invoked by uid 109); 14 Jun 2017 06:05:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:05:05 +0000
Received: (qmail 8601 invoked by uid 111); 14 Jun 2017 06:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 02:05:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 02:05:02 -0400
Date:   Wed, 14 Jun 2017 02:05:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand aliases
Message-ID: <20170614060502.ljuvdxcbara3zfjx@sigill.intra.peff.net>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
 <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
 <xmqqk24f97ud.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk24f97ud.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 09:21:30AM -0700, Junio C Hamano wrote:

> >  alias.c          | 31 ++++++++++++++++++++++++-------
> >  git.c            | 55 ++++---------------------------------------------------
> >  t/t7006-pager.sh |  2 +-
> >  3 files changed, 29 insertions(+), 59 deletions(-)
> 
> Happy to see the deletion of all the save/restore-env stuff.
> 
> Except for the puzzlement in one paragraph in the log, looks very
> good.  Thanks for a pleasant reading.

The whole thing looks good to me, too, though we should decide what to
do with the point that Brandon raised.

As far as the "streamline" puzzlement goes, I'm OK with either of:

  - taking your suggestion from the other thread and actually doing that
    streamlining, which is one less thing to have to explain

  - leaving the code as-is and tweaking the commit message (though it
    made sense to me)

-Peff
