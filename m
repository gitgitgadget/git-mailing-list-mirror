Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83218C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DE22084D
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfKYOXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:23:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:59954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727655AbfKYOXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:23:52 -0500
Received: (qmail 26409 invoked by uid 109); 25 Nov 2019 14:23:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 14:23:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18969 invoked by uid 111); 25 Nov 2019 14:27:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 09:27:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 09:23:51 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: Announcing git-mentoring@googlegroups.com
Message-ID: <20191125142351.GE494@sigill.intra.peff.net>
References: <20191114194708.GD60198@google.com>
 <20191122203127.GA5292@dcvr>
 <20191122231921.GB101478@google.com>
 <20191123001749.GA12923@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191123001749.GA12923@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 23, 2019 at 12:17:49AM +0000, Eric Wong wrote:

> > Hm, this is a little circular, right? Part of the rationale for keeping
> > viewing limited was "that way it's not visible to generic search
> > engines".
> 
> Sorry if I wasn't clear.  My points were:
> 
> 1) limiting visibility harmful to helpfulness
> 
> 2) trusting "members" to keep potentially embarrasing posts
>    away from the public eye is unrealistic.  Let posters
>    maintain anonymity or pseudonymity for themselves.

I think it's trying to find a tradeoff, though. The point isn't to guard
sensitive information. It's to have a less intimidating forum for people
to converse in. Even though anybody from the public _could_ join and
read them, keeping them out of most web searches may be more
comfortable. Likewise, members of the group _could_ exfiltrate all of
the posts and show them publicly. But in practice that's unlikely.

Note that I'm guessing at what others would find more comfortable or
less intimidating. Obviously I'm quite happy to speak my mind all over
public mailing lists. ;) But the point is to give a forum for people who
aren't. I think this setup matches the mentoring list in other orgs.
E.g. Outreachy itself, though there I think you have to actually be an
intern to see the posts. We could moderate membership to the mentor list
but it seems like a hassle for little gain.

-Peff
