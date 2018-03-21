Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444B51F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 08:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeCUIgu (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 04:36:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:37260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751405AbeCUIgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 04:36:48 -0400
Received: (qmail 4844 invoked by uid 109); 21 Mar 2018 08:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 08:36:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8613 invoked by uid 111); 21 Mar 2018 08:37:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 04:37:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 04:36:46 -0400
Date:   Wed, 21 Mar 2018 04:36:46 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180321083646.GA32578@sigill.intra.peff.net>
References: <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
 <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net>
 <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
 <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
 <20180321065212.GC16784@sigill.intra.peff.net>
 <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
 <20180321075041.GA24701@sigill.intra.peff.net>
 <CAHnyXxTP7i4G=4G_ihRQTSbLNzAWuqZ3FoX0NtesAX219Pa5-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnyXxTP7i4G=4G_ihRQTSbLNzAWuqZ3FoX0NtesAX219Pa5-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 04:35:26AM -0400, Dakota Hawkins wrote:

> > I think it means "for the rest of the description of how the patterns
> > work". I.e., "foo/" matches as "foo" when the rest of the matching rules
> > are applied. I agree it's a bit awkward. Patches welcome. :)
> 
> I'd be more than happy to do that!
> 
> It will take me a while, this (email and text-patches) is foreign to
> me and will take me some extra time, but I think I can figure it out.
> 
> Is "consistent with the way how pathspec works in general in Git"
> absolutely still true (and relevant?)

I think so. "git log Makefile/" will not match anything, for example.

-Peff
