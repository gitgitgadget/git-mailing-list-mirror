Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E301F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 21:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756892AbcHXVrG (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 17:47:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60785 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756845AbcHXVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 17:47:05 -0400
Received: (qmail 28056 invoked by uid 109); 24 Aug 2016 21:39:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 21:39:38 +0000
Received: (qmail 7272 invoked by uid 111); 24 Aug 2016 21:39:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 17:39:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 17:39:34 -0400
Date:   Wed, 24 Aug 2016 17:39:34 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: diff <commit> using 3-dot behavior
Message-ID: <20160824213934.vyfikgj5cccku57z@sigill.intra.peff.net>
References: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
 <xmqqbn0irvan.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpv--eA8rdgwGLRCucSpVD5X9LjiN3_3Oo9o4L0t5Uk9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpv--eA8rdgwGLRCucSpVD5X9LjiN3_3Oo9o4L0t5Uk9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 01:48:30PM -0700, Jacob Keller wrote:

> On Wed, Aug 24, 2016 at 9:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > The merge-base is to compute the point you forked your topic from
> > the mainline.  So if you want to compare your current state in the
> > index with the fork point, you'd do
> >
> >         git diff --cached $(git merge-base master topic)
> >
> > and comparing your working tree state would be
> >
> >         git diff --cached $(git merge-base master topic)
> >
> 
> Those are both identical?

I imagine the second one just meant to drop "--cached".

-Peff
