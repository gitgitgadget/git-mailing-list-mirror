Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE82207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 12:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbcI2Mwn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 08:52:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:49878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbcI2Mwl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 08:52:41 -0400
Received: (qmail 25375 invoked by uid 109); 29 Sep 2016 12:52:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 12:52:40 +0000
Received: (qmail 1228 invoked by uid 111); 29 Sep 2016 12:52:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 08:52:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 08:52:38 -0400
Date:   Thu, 29 Sep 2016 08:52:38 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git log --oneline alternative with dates, times and
 initials
Message-ID: <20160929125238.hifkxe7cmyebg64u@sigill.intra.peff.net>
References: <git-log-times@mackyle-at-gmail-com>
 <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
 <82EE6519-E58F-4382-87A5-55D9D1BBDCA9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82EE6519-E58F-4382-87A5-55D9D1BBDCA9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 04:00:06AM -0700, Kyle J. McKay wrote:

> > Each of those commits[1] needs some minor polish, and as I'm not really
> > that interested in fancy log output myself, I don't plan on working on
> > them further. I was mostly curious just how close we were. But if you'd
> > like to pursue it, feel free to use them as a starting point.
> 
> Those patches are missing some of the features like showing root commits,
> handling two letter initials, showing the weekday, inserting a break where
> needed to avoid parent-child confusion in graph output and properly handling
> Duy's initials. :)

I'm not too surprised. I literally looked at the first screenshot from
your output and thought "surely git can do that with some minor tweaks".
Nor am I surprised that there are cases where the output is funny (99%
of the time I spent on it was tracking down that graph-padding bug).

I have no problem taking this in contrib or whatever, until a point when
Git is capable of doing the same thing itself. I just hoped to trick you
into working on Git. :)

-Peff
