Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C86F1FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 10:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbdFGKde (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 06:33:34 -0400
Received: from ikke.info ([178.21.113.177]:34084 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbdFGKdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 06:33:33 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 138214400AE; Wed,  7 Jun 2017 12:33:26 +0200 (CEST)
Date:   Wed, 7 Jun 2017 12:33:26 +0200
From:   Kevin Daudt <me@ikke.info>
To:     pedro rijo <pedrorijo91@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [BUG] Failed to sign commit
Message-ID: <20170607103326.GB27719@alpha.vpn.ikke.info>
References: <CAPMsMoAYpS8QMrfyed5=XPWJLbV6=kMg5gp-2a75kWMpVD3D1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMsMoAYpS8QMrfyed5=XPWJLbV6=kMg5gp-2a75kWMpVD3D1A@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 07, 2017 at 10:46:08AM +0100, pedro rijo wrote:
> Recently I've updated a bunch of stuff, including git and gpg. I'm using
> 
> - mac OS 10.10.5
> - git 2.13.1
> - gpg (GnuPG) 2.1.21 / libgcrypt 1.7.7
> 
> When I do
> 
> $ git commit --allow-empty -v -m "lol"
> error: gpg failed to sign the data
> fatal: failed to write commit object
> 
> I tried the verbose flag hoping to have a better insight, but not very
> useful. Not sure if it's a gpg problem, a git problem, or something
> else.
> 
> Any clue on how to debug the problem? Do you need any gpg output to
> better understand the problem?
> 
> Thanks,
> Pedro

GIT_TRACE=1 git commit --allow-empty -v -m "lol" might give some extra
feedback (ie, what gpg command git runs), and try to see if you can
replicate it.
