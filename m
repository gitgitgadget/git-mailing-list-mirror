Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D002021E
	for <e@80x24.org>; Tue, 15 Nov 2016 15:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935544AbcKOPcu (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 10:32:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:43406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965296AbcKOPcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 10:32:02 -0500
Received: (qmail 20831 invoked by uid 109); 15 Nov 2016 15:32:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 15:32:01 +0000
Received: (qmail 11324 invoked by uid 111); 15 Nov 2016 15:32:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Nov 2016 10:32:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2016 10:31:59 -0500
Date:   Tue, 15 Nov 2016 10:31:59 -0500
From:   Jeff King <peff@peff.net>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
Message-ID: <20161115153159.mxfl73dnhljad5so@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
 <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
 <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
 <20161115120718.GA7854@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161115120718.GA7854@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 01:07:18PM +0100, Heiko Voigt wrote:

> On Fri, Nov 11, 2016 at 09:22:51AM +0100, Lars Schneider wrote:
> > To all macOS users on the list:
> > Does anyone execute the tests with GIT_TEST_HTTPD enabled successfully?
> 
> Nope. The following tests fail for me on master: 5539, 5540, 5541, 5542,
> 5550, 5551, 5561, 5812.

Failing how? Does apache fail to start up? Do tests fails? What does
"-v" say? Is there anything interesting in httpd/error.log in the trash
directory?

-Peff
