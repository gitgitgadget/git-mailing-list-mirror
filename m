Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192D52036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdKUVXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:23:07 -0500
Received: from ikke.info ([178.21.113.177]:36612 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdKUVXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:23:07 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 68B264400DB; Tue, 21 Nov 2017 22:23:05 +0100 (CET)
Date:   Tue, 21 Nov 2017 22:23:05 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: remove explanation of "--" from man pages
Message-ID: <20171121212305.GA16418@alpha.vpn.ikke.info>
References: <alpine.LFD.2.21.1711211607200.25585@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711211607200.25585@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 04:12:02PM -0500, Robert P. J. Day wrote:
> "man gitcli" already explains the purpose of the "--" syntax, so there
> is no value to a small subset of Git commands explaining that in their
> man pages.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>   i tried this once before, and i'm going to try to push it through
> again ... it's pointless and inconsistent for less than a dozen man
> pages to explicitly explain the purpose of "--" unless all of the man
> pages do. as long as the "--" appears in the command SYNOPSIS, that
> should be more than adequate.

Although I agree that common options don't need to be explained
everytime again, this change might make '--' even more obscure. To be
honest, I didn't even know about gitcli(7), let alone most new users.

In the #git irc channel we often have to explain what '--' means and
why it's sometimes necessary.

I don't however know a better solution to it more clear.

Kevin
