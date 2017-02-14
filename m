Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13211FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbdBNGQK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:16:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:54915 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdBNGQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:16:09 -0500
Received: (qmail 12894 invoked by uid 109); 14 Feb 2017 06:16:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:16:09 +0000
Received: (qmail 915 invoked by uid 111); 14 Feb 2017 06:16:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:16:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:16:07 -0500
Date:   Tue, 14 Feb 2017 01:16:07 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] remote helpers: avoid blind fall-back to ".git" when
 setting GIT_DIR
Message-ID: <20170214061607.qyucfue335aqgji2@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <20161122004421.GA12263@google.com>
 <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
 <20161230001114.GB7883@aiede.mtv.corp.google.com>
 <20161230004845.rknafqsyosmyr6z2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161230004845.rknafqsyosmyr6z2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 07:48:45PM -0500, Jeff King wrote:

> On Thu, Dec 29, 2016 at 04:11:14PM -0800, Jonathan Nieder wrote:
> 
> > Thanks.  Here's the patch again, now with commit messages and a test.
> > Thanks for the analysis and sorry for the slow turnaround.
> 
> Thanks for following up. While working on a similar one recently, I had
> the nagging feeling that there was a case we had found that was still to
> be dealt with, and I think this was it. :)
> 
> The patch to the C code looks good. I have a few comments on the tests:

I happened to run into this problem myself today, so I thought I'd prod
you. I think your patch looks good. Hopefully I didn't scare you off
with my comments. :)

-Peff
