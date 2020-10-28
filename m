Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198A4C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FD620790
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgJ2AeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:34:24 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:42400 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbgJ1WUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:20:35 -0400
Received: from client3368.fritz.box (i5C74478B.versanet.de [92.116.71.139])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 531433C01DA;
        Wed, 28 Oct 2020 18:34:21 +0100 (CET)
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
 <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
 <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
 <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
 <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
Message-ID: <f4c942e1-6ac0-6caf-cbc7-d25a73b749fa@haller-berlin.de>
Date:   Wed, 28 Oct 2020 18:34:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.10.20 17:31, Felipe Contreras wrote:
> On Wed, Oct 28, 2020 at 3:09 AM Stefan Haller <lists@haller-berlin.de> wrote:
>>
>> On 28.10.20 1:06, Felipe Contreras wrote:
> 
>>> I didn't say the users didn't get the scripts from the distribution, I
>>> said I didn't know of anyone that did. I just checked the installation
>>> instructions of Homebrew, and they do seem to install the zsh
>>> completion from contrib, whoever, by the time I see the bug reports,
>>> those users already downloaded the most recent version from GitHub
>>> [1].
>>
>> I might not be the representative zsh user, but just as one data point:
>> I have never downloaded the completion scripts from anywhere. I always
>> use the one that comes with my "distro" (which is the Mac git installer,
>> most of the time, which puts it in /usr/local/git/contrib/completion/).
>> I symlink that to ~/.zfunc/_git.
> 
> That's interesting. Where did you get the idea to do that?

 From the documentation in git-completion.zsh. I must have set this up 
at a time where the documentation was still correct (i.e. before it got 
broken in <https://github.com/gitster/git/commit/176f5adfdb01a>.

-Stefan
