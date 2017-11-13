Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4441F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 11:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbdKMLaU (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 06:30:20 -0500
Received: from ikke.info ([178.21.113.177]:39030 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbdKMLaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 06:30:20 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 898E144080B; Mon, 13 Nov 2017 12:30:18 +0100 (CET)
Date:   Mon, 13 Nov 2017 12:30:18 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error
 messages when renaming
Message-ID: <20171113113018.GB17612@alpha.vpn.ikke.info>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
 <20171112182322.GA17612@alpha.vpn.ikke.info>
 <29bd81e4-e8df-8fb8-9436-d70902106f49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29bd81e4-e8df-8fb8-9436-d70902106f49@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 08:01:12AM +0530, Kaartic Sivaraam wrote:
> On Sunday 12 November 2017 11:53 PM, Kevin Daudt wrote:
> > On Thu, Nov 02, 2017 at 12:24:07PM +0530, Kaartic Sivaraam wrote:
> > > From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> > > 
> > > When trying to rename an inexistent branch to with a name of a branch
> > 
> > This sentence does not read well. Probably s/with a/the/ helps.
> > 
> 
> Thanks. Seems I missed it somehow. Will fix it.
> 
> > > that already exists the rename failed specifying the new branch name
> > > exists rather than specifying that the branch trying to be renamed
> > > doesn't exist.
> > > 
> > > [..]
> > > 
> > > Note: Thanks to the strbuf API that made it possible to easily construct
> > > the composite error message strings!
> > 
> > I'm not sure this note adds a lot, since the strbuf API is not that new.
> > 
> 
> That was a little attribution I wanted make to the strbuf API as this was
> the first time I leveraged it to this extent and I was surprised by the way
> it made string manipulation easier in C. Just documented my excitation. In
> case it seems to be noise (?) which should removed, let me know.

I guess that would fit better below the the ---
