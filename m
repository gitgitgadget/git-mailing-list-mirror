Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E401F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 16:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfAOQJX (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 11:09:23 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:3317 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfAOQJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 11:09:23 -0500
Received: from [192.168.2.240] ([92.28.143.98])
        by smtp.talktalk.net with SMTP
        id jRHBgEiHgdJAejRHBgyqWG; Tue, 15 Jan 2019 16:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547568558;
        bh=25gL/0/vQM7x5QQ9AojIJL9wzl5RLcGbInLZIFLyMxc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nd9+8f4Nums8CI/k5N3xwDpaAfpqxi6aixZ0x4x2TJln76JEOyY1uYD2+bL1NEjR2
         kAKE9pU61V7WVR3Wcvx7P3iviCAwk1r6hQg+fwh3Lgotk2k/7x9B7wP/MZRX1kfW6k
         Ftf9sAC6qDcEnN6P99TJYv7ENoWYaKOPID8IPsEg=
X-Originating-IP: [92.28.143.98]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=j7EZ+OPOvdswaUU3zPu4lA==:117
 a=j7EZ+OPOvdswaUU3zPu4lA==:17 a=IkcTkHD0fZMA:10 a=69EAbJreAAAA:8
 a=ZtTNPPYqr0Aa3Dm4V94A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/7] Git.pm: introduce environment variable
 GIT_TEST_PRETEND_TTY
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
 <86d85face8ba543fb4a03adbc42dc930ee318f74.1545307756.git.gitgitgadget@gmail.com>
 <fd6bab55-871c-4f4d-84e9-98bfe5d54f23@talktalk.net>
 <nycvar.QRO.7.76.6.1901151448570.41@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <c3daa35c-5242-65f8-15ab-9b520812438f@talktalk.net>
Date:   Tue, 15 Jan 2019 16:09:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1901151448570.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPue699K7dry+uF9ZrdorW8YRB5ciNSXp7/h6qgy+FI9FlsJS1x8GgoamxP+Bcoo0T9tk+XqrfPwwynfI29lFUlfro6XzN5TVskFLzbjecSVelNEB5+s
 Q0kd/7632/y2Mm63ZLzZHEsoH3ZYelZNdz3Lapv8VubIIV3LLfTi9sD9M7zcy8aIpkh/H0lK1EcySIm5llgij4uAE65aX7LuE4gzd+KiqVAzXmgUrqcChpi1
 DcqsEiPafUJFM8n1nXlv/d5DuxFH1dYN5IdYG+rhtS6HjQcJr3yo1FxrOO2Ggx/OHpybP4WClX2ojSFwuDz2mXGSgXUO1r5vsswS7kynYF54Ps0pbTwrGPrS
 UEfV1neT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/01/2019 13:50, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 14 Jan 2019, Phillip Wood wrote:
> 
>> Hi Salvica/Johannes
> 
> Close ;-)

Sorry Slavica

> 
>> On 20/12/2018 12:09, Slavica Djukic via GitGitGadget wrote:
>>> From: Slavica Djukic <slawica92@hotmail.com>
>>>
>>> To enable testing the colored output on Windows, enable TTY
>>> by using environment variable GIT_TEST_PRETEND_TTY.
>>>
>>> This is the original idea by Johannes Schindelin.
>>
>> I normally use GIT_PAGER_IN_USE=1 to force colored output, is there some
>> reason that does not work here?
> 
> As Slavica found out, you need to set `TERM`, too, for that to work. And
> even then, it is more of a "happens to do what we want" rather than a
> "this is what we want to happen"...
> 
> But I'm fine either way, the color code does not really *need* more
> complexity, as it were...

Thanks for explaining, I didn't know the TERM needed to be set as well. 
If GIT_PAGER_IN_USE=1 works then maybe it is better to avoid adding any 
more complexity.

Best Wishes

Phillip

> 
> Ciao,
> Dscho
> 

