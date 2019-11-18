Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400AF1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 10:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRK7h (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 05:59:37 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:53911 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRK7h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 05:59:37 -0500
Received: from localhost (unknown [1.186.12.29])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1D0BE24001D;
        Mon, 18 Nov 2019 10:59:34 +0000 (UTC)
Date:   Mon, 18 Nov 2019 16:29:31 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Please provide a one-liner for syncing with the original/source
 project
Message-ID: <20191118105931.kslaxyniesbzjauo@yadavpratyush.com>
References: <CAH8yC8m45JGwjd-vRaE-05=MmDHq4qxWBh-wtsK09xuW+mp3mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8m45JGwjd-vRaE-05=MmDHq4qxWBh-wtsK09xuW+mp3mg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/11/19 03:56PM, Jeffrey Walton wrote:
> Hi Everyone,
> 
> One of my common workflows is, clone a open source project like Git,
> OpenSSL, etc. Then make some changes and push my changes to my clone.
> And maybe submit a pull request to the original/source project. After
> the initial clone my project becomes out-of-sync with the project of
> interest.
> 
> I have to do something special to get my copy of the project back
> in-sync with the original/source project. It is not trivial to get
> back in sync. It takes three or four separate commands if all goes
> well. And in my case, I have to look up the instructions because they
> are not ingrained in memory (like
> https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork).

FWIW, these multiple steps can be replaced by 'git pull upstream 
master', assuming you have 'master' checked out locally.
 
> This sync workflow is so common Git should be providing it. Anyone who
> has cloned from GitHub, GitLab, etc needs it. Folks should not need to
> do special things for common workflows. When sites like GitHub and
> GitLab are providing explicit instructions to sync with the
> original/source project should signal it is common and people need it.
> 
> I'd like a one-line command to resync with the original or source
> project (and not my clone). I think a 'git sync' command would be a
> good addition to the Git tools.

What would 'git sync' do that 'git pull upstream' or 'git pull --rebase 
upstream' can not do?
 
> It would be nice if sites like GitHub would value add the ' upstream =
> ...' to a .git/config, but that is not Git's problem. I'll settle for
> manually adding upstream so 'git sync' just works.
> 
> Thanks in advance.

-- 
Regards,
Pratyush Yadav
