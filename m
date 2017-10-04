Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E57820365
	for <e@80x24.org>; Wed,  4 Oct 2017 15:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdJDPDt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 11:03:49 -0400
Received: from ikke.info ([178.21.113.177]:60360 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbdJDPDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 11:03:47 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 9176044039C; Wed,  4 Oct 2017 17:03:45 +0200 (CEST)
Date:   Wed, 4 Oct 2017 17:03:45 +0200
From:   Kevin Daudt <me@ikke.info>
To:     rpjday@crashcourse.ca
Cc:     git@vger.kernel.org
Subject: Re: distinguishing between staged and unstaged content in a stash?
Message-ID: <20171004150345.GC1667@alpha.vpn.ikke.info>
References: <20171004071046.Horde.89FTNuoUz8wPxhsuejrB03G@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004071046.Horde.89FTNuoUz8wPxhsuejrB03G@crashcourse.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 07:10:46AM -0400, rpjday@crashcourse.ca wrote:
> 
>   couple (admittedly trivial) questions about stashing. first, can i
> clarify that when one stashes content, a stash *always* distinguishes
> between what was staged, and what was unstaged? that is, when one is
> stashing, the "--keep-index" option relates to whether or not staged
> changes are left in the index (and, consequently, in the working
> directory as well), but that option has no effect on the final content
> of the stash, yes? even if "--keep-index" is used, staged content
> still ends up in the stash.
> 
>   also, is there a simple way to distinguish between the staged and
> unstaged contents of a stash (or, more basically, is this even a
> useful question to ask)? out of curiosity, i tried to figure out
> how to do this, and came up with the following.
> 
> to see staged portion of stash@{0}:
> 
>   $ git show stash@{0}^2
> 
> to see unstaged portion:
> 
>   $ git diff stash@{0}^2 stash@{0}
> 
> it's not like i have a pressing need to do that, i was just curious
> if there's a simpler way to do this, or if this is just not something
> people should need to do on a regular basis.
> 
> rday
> 
> 
> 

There was a recent thread about this[0]. The conclusion is that it's
seen as a good change, someone just needs to supply the patch to do
this. A possible solution was also provided (from before that thread)
here [1]

[0]:https://public-inbox.org/git/1505626069.9625.6.camel@gmail.com/
[1]:https://public-inbox.org/git/20170317141417.g2oenl67k74nlqrq@sigill.intra.peff.net/
