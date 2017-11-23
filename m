Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36AAB20954
	for <e@80x24.org>; Thu, 23 Nov 2017 00:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdKWAKv (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 19:10:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:38272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751575AbdKWAKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 19:10:50 -0500
Received: (qmail 8943 invoked by uid 109); 23 Nov 2017 00:10:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Nov 2017 00:10:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6081 invoked by uid 111); 23 Nov 2017 00:11:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 19:11:06 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 19:10:48 -0500
Date:   Wed, 22 Nov 2017 19:10:48 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171123001048.GA9465@sigill>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122232457.GA8577@sigill>
 <20171122232814.GH11671@aiede.mtv.corp.google.com>
 <20171122233905.GC8577@sigill>
 <20171122234532.GI11671@aiede.mtv.corp.google.com>
 <20171122235851.GE8577@sigill>
 <20171123000839.GL11671@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171123000839.GL11671@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 04:08:39PM -0800, Jonathan Nieder wrote:

> > For the record, I'm totally fine with banning assert() in favor of a
> > custom equivalent. I just don't think we've seen any real problems with
> > assert in our codebase so far.
> 
> It sounds like we basically agree, then. :)

Yeah, I didn't quite understand your argument at first. If it's that
asserts are potentially dangerous, I buy that. They haven't bit us, but
they could.

That would be a good thing for Stefan to put in his commit message. ;)

-Peff
