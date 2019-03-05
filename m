Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F146720248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfCEXC3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:02:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:40088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726217AbfCEXC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:02:29 -0500
Received: (qmail 27777 invoked by uid 109); 5 Mar 2019 23:02:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 23:02:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3587 invoked by uid 111); 5 Mar 2019 23:02:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 18:02:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 18:02:27 -0500
Date:   Tue, 5 Mar 2019 18:02:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
Message-ID: <20190305230227.GA22901@sigill.intra.peff.net>
References: <20190305214423.27820-1-jn.avila@free.fr>
 <20190305223655.GA27535@sigill.intra.peff.net>
 <xmqq4l8hszj7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4l8hszj7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 07:54:20AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Did you notice this when building locally, or on the asciidoctor-built
> > pages at git-scm.com?
> 
> Does git-scm.com even have this file rendered?  I do not think we
> glob for technical/*.txt in any of our Makefiles; instead we have a
> list of ready-to-be-consumed TECH_DOCS listed explicitly.

It is rendered, at https://git-scm.com/docs/directory-rename-detection.

However, that explains why doc-diff did not find anything; it only looks
at the results of "make install-man", which does not include any
technical docs (let alone this one that is not mentioned in
$(TECH_DOCS).

-Peff
