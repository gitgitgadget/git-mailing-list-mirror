Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540EB207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 03:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978497AbdDYDjP (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 23:39:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:39520 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S978268AbdDYDjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 23:39:14 -0400
Received: (qmail 17637 invoked by uid 109); 25 Apr 2017 03:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 03:39:10 +0000
Received: (qmail 3770 invoked by uid 111); 25 Apr 2017 03:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 23:39:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 23:39:08 -0400
Date:   Mon, 24 Apr 2017 23:39:08 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Submodule/contents conflict
Message-ID: <20170425033907.klufatsa7afcnfuu@sigill.intra.peff.net>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
 <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
 <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
 <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
 <20170425032242.wlmqrkgkeg3ytfle@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170425032242.wlmqrkgkeg3ytfle@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 11:22:42PM -0400, Jeff King wrote:

> > > It also has a similarity to
> > > https://public-inbox.org/git/1492287435.14812.2.camel@gmail.com/  regarding
> > > how checkout operates.
> 
> I didn't look too deeply into this one, but it really looks like
> somebody caring too much about when git needs to write (and I'd suspect
> it's impacted by the racy-git thing, too).

Oh, sorry, I got this confused with:

  https://public-inbox.org/git/CAM1zWBtfgHT=pT0pidQo1HD=DfrXLG3gNaUvs0vZKvYfG1BHFw@mail.gmail.com/

which was mentioned earlier (and which I do think is just about
timestamps).

I don't think any of what I said is related to the doc update in

  https://public-inbox.org/git/1492287435.14812.2.camel@gmail.com/

which seems reasonable to me.

-Peff
