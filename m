Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8BFA2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdJCTgx (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:36:53 -0400
Received: from ikke.info ([178.21.113.177]:59766 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdJCTgx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:36:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A82FE4403A1; Tue,  3 Oct 2017 21:36:51 +0200 (CEST)
Date:   Tue, 3 Oct 2017 21:36:51 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Tsvi Mostovicz <ttmost@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git add -p stops working when setting color.ui = always
Message-ID: <20171003193651.GB1667@alpha.vpn.ikke.info>
References: <CAB2yay8LLeNbqR4kkTwF1U+oarVDRxgkV4uGXuYcO8mAQmhWQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB2yay8LLeNbqR4kkTwF1U+oarVDRxgkV4uGXuYcO8mAQmhWQQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 01:38:17PM +0300, Tsvi Mostovicz wrote:
> Hi,
> 
> When setting "color.ui = always" in the last few versions (not sure
> exactly when this started, but definitely exists in 2.14.1 and
> 2.14.2), git add -p stops working as expected. Instead of prompting
> the user, it skips through the prompts and doesn't allow selecting a
> hunk.
> 
> Don't know why I had color.ui = always set in my .gitconfig.
> 
> git version 2.14.2.666.gea220ee40
> 
> Thanks,
> 

Hello Tsvi,

This is being discussed just now[0]. Setting the value to auto should
fix it (setting it to always does not make much sense in your config
file).

Kevin.

[0}:https://public-inbox.org/git/20171003093157.gq7za2fwcqsouire@sigill.intra.peff.net/T/
