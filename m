Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224A91F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 06:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfKRGvo (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 01:51:44 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:60828 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfKRGvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 01:51:43 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47Gfkj4RtCz5tlb;
        Mon, 18 Nov 2019 07:51:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9DEDF2093;
        Mon, 18 Nov 2019 07:51:40 +0100 (CET)
Subject: Re: working directory status
To:     Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com>
 <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
 <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org>
 <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
 <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org>
 <CACKP9csUwnYJFL55KSMmys+o7FC5Wzds_2kbCcYNESiL-SES1A@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <31883f6f-7b5a-a2aa-951d-51f9eee6f68d@kdbg.org>
Date:   Mon, 18 Nov 2019 07:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CACKP9csUwnYJFL55KSMmys+o7FC5Wzds_2kbCcYNESiL-SES1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.11.19 um 05:32 schrieb Sivanandan Srilakshmanan:
> Hi Hannes,
> 
> Thank you so very very, very much for your guidance.
> 
> My team and I maintain multiple projects, each with it's own remotely
> hosted git repository.
> 
> I was reluctant to create clones of each project on my local machine
> each with it's own "main working tree"
> 
> I figured:-
> 
> I could setup a "Local bare repository" and create remote link to the
> hosted git repositories.
> (https://git-scm.com/docs/git-worktree#_list_output_format)
> 
> Create "Local branches" when needed. Create a "linked working tree"
> associated with the local branch.
> 
> Clean up the linked working tree when work is complete.
> 
> 
> 
> This way I can have a single repository pointing to multiple remote
> repositories on one side and managing multiple local directories on my
> PC.
> In summary, my local repository will be conduit. I guess this is not possible.

I think it is possible. Just don't make it a bare repository if you need
to create secondary worktrees. (But maybe it even works if it is bare;
just don't set GIT_DIR; I don't do it this way, so I cannot tell.)

> Based on my requirement would you suggest the best approach would be
> to create git clone for each remote repository?

That is probably easier.

-- Hannes
