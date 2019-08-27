Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F721F461
	for <e@80x24.org>; Tue, 27 Aug 2019 22:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfH0WW2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 18:22:28 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57551 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfH0WW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 18:22:28 -0400
X-Originating-IP: 1.186.12.40
Received: from localhost (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2AF76E0002;
        Tue, 27 Aug 2019 22:22:25 +0000 (UTC)
Date:   Wed, 28 Aug 2019 03:52:24 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Vipul <finn02@disroot.org>
Cc:     git@vger.kernel.org
Subject: Re: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands
Message-ID: <20190827222224.yypf3ydvsebxypb6@yadavpratyush.com>
References: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/08/19 09:53AM, Vipul wrote:
> Hi,
> 
> Sometimes, I messed-up with git repository and lost works due
> carelessness. This includes reset a branch instead of other, drop the
> stash etc by mistake. I wonder, is there way to a get an interactive
> confirmation prompt (which ask for yes/no option) before executing those
> commands when users can possibly lose their work? Like, some UNIX
> commands have support for an interactive prompt (like 'rm -i', 'mv -i',
> 'cp -i', etc) for ex: before deleting and overwriting a file a
> confirmation is prompt and asking for users permission.
> 	If there would no such feature available in git, so how do other people
> avoid these kind of mistakes? Obviously, one them would be recheck the
> command carefully before executing it and repo status but, I think
> sometimes people also do these kind of mistakes. For now, to minimize
> some of these kind problems I've modified my bash shell prompt to show
> all kind information related to a git repository by sourcing
> "git-prompt" script (provided with git package) and turn on all of flags
> provided by it which significantly increase my productivity and less
> mistakes than earlier. But, anything else I can do to avoid these kind
> of mistakes at first place or increase my productivity (it includes
> adopting some best practices, using some command line tools etc).
>   	I searched it on the Internet and found that there are many GUI tools
> available which help with these problems but don't want to use GUI tools
> because most of time I work in command line environment and love using
> command line tool than GUI one.
 
On top of Jeff's great answer, I'll add that I try to not keep my work 
local for too long. I usually push out changes, even when they are WIP, 
to a fork kept on a server somewhere (GitHub for my personal projects). 
This way, if I mess up something real bad, I can clone the repo from the 
server and recover my work, at least partially.

[snip]

-- 
Regards,
Pratyush Yadav
