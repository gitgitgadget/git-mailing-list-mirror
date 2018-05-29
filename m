Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203D61F42D
	for <e@80x24.org>; Tue, 29 May 2018 16:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964951AbeE2QtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 12:49:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:55390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935486AbeE2QtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 12:49:14 -0400
Received: (qmail 24608 invoked by uid 109); 29 May 2018 16:49:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 16:49:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27808 invoked by uid 111); 29 May 2018 16:49:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 12:49:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 12:49:12 -0400
Date:   Tue, 29 May 2018 12:49:12 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/empty-config-section-fix, was Re: What's cooking in git.git
 (May 2018, #03; Wed, 23)
Message-ID: <20180529164912.GA13385@sigill.intra.peff.net>
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1805251430420.77@tvgsbejvaqbjf.bet>
 <xmqq36ycl4ly.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1805281319530.82@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1805281319530.82@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 01:20:41PM +0200, Johannes Schindelin wrote:

> On Mon, 28 May 2018, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Thu, 24 May 2018, Junio C Hamano wrote:
> > >
> > >> * js/empty-config-section-fix (2018-05-18) 1 commit
> > >>  - config: a user-provided invalid section is not a BUG
> > >> 
> > >>  Error codepath fix.
> > >> 
> > >>  Will merge to 'next'.
> > >
> > > As a hotfix, maybe we can fast-track it to master?
> > 
> > Hotfix is a proposed fix for an issue that is so important to be a
> > showstopper.  This one must be fixed before the final release, but I
> > do not think it's not that urgent to force us to drop everything
> > else and merge it to master immediately.
> 
> Well, in this case, a user might report a BUG when they simply have an
> invalid config.
> 
> I do not care all that much, but Peff (who reported this) might.

I think it's fine to just fix it before release. Both the likelihood of
it happening and its severity are pretty low.

-Peff
