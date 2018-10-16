Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SUSPICIOUS_RECIPS shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD0F1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPXTb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:19:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:42312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726978AbeJPXTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:19:31 -0400
Received: (qmail 7262 invoked by uid 109); 16 Oct 2018 15:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 16 Oct 2018 15:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11007 invoked by uid 111); 16 Oct 2018 15:27:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Oct 2018 11:27:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2018 11:28:31 -0400
Date:   Tue, 16 Oct 2018 11:28:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brendan Forster via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Brendan Forster <github@brendanforster.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation
 checks in cURL
Message-ID: <20181016152831.GA29432@sigill.intra.peff.net>
References: <pull.46.git.gitgitgadget@gmail.com>
 <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
 <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com>
 <20181016063323.GA25933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1810161424390.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810161424390.4546@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 02:25:57PM +0200, Johannes Schindelin wrote:

> > > That ">=" is hard to grok.  I think you meant it to be pronounced
> > > "requries at least", but that is not a common reading.  People more
> > > commonly pronounce it "is greater than or equal to".
> > 
> > This seemed oddly familiar:
> > 
> >   https://public-inbox.org/git/8da9d436-88b9-7959-dd9c-65bdd376bf54@mail.mipt.ru/
> > 
> > Since this one is clearly copied from there, it may be worth fixing the
> > original.
> 
> Good memory. I just integrated the patch here. It was not signed off, but
> it is too obvious to be protected under copyright, so I re-did it, adding
> a nice commit message.

Yay, thank you (I considered doing the same, but was scratching my head
over how to deal with authorship and signoff).

-Peff
