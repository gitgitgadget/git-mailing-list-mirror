Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756B31F744
	for <e@80x24.org>; Tue, 12 Jul 2016 05:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbcGLF0T (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 01:26:19 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:49732 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbcGLF0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 01:26:18 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rpVn42zjRz5tlG;
	Tue, 12 Jul 2016 07:26:16 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B76A352D1;
	Tue, 12 Jul 2016 07:26:15 +0200 (CEST)
Subject: Re: git push doesn't update the status with multiple remotes
To:	Garoe <garoedp@gmail.com>
References: <5783CF57.1010105@gmail.com>
From:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org
Message-ID: <84c1ac72-cbe7-7490-2c61-9302703cb28b@kdbg.org>
Date:	Tue, 12 Jul 2016 07:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <5783CF57.1010105@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 11.07.2016 um 18:54 schrieb Garoe:
> I have a repository on github, a clone on my desktop and bare repo on a
> private server, in my desktop the remotes looks like this
>
> all    git@github.com:user/repo.git (fetch)
> all    git@github.com:user/repo.git (push)
> all    user@server.com:user/repo.git (push)
> server    user@server.com:user/repo.git (fetch)
> server    user@server.com:user/repo.git (push)
> origin    git@github.com:user/repo.git (fetch)
> origin    git@github.com:user/repo.git (push)
>
> If I commit to master in my desktop and run 'git push all master', the
> github and the server repos are correctly updated, but if I run 'git
> status' the message says:
>
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)

But "all" and "origin" are different remotes. Just because you use the 
same URL does not make them the same remote repository from the view of 
your local repository.

(Additionally, "all" is not a special name, just in case you had 
expected that.)

> The message won't update unless I run git fetch or git push origin master.

Yes, that's how it is supposed to work.

I think there is some way to configure that a single push command pushes 
to several remote repositories, but I can't find it right now...

-- Hannes

