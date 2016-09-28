Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113691F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 20:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbcI1U1m (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 16:27:42 -0400
Received: from ikke.info ([178.21.113.177]:49308 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753204AbcI1U1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 16:27:41 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 151624400BF; Wed, 28 Sep 2016 22:27:39 +0200 (CEST)
Date:   Wed, 28 Sep 2016 22:27:39 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] t5100-mailinfo: replace common path prefix with
 variable
Message-ID: <20160928202739.GB22520@ikke.info>
References: <20160928194939.7706-1-me@ikke.info>
 <20160928195232.7843-1-me@ikke.info>
 <xmqqoa37ixmu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqoa37ixmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 01:21:13PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > Many tests need to store data in a file, and repeat the same pattern to
> > refer to that path:
> >
> >     "$TEST_DIRECTORY"/t5100/
> >
> > Create a variable that contains this path, and use that instead.
> >
> > While we're making this change, make sure the quotes are not just around
> > the variable, but around the entire string to not give the impression
> > we want shell splitting to affect the other variables.
> 
> Wow.  I was half expecting that you'd say something like "1/2 plus
> the SQUASH is OK by me", but you went extra mile to do it right.
> 
> Impressed, and very much appreciated.
> 

You're What's Cooking mail mentioned you expected a reroll, so I guessed
that I could just fix this part as well.
