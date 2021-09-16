Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAFAC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B09611CA
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbhIPWw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:52:28 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:6380 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241276AbhIPWw1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 18:52:27 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 834711B712;
        Fri, 17 Sep 2021 00:51:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 88F451B711;
        Fri, 17 Sep 2021 00:51:04 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G9z4lCjAV4je; Fri, 17 Sep 2021 00:51:04 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id B95631B5A4;
        Fri, 17 Sep 2021 00:51:02 +0200 (CEST)
Subject: Re: [PATCH] Document `rebase.forkpoint` in rebase man page
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <xmqqtuikrzca.fsf@gitster.g>
 <20210916223528.2910292-1-wesley@schwengle.net>
 <20210916223528.2910292-2-wesley@schwengle.net> <xmqq4kakrvdc.fsf@gitster.g>
From:   Wesley Schwengle <wesley@schwengle.net>
Message-ID: <287f826e-8fde-2c9a-ba66-a0a96e488b9c@schwengle.net>
Date:   Thu, 16 Sep 2021 18:50:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kakrvdc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=LbpCFQXi c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=IkcTkHD0fZMA:10 a=7QKq2e-ADPsA:10 a=-POwkhUqAAAA:8 a=N3miCFJ7AAAA:8
        a=GGnR3VJ_HTS8fPp_C64A:9 a=QEXdDO2ut3YA:10 a=aaQNY_TaMhQA:10
        a=5NxO59_FqQjEf5CpAN6O:22 a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/16/21 6:47 PM, Junio C Hamano wrote:
> wesley@schwengle.net writes:
> 
>> From: Wesley Schwengle <wesley@opperschaap.net>
>>
>> The option exists and the rebase behaviour tricked me into thinking
>> there was a bug with git. This will tell people how they can tweak the
>> default behavior.
> 
> So this still does not explain what rebase behaviour tricked you
> into thinking so.  That leaves the readers of "git log" frustrated,
> much more than a log message based only on a simple statement of
> fact, e.g.
> 
>      "git config --help" describes rebase.forkpoint as a way to give
>      the default value for --[no-]forkpoint option, but "git rebase
>      --help" does not mention it.
> 
>      Help people who visits the documentation of "rebase" to find the
>      variable.
> 
> or something like that.

I made a booboo. I did not run format-patch with the updated commit 
message and commit. I saw it too late. You should have a new one by the 
time you read this :)

Cheers,
Wesley


-- 
Wesley Schwengle
E: wesley@schwengle.net
