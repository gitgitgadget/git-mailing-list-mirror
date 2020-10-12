Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF69C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F24520790
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgJLUzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:55:15 -0400
Received: from vimdzmsp-sfwd05.bluewin.ch ([195.186.120.133]:46725 "EHLO
        vimdzmsp-sfwd05.bluewin.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgJLUzP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2020 16:55:15 -0400
Received: from [192.168.0.38] ([178.82.236.236])
        by vimdzmsp-sfwd05.bluewin.ch Swisscom AG with ESMTPA
        id S4qfkZQVPHsy1S4qfkoaus; Mon, 12 Oct 2020 22:55:13 +0200
X-Bluewin-Spam-Analysis: v=2.3 cv=d6BuNSrE c=1 sm=1 tr=0
 a=HtqHOeZjyPUdB8xaH0hM2g==:117 a=HtqHOeZjyPUdB8xaH0hM2g==:17
 a=IkcTkHD0fZMA:10 a=cm5lg1vcKYtI4jKrJMoA:9 a=QEXdDO2ut3YA:10
X-Bluewin-Spam-Score: 0.00
X-FXIT-IP: IPv4[178.82.236.236] Epoch[1602536113]
X-Bluewin-AuthAs: cedricschwyter@bluewin.ch
Subject: Re: [PATCH 0/1] Alias 'list'-subcommands to 'ls'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20201012195335.189194-1-cedricschwyter@bluewin.ch>
 <xmqqblh7nqmu.fsf@gitster.c.googlers.com>
From:   Cedric Schwyter <cedricschwyter@bluewin.ch>
Message-ID: <39969c68-bc93-3524-ce9f-eef64936313d@bluewin.ch>
Date:   Mon, 12 Oct 2020 22:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqblh7nqmu.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCTn0NOvjXOMvS2G0OQb3fTo3NI598dstMH60oWPVFmH4nMx8z+IdkMQeYUn4neI3Xjtj2Ut2dj+sWZbUcYpJ1VwOOCILZJsYWqbbJhshxricErbPEZc
 G/U4Tbh8e9bfVmnenz96Y6CaDFnbyhELfNTJJy1xhYlqJg+6/Q43RgvT/xdt5KYkVxW/whCBKC035xUJXhEAuXWvyA/e57E7+rA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I am aware there are only "git ls-files", "git ls-refs", "git 
ls-tree", "git ls-remote" etc.

Yet I think this could be a nice little addition because I always catch 
myself using "ls" out of being used to it from everywhere else really.

On 10/12/20 10:19 PM, Junio C Hamano wrote:
> Cedric Schwyter <cedricschwyter@bluewin.ch> writes:
> 
>> Since many CLI-tools make use of this alias and many programmers are
>> used to it I thought I'd add it to git since I was missing such an alias.
> 
> Is there a "git somecmd" that allows "git somecmd ls" form, while
> these "git stash list", "git worktree list" subcommands take "list"
> and not "ls"?  If so, this change may make sense, but otherwise, not
> really.
> 
>>
>> I only added it to built-in subcommands for now, might add it to some
>> more commands in the future.
>>
>> Cedric Schwyter (1):
>>    subcommands: alias 'list'-subcommands to 'ls' where applicable
>>    docs: update docs with new alias
>>
>>   Documentation/git-bundle.txt          | 4 ++++
>>   Documentation/git-sparse-checkout.txt | 3 +++
>>   Documentation/git-stash.txt           | 5 +++++
>>   Documentation/git-worktree.txt        | 5 +++++
>>   builtin/bundle.c                      | 3 ++-
>>   builtin/sparse-checkout.c             | 3 ++-
>>   builtin/stash.c                       | 4 +++-
>>   builtin/worktree.c                    | 3 ++-
>>   8 files changed, 26 insertions(+), 4 deletions(-)
