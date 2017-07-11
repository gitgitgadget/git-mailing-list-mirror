Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F2320357
	for <e@80x24.org>; Tue, 11 Jul 2017 09:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbdGKJLL (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 05:11:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:36742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751052AbdGKJLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 05:11:10 -0400
Received: (qmail 32032 invoked by uid 109); 11 Jul 2017 09:11:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 09:11:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14320 invoked by uid 111); 11 Jul 2017 09:11:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 05:11:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 05:11:08 -0400
Date:   Tue, 11 Jul 2017 05:11:08 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
Message-ID: <20170711091108.3qj35d4yk5el5xxa@sigill.intra.peff.net>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
 <99EB15B6-CAA1-4C78-88B6-C934C8FBD8F8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99EB15B6-CAA1-4C78-88B6-C934C8FBD8F8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 10:28:08AM +0200, Lars Schneider wrote:

> > On 11 Jul 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > * ls/filter-process-delayed (2017-06-30) 7 commits
> >  (merged to 'next' on 2017-07-05 at a35e644082)
> > + convert: add "status=delayed" to filter process protocol
> > + convert: refactor capabilities negotiation
> > + convert: move multiple file filter error handling to separate function
> > + convert: put the flags field before the flag itself for consistent style
> > + t0021: write "OUT <size>" only on success
> > + t0021: make debug log file name configurable
> > + t0021: keep filter log files on comparison
> > 
> > The filter-process interface learned to allow a process with long
> > latency give a "delayed" response.
> > 
> > Will merge to 'master'.
> 
> Hi Junio,
> 
> can you already tell if this topic has still a chance to be part of 2.14?

I'm not Junio, but we should be able to reason it out. :)

It's marked as "will merge to master", which typically means it will
happen during the next integration cycle (i.e., within a few days when
the next "What's cooking" is written).

Since 2.14 will be cut from the tip of master in a few weeks, once it's
merged it will definitely be in 2.14 (barring a revert, of course).

This holds true during release freeze, too. Anything that makes it to
master is part of the release. The stopping point there is that things
stop getting marked as "will merge to master".

-Peff
