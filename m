Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06221F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 01:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbcITBhI (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 21:37:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:45359 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932185AbcITBhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 21:37:08 -0400
Received: (qmail 11992 invoked by uid 109); 20 Sep 2016 01:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 01:37:07 +0000
Received: (qmail 16184 invoked by uid 111); 20 Sep 2016 01:37:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Sep 2016 21:37:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2016 18:37:04 -0700
Date:   Mon, 19 Sep 2016 18:37:04 -0700
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC
 PATCH]
Message-ID: <20160920013704.7hk2creytmfrla6h@sigill.intra.peff.net>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
 <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com>
 <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
 <20160919204408.GA28962@cloud>
 <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
 <20160919234022.GA29421@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160919234022.GA29421@cloud>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 04:40:22PM -0700, Josh Triplett wrote:

> >   - there are a non-trivial number of patches for other projects (JGIT,
> >     EGIT, StGit, etc). This is somewhat unique to git, where we discuss
> >     a lot of related projects on the list. But I wonder if other
> >     projects would use subsystems in a similar way (though I guess for
> >     the kernel, there are separate subsystems lists, so the "to" or "cc"
> >     header becomes the more interesting tag).
> 
> The kernel mostly uses "[PATCH] subsystem: ...".  Occasionally I see
> "[PATCH somegitrepo ...] ..." when it's necessary to explicitly say
> whose git repo the patch needs to go through, but that's pretty rare.

We do both. "foo: blah" is for subsystem "foo" of Git itself, but
all-caps "JGIT PATCH" is "this is not even for Git". I don't know that
the kernel really has an equivalent.

-Peff
