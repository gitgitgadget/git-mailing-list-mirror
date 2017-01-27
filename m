Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4DEB1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933030AbdA0RQ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:16:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:45918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933007AbdA0RPl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:15:41 -0500
Received: (qmail 10867 invoked by uid 109); 27 Jan 2017 17:07:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:07:15 +0000
Received: (qmail 1224 invoked by uid 111); 27 Jan 2017 17:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 12:07:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 12:07:13 -0500
Date:   Fri, 27 Jan 2017 12:07:13 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] t/Makefile: add a rule to re-run previously-failed
 tests
Message-ID: <20170127170713.kn35br4xsdco7xth@sigill.intra.peff.net>
References: <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
 <85044791cfcba35c1ad3d8138051f3f075cb0646.1485526641.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85044791cfcba35c1ad3d8138051f3f075cb0646.1485526641.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 03:17:36PM +0100, Johannes Schindelin wrote:

> This patch automates the process of determinig which tests failed
> previously and re-running them.

s/determinig/determining/

Patch otherwise looks good, and I'm happy to be rid of the sed
complexity from v2.

-Peff
