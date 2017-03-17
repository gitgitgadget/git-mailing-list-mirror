Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7A32095B
	for <e@80x24.org>; Fri, 17 Mar 2017 11:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbdCQLYG (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 07:24:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:45819 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdCQLYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 07:24:06 -0400
Received: (qmail 22146 invoked by uid 109); 17 Mar 2017 11:22:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 11:22:32 +0000
Received: (qmail 15417 invoked by uid 111); 17 Mar 2017 11:22:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 07:22:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 07:22:29 -0400
Date:   Fri, 17 Mar 2017 07:22:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Re-integrate sha1dc
Message-ID: <20170317112228.rvqddumn5zairmh3@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
 <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
 <20170316221044.ij5yuifmohktn6cl@sigill.intra.peff.net>
 <xmqq37ecc134.fsf@gitster.mtv.corp.google.com>
 <20170317001416.bthqvjbf554zhrj5@sigill.intra.peff.net>
 <xmqqlgs4a35n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgs4a35n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 10:22:12PM -0700, Junio C Hamano wrote:

> My .travis.yml suggestion was about testing with SHA1DC in
> preparation for making it the default.  That would give us another
> incentive to keep an eye on its performance, too, before we make it
> the default in Makefile, at which time the forced selection in the
> travis configuration can be removed.

Yeah, I'm not opposed to that, though it requires somebody actually
paying attention to the timings differences. I'm not sure we can do that
automatically on Travis.

-Peff
