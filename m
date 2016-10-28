Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7392035F
	for <e@80x24.org>; Fri, 28 Oct 2016 23:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965925AbcJ1XUL (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 19:20:11 -0400
Received: from stcim.de ([78.46.73.102]:55737 "EHLO stcim"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965235AbcJ1XUK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 19:20:10 -0400
Received: from [62.91.100.6] (helo=sill.h.stcim.de)
        by stcim with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <contact@stefanchrist.eu>)
        id 1c0GQZ-0003jg-5w; Sat, 29 Oct 2016 01:19:11 +0200
Date:   Sat, 29 Oct 2016 01:19:09 +0200
From:   Stefan Christ <contact@stefanchrist.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Documenation: fmt-merge-msg: fix markup in example
Message-ID: <20161028231909.GA697@sill.h.stcim.de>
References: <1477648886-12096-1-git-send-email-contact@stefanchrist.eu>
 <20161028110820.a46ttxjicq2k5xdk@sigill.intra.peff.net>
 <xmqq4m3w33o2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m3w33o2.fsf@gitster.mtv.corp.google.com>
X-PGP-Key: http://stefanchrist.eu/personal/Stefan%20Christ.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

On Fri, Oct 28, 2016 at 08:15:57AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Oct 28, 2016 at 12:01:26PM +0200, Stefan Christ wrote:
> >
> >> diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
> >> index 6526b17..44892c4 100644
> >> --- a/Documentation/git-fmt-merge-msg.txt
> >> +++ b/Documentation/git-fmt-merge-msg.txt
> >> @@ -60,10 +60,10 @@ merge.summary::
> >>  EXAMPLE
> >>  -------
> >>  
> >> ---
> >> +---------
> >>  $ git fetch origin master
> >>  $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
> >> ---
> >> +---------
> >
> > Thanks. Asciidoc generally requires at least 4 delimiter characters to
> > open a delimited block (including a ListingBlock, which is what we want
> > here). There is one exception, "--", which is a generic OpenBlock, which
> > is just used for grouping, and not any special syntactic meaning (so
> > that's why this _didn't_ render the "--", but did render the contents
> > without line breaks).
> >
> > So looks good, modulo the typo in the subject that somebody else pointed
> > out.
> 
> Thanks, both.  I queued with a bit more enhanced log message while
> fixing the typo.
> 

I'm totally ok with these changes. Thanks.

Kind Regards,
	Stefan Christ
