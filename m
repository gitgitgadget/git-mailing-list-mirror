Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023F1207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbcI2SaK (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:30:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:50031 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754095AbcI2SaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:30:09 -0400
Received: (qmail 11624 invoked by uid 109); 29 Sep 2016 18:30:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 18:30:08 +0000
Received: (qmail 3430 invoked by uid 111); 29 Sep 2016 18:30:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 14:30:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 14:30:06 -0400
Date:   Thu, 29 Sep 2016 14:30:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git log --oneline alternative with dates, times and
 initials
Message-ID: <20160929183006.exyaikr4ijiq5tp3@sigill.intra.peff.net>
References: <git-log-times@mackyle-at-gmail-com>
 <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
 <82EE6519-E58F-4382-87A5-55D9D1BBDCA9@gmail.com>
 <20160929125238.hifkxe7cmyebg64u@sigill.intra.peff.net>
 <xmqqy42afvy1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy42afvy1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 10:38:14AM -0700, Junio C Hamano wrote:

> > I have no problem taking this in contrib or whatever, until a point when
> > Git is capable of doing the same thing itself. I just hoped to trick you
> > into working on Git. :)
> 
> I thought we stopped adding random things to contrib/, though.
> 
> Unlike the earlier days of Git, if a custom command that uses Git is
> very userful, it can live its own life and flourish within the much
> larger Git userbase we have these days.

I dunno. I said "contrib or whatever" to duck that question. :)

I do not have a strong opinion either way. In some ways this script is
similar to diff-highlight, which is in contrib. Perhaps that is only
because diff-highlight is grandfathered. But I also think it somewhat
makes sense, because in an ideal world diff-highlight gets thrown away
in favor of git's internal diff routines learning to do the same thing.
And in theory this script is in the same position.

But I also buy the argument that contrib/ is simply a hassle. This
script can live in its own repository somewhere, and handle
announcements and patches on the list. For that matter, so could
diff-highlight, and I don't mind ripping it out of contrib if that's the
consensus.  My only real objection is that doing so is more work than
leaving it as-is, and I'm lazy.

-Peff
