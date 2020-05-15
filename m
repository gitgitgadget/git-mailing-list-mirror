Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313A1C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F69920709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEOW0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 18:26:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:48332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726183AbgEOW0x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 18:26:53 -0400
Received: (qmail 28542 invoked by uid 109); 15 May 2020 22:26:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 22:26:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16742 invoked by uid 111); 15 May 2020 22:26:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 18:26:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 18:26:51 -0400
From:   Jeff King <peff@peff.net>
To:     Noam Soloveichik <inoamsol@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, james@jramsay.com.au, jrnieder@gmail.com
Subject: Re: [TOPIC 9/17] Obsolescence markers and evolve
Message-ID: <20200515222651.GB116674@coredump.intra.peff.net>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <9CE46D29-4BCD-4E95-B2DA-939EA10D7934@jramsay.com.au>
 <49bf5848-b8b0-13b0-4038-352f702d11ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49bf5848-b8b0-13b0-4038-352f702d11ee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 10, 2020 at 12:31:37AM +0300, Noam Soloveichik wrote:

> On 12/03/2020 6:04, James Ramsay wrote:
> > 1. Brandon: I thought it would be interesting to have a similar feature
> > as Mercurial has. Mercurial evolve will help you do a big rebase
> > commit by commit. Giving you more insights how commits change over time.
> >
> > 2. Peff: This has been discussed a lot of time on the list already.
> Since I'm very interested in this topic, can you link me to some key
> discussions you remember? Most of what I've found is Stefan Xenos having
> a take on implementing it.

Sorry, I don't much to offer. The discussion from Stefan is the only one
I remember talking about evolve itself.

I think my comment may have been specifically about the extra graph
pointers that would be needed to represent rebases, etc. The general
concept of a parent pointer that doesn't imply reachability has come up
over the years. I don't have any links handy, though, and searching for
"parent" in the list archive is not likely to be all that helpful.

Hmm, searching for "parent" and "reachable" also turns up a lot, but
this one is probably relevant:

  https://lore.kernel.org/git/20060425035421.18382.51677.stgit@localhost.localdomain/

Something that old is as likely to hurt as help, though. ;)

-Peff
