Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5171C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA072080C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgDCTgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:36:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:32782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726460AbgDCTgp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:36:45 -0400
Received: (qmail 30306 invoked by uid 109); 3 Apr 2020 19:36:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 19:36:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22666 invoked by uid 111); 3 Apr 2020 19:46:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 15:46:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 15:36:44 -0400
From:   Jeff King <peff@peff.net>
To:     Josep Torra <n770galaxy@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible regression in git 2.26.0
Message-ID: <20200403193644.GA662633@coredump.intra.peff.net>
References: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
 <20200403185804.GA659704@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403185804.GA659704@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 02:58:04PM -0400, Jeff King wrote:

> Do you know what software powers git.launchpad.net? That "Parameters
> must have values" message has never appeared in any Git version, though
> the server claims to be v2.17.1:

I guess it's this:

  https://code.launchpad.net/launchpad

but I can't find any trace of the "Parameters must have values" error
message in there. It looks like it builds on dulwich, but I can't find
the message there either. So I'm at a loss.

-Peff
