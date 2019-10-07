Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF631F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 22:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfJGWFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 18:05:53 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17337 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbfJGWFx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 18:05:53 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iHb8Z-0005lt-BF; Mon, 07 Oct 2019 23:05:51 +0100
Subject: Re: Git Gui: Branch->create currently fails...
From:   Philip Oakley <philipoakley@iee.email>
To:     Git List <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>
References: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
Message-ID: <b7316273-3b91-a2a7-351e-490d920763ec@iee.email>
Date:   Mon, 7 Oct 2019 23:05:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/2019 23:02, Philip Oakley wrote:
> I'd never used the Branch:Create before (this is via mouse) and it 
> threw an error, which appears to be repeatable, so I'm reporting it at 
> the moment so I don't forget ...
> (I'm chasing down other issue at the moment ;-)

Forgot to mention, this was in a worktree looking at MSVC git.sln 
compilation to the side of the main git.git repo, which may be a 
possible contributor.

>
> This is with the version 0.21.GI git version 2.23.0.windows.1 Tcl/Tck 
> 8.6.9
>
>
> missing "
> missing "
>     while executing
> "list "refs/heads/redo-v0" [list ""
>     ("eval" body line 1)
>     invoked from within
> "eval $line"
>     (procedure "_new" line 87)
>     invoked from within
> "_new $path 0 $title"
>     (procedure "::choose_rev::new" line 2)
>     invoked from within
> "::choose_rev::new $w.rev [mc "Starting Revision"]"
>     (procedure "branch_create::dialog" line 35)
>     invoked from within
> "branch_create::dialog"
>     (menu invoke)
>
>

