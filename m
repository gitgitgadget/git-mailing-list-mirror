Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79A720229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbcKAVuz (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:50:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:37256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752219AbcKAVuz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:50:55 -0400
Received: (qmail 28557 invoked by uid 109); 1 Nov 2016 21:50:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 21:50:54 +0000
Received: (qmail 30567 invoked by uid 111); 1 Nov 2016 21:51:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 17:51:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2016 17:50:52 -0400
Date:   Tue, 1 Nov 2016 17:50:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
Message-ID: <20161101215052.3yallsyvqvx6wcu2@sigill.intra.peff.net>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
 <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
 <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
 <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
 <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com>
 <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
 <xmqqvaw6nac0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaw6nac0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2016 at 02:45:19PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > And here is _with_ renaming.  I think "compaction heuristics" is a
> > much better phrase to call "heuristics used during the diff hunk
> > compaction process" without specifying how that heuristics work
> > (like taking hints in the indentation levels).  If we are to retire
> > one while keeping the other, compaction-heuristics should be the
> > name we give and keep for the surviving one.
> >
> > I have not much confidence in the conversion result, though.
> 
> I'll queue it on 'pu' for now, before I go offline for a few days,
> with the following log message:

Thanks. I think this is good, with the exception of the "One of these"
bits that remains in diff-config.txt.

I think Michael is OK with this approach based on previous discussions,
but we should get his Ack, too.

-Peff
