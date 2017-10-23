Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B89202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 05:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbdJWFSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 01:18:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:60832 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750745AbdJWFSx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 01:18:53 -0400
Received: (qmail 11244 invoked by uid 109); 23 Oct 2017 05:18:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Oct 2017 05:18:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32274 invoked by uid 111); 23 Oct 2017 05:18:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Oct 2017 01:18:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Oct 2017 01:18:51 -0400
Date:   Mon, 23 Oct 2017 01:18:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v3 0/3] deprecate git stash save
Message-ID: <20171023051850.vil3p5pmu3jb2a5y@sigill.intra.peff.net>
References: <20171019183304.26748-2-t.gummerer@gmail.com>
 <20171022170409.8565-1-t.gummerer@gmail.com>
 <xmqqwp3md5jp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp3md5jp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 10:19:38AM +0900, Junio C Hamano wrote:

> > -	This option is deprecated in favour of 'git stash push'.
> > +	This option is deprecated in favour of 'git stash push'.  It
> > +	differs from "stash push" in that it cannot take pathspecs,
> > +	and any non-option arguments form the message.
> 
> Every time I saw this line, I misread s/form/from/ and got
> confused.

We could reverse the order:

   ...and the message is taken from any non-option arguments.

-Peff
