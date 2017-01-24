Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98971F437
	for <e@80x24.org>; Tue, 24 Jan 2017 20:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbdAXUfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 15:35:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:44051 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdAXUfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 15:35:30 -0500
Received: (qmail 3056 invoked by uid 109); 24 Jan 2017 20:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 20:35:15 +0000
Received: (qmail 4987 invoked by uid 111); 24 Jan 2017 20:35:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 15:35:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2017 15:35:13 -0500
Date:   Tue, 24 Jan 2017 15:35:13 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/12] add oidset API
Message-ID: <20170124203513.2kbhr6slph2336v5@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004647.3o26ionfq3td2irf@sigill.intra.peff.net>
 <944ea1f8-8f9c-cc17-02a5-a73cb6565b45@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <944ea1f8-8f9c-cc17-02a5-a73cb6565b45@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 08:26:40PM +0000, Ramsay Jones wrote:

> > +++ b/oidset.c
> > @@ -0,0 +1,49 @@
> > +#include "cache.h"
> > +#include "oidset.h"
> > +
> > +struct oidset_entry {
> > +	struct hashmap_entry hash;
> > +	struct object_id oid;
> > +};
> > +
> > +int oidset_hashcmp(const void *va, const void *vb,
> 
> static int oidset_hashcmp( ...

Yep, thanks.

-Peff
