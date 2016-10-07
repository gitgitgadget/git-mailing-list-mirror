Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E42207EC
	for <e@80x24.org>; Fri,  7 Oct 2016 04:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbcJGE4R (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 00:56:17 -0400
Received: from ikke.info ([178.21.113.177]:43020 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbcJGE4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 00:56:16 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 2D5004401D4; Fri,  7 Oct 2016 06:56:13 +0200 (CEST)
Date:   Fri, 7 Oct 2016 06:56:13 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #02; Thu, 6)
Message-ID: <20161007045613.GB25613@ikke.info>
References: <xmqqd1jdi0a6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1jdi0a6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 03:24:17PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> A handful of topics have been merged to 'master' and it's time to
> update the "What's cooking" report.  Linus's and Peff's auto scaling
> of default abbreviation length will cook a bit longer in 'next' to
> see if anybody screams; there may still be codepaths that assume
> that default-abbrev would never be negative and a reasonable
> fallback value that we need to locate and fix.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> [Graduated to "master"]
> 

Just wondering why the topic "kd/mailinfo-quoted-string (2016-09-28) 2
commits" is not listed anymore. Previous what's cooking said it was
merged to "next".
