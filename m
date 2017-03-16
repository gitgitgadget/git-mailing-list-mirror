Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4AB720953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbdCPWGo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:06:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:45444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752744AbdCPWGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:06:43 -0400
Received: (qmail 2440 invoked by uid 109); 16 Mar 2017 22:06:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 22:06:23 +0000
Received: (qmail 29974 invoked by uid 111); 16 Mar 2017 22:06:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:06:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 18:06:20 -0400
Date:   Thu, 16 Mar 2017 18:06:20 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Stevens <Marc.Stevens@cwi.nl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170316220620.ihq4ulg4t6m7ktrh@sigill.intra.peff.net>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net>
 <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl>
 <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com>
 <161775901.3349663.1489438074825.JavaMail.zimbra@cwi.nl>
 <20170313210023.bumtp6wyw6blmymp@sigill.intra.peff.net>
 <1392458356.3351662.1489439723458.JavaMail.zimbra@cwi.nl>
 <2006239187.136016.1489688534478.JavaMail.zimbra@cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2006239187.136016.1489688534478.JavaMail.zimbra@cwi.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 07:22:14PM +0100, Marc Stevens wrote:

> Today I merged the perf-branch into master after code review and correctness testing.
> So master is now more performant and safe to use.

Great, thank you (and Dan) so much for all your work. We're looking at
integrating this version in a nearby thread.

-Peff
