Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569CC2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 23:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbcKDXJG (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 19:09:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:38920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbcKDXJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 19:09:05 -0400
Received: (qmail 21375 invoked by uid 109); 4 Nov 2016 23:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 23:09:04 +0000
Received: (qmail 27246 invoked by uid 111); 4 Nov 2016 23:09:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 19:09:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2016 19:09:02 -0400
Date:   Fri, 4 Nov 2016 19:09:02 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] transport: add protocol policy config option
Message-ID: <20161104230902.ulkyejwamm6q575a@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <1478292933-7873-1-git-send-email-bmwill@google.com>
 <20161104205815.GA127933@google.com>
 <CAGZ79kZB9wMgPDktMUpBfcvgJy16N8P74SvLP5740UNftZkbVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZB9wMgPDktMUpBfcvgJy16N8P74SvLP5740UNftZkbVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 02:35:57PM -0700, Stefan Beller wrote:

> On Fri, Nov 4, 2016 at 1:58 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 11/04, Brandon Williams wrote:
> >> Signed-off-by: Brandon Williams <bmwill@google.com>
> >
> > Is there an acceptable way to give credit to Jeff for helping with this patch?
> 
> What about:
> Helped-by: Jeff King <peff@peff.net>

That, or often I would write:

  Based on a patch by Jeff King <peff@peff.net>

in the commit message. Basically anything is OK _except_ forging
signed-off-by, because it has a very specific meaning. So let me also
say that I am happy to give my:

  Signed-off-by: Jeff King <peff@peff.net>

to the original (which you should add in, to make clear that the
copyright issues are OK).

In some cases it makes sense to just roll somebody's patch into your
series, and then build on top. I'm fine with it all going into a single
patch here.

-Peff
