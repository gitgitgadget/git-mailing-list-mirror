Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3264CC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 20:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiKQUnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 15:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKQUni (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 15:43:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4601582D
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 12:43:34 -0800 (PST)
Received: (qmail 26331 invoked by uid 109); 17 Nov 2022 20:43:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 20:43:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15965 invoked by uid 111); 17 Nov 2022 20:43:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 15:43:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 15:43:33 -0500
From:   Jeff King <peff@peff.net>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
Subject: Re: The enduring popularity of git-credential-store
Message-ID: <Y3ac9ZuvpDJO3k9F@coredump.intra.peff.net>
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net>
 <AS2PR03MB98158D49DC655F6DC6D10ECDC0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
 <Y3aCx1SYq6jrYfuO@coredump.intra.peff.net>
 <a76a5e37-0c0a-b9e8-13cb-abaa44cf8911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a76a5e37-0c0a-b9e8-13cb-abaa44cf8911@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 11:29:35AM -0800, Lessley Dennington wrote:

> On 11/17/22 10:51 AM, Jeff King wrote:
> > I do think having the docs say "you should go use X" means that X will
> > have an advantage over other projects which may compete with it. So I
> > think we need to be careful to be inclusive of what we'll mention, and
> > to word it so that we're not endorsing any one project.
> > 
> > -Peff
> 
> Completely agree with this. I've long wished for a page on git-scm.com
> that's dedicated to (1) explaining what a credential helper is and
> (2) offering a list of suggested helpers along with scenarios for which
> each is best-suited. This could also be a good place to call out the risks
> of using helpers like git-credential-store in a factual, unbiased way.

It's also a nice place because it's easier to keep up-to-date compared
to say, a manpage.

-Peff
