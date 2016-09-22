Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B51207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 06:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755845AbcIVGth (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 02:49:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:46519 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755791AbcIVGte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 02:49:34 -0400
Received: (qmail 18034 invoked by uid 109); 22 Sep 2016 06:49:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 06:49:33 +0000
Received: (qmail 6385 invoked by uid 111); 22 Sep 2016 06:49:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 02:49:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 02:49:31 -0400
Date:   Thu, 22 Sep 2016 02:49:31 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
Message-ID: <20160922064931.ganuwswlnom6nzya@sigill.intra.peff.net>
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
 <20160921162628.GA27363@ikke.info>
 <xmqq7fa59mti.fsf@gitster.mtv.corp.google.com>
 <20160921174550.GB27363@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160921174550.GB27363@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 07:45:50PM +0200, Kevin Daudt wrote:

> On Wed, Sep 21, 2016 at 10:36:57AM -0700, Junio C Hamano wrote:
> > Kevin Daudt <me@ikke.info> writes:
> > 
> > > On Mon, Sep 19, 2016 at 04:30:34PM -0700, Junio C Hamano wrote:
> > >> 
> > >> * kd/mailinfo-quoted-string (2016-09-19) 2 commits
> > >>  - mailinfo: unescape quoted-pair in header fields
> > >>  - t5100-mailinfo: replace common path prefix with variable
> > >
> > > Is this good enough, or do you want me to look into the feedback from
> > > jeff?
> > 
> > If you are talking about the simplified loop that deliberately sets
> > a rule that is looser than RFC, yes, I'd like to see you at least
> > consider the pros and cons of his approach, which looked nicer to my
> > brief reading of it.
> > 
> > It is perfectly OK by me (it may not be so if you ask Peff) if you
> > decide that your version is better after doing so, though.
> 
> Alright, I'll look into it.

Thanks. I am OK if we do not use my simplified version, but I think
there were some issues I noted with your last version.

-Peff
