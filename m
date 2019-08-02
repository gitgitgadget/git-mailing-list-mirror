Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06511F731
	for <e@80x24.org>; Fri,  2 Aug 2019 18:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405915AbfHBSfb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 14:35:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:60700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2405370AbfHBSfa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 14:35:30 -0400
Received: (qmail 10769 invoked by uid 109); 2 Aug 2019 18:35:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Aug 2019 18:35:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9103 invoked by uid 111); 2 Aug 2019 18:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Aug 2019 14:37:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Aug 2019 14:35:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190802183529.GA26918@sigill.intra.peff.net>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
 <20190801002125.GA176307@google.com>
 <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
 <20190802022709.GB54514@google.com>
 <xmqqblx7ld98.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblx7ld98.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 02, 2019 at 09:53:55AM -0700, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > We'll also want to update the docs.  And as Todd suggests, we should
> > cover how to disable mailmap in tests.
> >
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > ---
> 
> I avoided the "don't bother initializing use_mailmap_config to
> unknown" simplification, but I guess the change is clear enough.

Yeah, I didn't even look to see if there were further simplifications
possible, but seeing Jonathan's patch, it looks like an obvious
improvement. And a quick grep shows that there are no other sites that
should be affected by losing the "-1" semantics, so I think it's a good
idea.

And of course the doc and test improvements are very welcome. :)

-Peff
