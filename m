Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC4F1F424
	for <e@80x24.org>; Wed,  9 May 2018 03:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeEID2Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 23:28:16 -0400
Received: from pug.qqx.org ([50.116.43.67]:60432 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932579AbeEID2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 23:28:15 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 May 2018 23:28:15 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 63CAE1DC86; Tue,  8 May 2018 23:20:50 -0400 (EDT)
Date:   Tue, 8 May 2018 23:20:50 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
Message-ID: <20180509032050.GA23510@pug.qqx.org>
Mail-Followup-To: Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20180417181300.23683-1-pclouds@gmail.com>
 <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
User-Agent: Mutt/1.9.5+145 (bd7674cd9) (2018-04-24)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 17:24 +0200 08 May 2018, Duy Nguyen <pclouds@gmail.com> wrote:
>It took me so long to reply partly because I remember seeing some guy
>doing clever trick with tab completion that also shows a short help
>text in addition to the complete words. I could not find that again
>and from my reading (also internet searching) it's probably not
>possible to do this without trickery.

Was that perhaps using zsh rather than bash? Below is some of the 
display from its git completion (this is likely affected somewhat by my 
configuration).  The group descriptions (lines that begin with 
"Completing") appear in a different color, and are not available for 
selection.

1113$ git c<tab>
Completing alias
ci               -- alias for 'commit -v'
cia              -- alias for 'commit -v -a'
co               -- alias for 'checkout'
conf             -- alias for 'config'
Completing main porcelain command
checkout         -- checkout branch or paths to working tree
cherry-pick      -- apply changes introduced by some existing commits
citool           -- graphical alternative to git commit
clean            -- remove untracked files from working tree
clone            -- clone repository into new directory
commit           -- record changes to repository
Completing ancillary manipulator command
config           -- get and set repository or global options
Completing ancillary interrogator command
cherry           -- find commits not merged upstream
count-objects    -- count unpacked objects and display their disk consumption
Completing plumbing manipulator command
checkout-index   -- copy files from index to working directory
commit-tree      -- create new commit object
Completing plumbing interrogator command
cat-file         -- provide content or type information for repository objects

1114$ git commit -<tab>
Completing option
--all                  -a       -- stage all modified and deleted paths
--allow-empty                   -- allow recording an empty commit
--allow-empty-message           -- allow recording a commit with an empty message
--amend                         -- amend the tip of the current branch
--author                        -- override the author name used in the commit
