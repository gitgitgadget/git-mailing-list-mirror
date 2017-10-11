Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6700020437
	for <e@80x24.org>; Wed, 11 Oct 2017 04:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbdJKEyH (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 00:54:07 -0400
Received: from ikke.info ([178.21.113.177]:56164 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbdJKEyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 00:54:06 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id AF4A244039C; Wed, 11 Oct 2017 06:54:04 +0200 (CEST)
Date:   Wed, 11 Oct 2017 06:54:04 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
Message-ID: <20171011045404.GB16800@alpha.vpn.ikke.info>
References: <20171009214543.12986-1-me@ikke.info>
 <CAN0heSoWTpVZXmJkoEQtc_rjFj3PdPWV_37B9LukxxsYy5ox1w@mail.gmail.com>
 <20171010140118.quyesljvz44wvfx6@sigill.intra.peff.net>
 <CAN0heSqZn1pqskK-KP=DEW1-Kz=-avX0TUON38Dk_TVKAsBAiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqZn1pqskK-KP=DEW1-Kz=-avX0TUON38Dk_TVKAsBAiQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 07:02:00PM +0200, Martin Ågren wrote:
> On 10 October 2017 at 16:01, Jeff King <peff@peff.net> wrote:
> > On Tue, Oct 10, 2017 at 12:30:49PM +0200, Martin Ågren wrote:
> >> On 9 October 2017 at 23:45, Kevin Daudt <me@ikke.info> wrote:
> >> > Since ff1e72483 (tag: change default of `pager.tag` to "on",
> >> > 2017-08-02), the pager has been enabled by default, exposing this
> >> > problem to more people.
> >>
> >> Oh. :( I didn't know about "column" to be honest.
> >
> > Yeah, I didn't think of that with respect to the pager. This is a
> > regression in v2.14.2, I think.
> 
> Yes.

Though 2.14.2 enabled the pager by default, even before that when
someone would've enabled the pager theirselves (by setting pager.tag for
example), it would also shown just a single column.

I could reproduce it as far as 2.8.3 (I could not test further due to
libssl incompattibility).
