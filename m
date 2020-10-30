Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B6CC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136E02076D
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJ3LZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:25:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3LZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 07:25:25 -0400
Received: (qmail 6338 invoked by uid 109); 30 Oct 2020 11:25:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 11:25:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20119 invoked by uid 111); 30 Oct 2020 11:25:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 07:25:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 07:25:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
Cc:     git@vger.kernel.org
Subject: Re: Credential Store: Don't acquire lock when only reading the file
Message-ID: <20201030112524.GA3274373@coredump.intra.peff.net>
References: <20201029192020.mcri76ylbdure2o7@safonso-t430>
 <20201030055541.GA3264588@coredump.intra.peff.net>
 <20201030112229.3rcyylkuyrlrhn7g@safonso-t430>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201030112229.3rcyylkuyrlrhn7g@safonso-t430>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 11:22:29AM +0000, Simão Afonso wrote:

> On 2020-10-30 01:55:41, Jeff King wrote:
> > Interested in trying a patch for any of those?
> 
> Sounds good to me, I should be able to handle it if you CC/BCC me
> (subscribing to the firehose is a bit too much).

I meant: would you like to try writing a patch. :)

The offer applies to anybody else, too, of course. I may work on it
eventually, but I've successfully left that series at the bottom of my
todo list for 8 years, so...

-Peff
