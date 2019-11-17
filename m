Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D152A1F5A2
	for <e@80x24.org>; Sun, 17 Nov 2019 07:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfKQH3q (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 02:29:46 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36893 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfKQH3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 02:29:45 -0500
X-Originating-IP: 1.186.12.29
Received: from localhost (unknown [1.186.12.29])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 035C820003;
        Sun, 17 Nov 2019 07:29:43 +0000 (UTC)
Date:   Sun, 17 Nov 2019 12:59:42 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: working directory status
Message-ID: <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com>
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/11/19 11:55AM, Sivanandan Srilakshmanan wrote:
> Hi,
> 
> I am new to git. I have been reading the documentation on Pro Git.
> 
> I have checked out two working directory (test1 & test2) using the
> "git worktree add --checkout" command.
> 
> When I run the "git status" in either (test1 or test2) on the checked
> out folder, the "On branch <branch name>" displays the branch name
> from the latest checkout (ie branch associated with  test2).

This behaviour does not happen for me on Git v2.24.0. When I create 
multiple worktrees, 'git status' in each worktree directory shows the 
correct branch. What version of Git are you using?
 
> Could you please provide the correct syntax to display the branch name
> associated with the respective folder.

You can use 'git worktree list' to see a list of all the worktrees. The 
output of the list has 3 columns: path to the worktree, commit checked 
out, and the name of the branch checked out in that worktree.

Example output:

  $ git worktree list
  /home/pratyush/src/git  50b2267a2a [next]
  /home/pratyush/src/foo  50b2267a2a [foo]

The first worktree is in ~/src/git and has the branch 'next' checked 
out. The second is in ~/src/foo and has the branch 'foo' checked out.

That said, running 'git status' should still show you the correct branch 
name. Try updating Git to the latest version (v2.24.0), and try again.

-- 
Regards,
Pratyush Yadav
