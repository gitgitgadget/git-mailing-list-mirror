Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52364C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285612070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfK0Mwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:52:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:33832 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726282AbfK0Mwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:52:32 -0500
Received: (qmail 11042 invoked by uid 109); 27 Nov 2019 12:52:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 12:52:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9810 invoked by uid 111); 27 Nov 2019 12:56:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 07:56:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 07:52:31 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: This list is now also archived on lore.kernel.org/git
Message-ID: <20191127125231.GH22221@sigill.intra.peff.net>
References: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 10:43:47AM -0500, Konstantin Ryabitsev wrote:

> I used Eric's public-inbox.org archives to set up our own copy on 
> lore.kernel.org and identical list archives are now available on that 
> server.
> 
> I spoke with Eric and he recommends that official project documentation 
> starts using lore.kernel.org/git URLs in daily use and git's official 
> documentation in order to allow him more freedom of decision when it 
> comes to hosting his equipment. The URLs at both domains remain the 
> same, e.g.:
> 
> - https://public-inbox.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/
> - https://lore.kernel.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/

Thank you for setting this up (and thank you Eric for the public-inbox
code and service; it's _so_ much nicer than the previous alternatives).

It sounds like we should do something like the series below.

  [1/2]: doc: recommend lore.kernel.org over public-inbox.org
  [2/2]: doc: replace public-inbox links with lore.kernel.org

 Documentation/MyFirstContribution.txt              |  2 +-
 Documentation/git-bisect-lk2009.txt                |  2 +-
 Documentation/git.txt                              |  2 +-
 Documentation/technical/commit-graph.txt           | 10 +++++-----
 .../technical/hash-function-transition.txt         | 14 +++++++-------
 Documentation/technical/multi-pack-index.txt       |  4 ++--
 Documentation/technical/partial-clone.txt          | 12 ++++++------
 README.md                                          |  2 +-
 apply.c                                            |  2 +-
 sha1dc/sha1.c                                      |  2 +-
 t/t0021-conversion.sh                              |  4 ++--
 t/t4038-diff-combined.sh                           |  2 +-
 tree-walk.c                                        |  2 +-
 13 files changed, 30 insertions(+), 30 deletions(-)

-Peff
