Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3181F405
	for <e@80x24.org>; Thu, 20 Dec 2018 15:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbeLTPtC (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 10:49:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:46886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731177AbeLTPtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 10:49:02 -0500
Received: (qmail 1120 invoked by uid 109); 20 Dec 2018 15:49:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 15:49:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31686 invoked by uid 111); 20 Dec 2018 15:48:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 10:48:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 10:49:00 -0500
Date:   Thu, 20 Dec 2018 10:49:00 -0500
From:   Jeff King <peff@peff.net>
To:     Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any
 context
Message-ID: <20181220154900.GF27361@sigill.intra.peff.net>
References: <20181116084427.GA31493@sigill.intra.peff.net>
 <cover.1544572142.git.steadmon@google.com>
 <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com>
 <20181212110206.GA30673@sigill.intra.peff.net>
 <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
 <20181213221826.GE37614@google.com>
 <20181217213310.GA14251@sigill.intra.peff.net>
 <20181219233005.GI37614@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219233005.GI37614@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 03:30:05PM -0800, Josh Steadmon wrote:

> > > > This is outside of the Git pack protocol so having a separate parsing
> > > > mode makes sense to me.
> > > 
> > > This sounds like it could be a significant refactoring. Should we go
> > > back to V2 of this series, and then work on the new parsing mode
> > > separately?
> > 
> > Which one is v2? :)
> > 
> > Just the remote-curl cleanups from me, and then your "die on server-side
> > errors" patch?
> 
> Yes, that one :)

Then yes, that sounds reasonable to me.

-Peff
