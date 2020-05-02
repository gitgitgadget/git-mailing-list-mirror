Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A53C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F9E20731
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgEBTHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 15:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728450AbgEBTHe (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 15:07:34 -0400
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::216:3eff:fede:83d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D2C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 12:07:33 -0700 (PDT)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 083FC4400FC; Sat,  2 May 2020 21:07:30 +0200 (CEST)
Date:   Sat, 2 May 2020 21:07:29 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tig: bug when binding to 'generic'?
Message-ID: <20200502190729.GC1838755@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, Wolfram Sang <wsa@kernel.org>,
        git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
References: <20200502190433.GB25220@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502190433.GB25220@ninjato>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 09:04:33PM +0200, Wolfram Sang wrote:
> Hi,
> 
> here is a minimal, problematic .tigrc:
> 
> ===
> bind	generic	F	!echo "Hello World!"
> ===
> 
> This works for most views, but not for 'main' where it still toggles the
> refs. Adding a specific 'main' binding works:
> 
> ===
> bind	main	F	!echo "Hello World!"
> ===
> 
> It also works if I bind the 'generic' command to an unused key, e.g. '4'.
> 
> Discovered with Debian's 2.4.1, but confirmed against HEAD of today.
> 
> A bug?
> 
> Thanks,
> 
>    Wolfram
> 

Hello Wolfram,

Tig is a third-party interface, not maintained by git. You can report
issues for tig on [github][0]

Kind regards, Kevin

[0]:https://github.com/jonas/tig/issues

