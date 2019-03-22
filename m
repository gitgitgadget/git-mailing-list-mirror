Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE85520248
	for <e@80x24.org>; Fri, 22 Mar 2019 13:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfCVNTj (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 09:19:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:35023 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfCVNTi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 09:19:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AD8823F409B;
        Fri, 22 Mar 2019 09:19:37 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8D6423F4092;
        Fri, 22 Mar 2019 09:19:37 -0400 (EDT)
Subject: Re: git command history
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        balaji marisetti <balajimarisetti@gmail.com>
Cc:     git@vger.kernel.org
References: <CAKcrOwe2ARK4J6YuiXUiVXic=q568VC8JtgWMNs6WEd4hhZs3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1903221343090.41@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f52ef736-9d58-a6cf-e3b0-501b065ae325@jeffhostetler.com>
Date:   Fri, 22 Mar 2019 09:19:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1903221343090.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/2019 8:46 AM, Johannes Schindelin wrote:
> Hi Balaji,
> 
> On Tue, 19 Mar 2019, balaji marisetti wrote:
> 
>> Can anyone please tell me if there is way to see the command history
>> of a local git repo?
> 
> If you really are only interested in the *Git* commands, you will be able
> to implement something on top of the Trace2 feature (which just made it
> into `master` but not into any official Git version yet, so it will most
> likely be available when Git v2.22.0 comes out).
> 

Trace2 will let you see all of the git commands,
the alias expansions, and any shell commands launched
by git. If those shell commands also run git commands,
they will be listed too.

However, it can't tell you what was otherwise done within
the shell script.


> If you are instead interested in all shell commands in a local Git
> worktree (you probably meant the worktree, not the repository, I assume),
> then you might need to play some games with Bash aliases to override `cd`
> and reroute the history by re-setting `HISTFILE` and then calling `history
> -cr` or something similar.
> 
>> If there isn't a way, why hasn't the command-history feature been
>> implemented?
> 
> Because Git is an open source project. This means that nobody is
> responsible for fulfilling your wishes, except for you. And you can do it,
> too, this project welcomes all high-quality contributions.
> 
> Ciao,
> Johannes
> 
