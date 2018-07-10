Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BC51F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeGJQ4m (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:56:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754260AbeGJQ4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:56:40 -0400
Received: (qmail 26094 invoked by uid 109); 10 Jul 2018 16:56:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 16:56:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28552 invoked by uid 111); 10 Jul 2018 16:56:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 12:56:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 12:56:38 -0400
Date:   Tue, 10 Jul 2018 12:56:38 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per
 gpg format program
Message-ID: <20180710165638.GF23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
 <20180710165412.GE23624@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710165412.GE23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 12:54:13PM -0400, Jeff King wrote:

> Should we allow:
> 
>   [gpg "OpenPGP"]
>   program = whatever
> 
> given that we allow:
> 
>   [gpg]
>   format = OpenPGP
> 
> ? I think just using strcasecmp() here would be sufficient. But I wonder
> if it is a symptom of using the wrong tool (subsections) when we don't
> need it.

I did just read the discussion in response to v1, where everybody told
you the opposite. ;)

So I guess my question/points are more for brian and Junio.

-Peff
