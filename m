Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A992098B
	for <e@80x24.org>; Wed, 19 Oct 2016 14:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941151AbcJSORE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 10:17:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:59394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933448AbcJSORA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:17:00 -0400
Received: (qmail 1082 invoked by uid 109); 19 Oct 2016 07:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 07:46:49 +0000
Received: (qmail 10729 invoked by uid 111); 19 Oct 2016 07:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 03:47:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 03:46:48 -0400
Date:   Wed, 19 Oct 2016 03:46:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #04; Mon, 17)
Message-ID: <20161019074648.nuk2c2mpvmedjrhb@sigill.intra.peff.net>
References: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
 <9F780406-FC77-4B3E-AEEB-7F6215E6702C@gmail.com>
 <xmqq4m49pffk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m49pffk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 01:31:27PM -0700, Junio C Hamano wrote:

> >> * ls/filter-process (2016-10-17) 14 commits
> [...]
> > what do you think about v11? Do you feel the series is becoming mature
> > enough for `next`?
> 
> I've already had that feeling a few rounds ago, but I haven't had a
> chance to read the most recent one carefully myself to answer that
> question honestly.

FWIW, I gave it a fairly thorough read-over (something I'd been meaning
to do for quite a while, but kept never quite getting around to). I
think overall it is OK for next. I did find one or two nits, but I think
they are things we can fix up in-tree if and when they become a problem
(e.g., I noticed that test-genrandom gets piped to "perl -pe". I'm not
sure if perl will complain about funny multibyte characters on some
systems. I suggest we ignore it until somebody demonstrates that it
actually matters).

-Peff
