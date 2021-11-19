Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347EAC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 21:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhKSVT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:19:57 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:21057 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234964AbhKSVT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 16:19:56 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1moBFc-0004kc-9Y; Fri, 19 Nov 2021 21:16:53 +0000
Message-ID: <d9cdb708-1cd1-03e1-ea17-4195faafda76@iee.email>
Date:   Fri, 19 Nov 2021 21:16:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] mergesort: avoid left shift overflow
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
 <7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email>
 <nycvar.QRO.7.76.6.2111191750400.63@tvgsbejvaqbjf.bet>
 <05e6c0ab-7364-56d8-f0b2-e93c11b327e3@iee.email> <xmqqlf1kosgp.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqlf1kosgp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/11/2021 19:28, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>>> My patches are in https://github.com/PhilipOakley/git/tree/oneU_t
>>> How about rebasing the remaining patches from
>>> https://github.com/git-for-windows/git/compare/main...PhilipOakley:oneU_t
>>> on top of `rs/mergesort` and then submitting them, to avoid duplicate
>>> efforts?
>>>
>> I'm not finding a `rs/mergesort` at the moment. Any particular remote I
>> should find it on, or maybe a different spelling?
>> P.
> At https://github.com/gitster/git/, I publish the "broken out"
> branches.
>
> But resurrecting the tips of the topics should be fairly easy.
>
> $ git log --first-parent --oneline origin/master..origin/seen |
>   grep rs/mergesort
>
> The second parent of that merge is the tip of rs/mergesort topic
> back when the 'seen' integration branch was created.
>
Thanks. I'd been browsing via `gitk` and hadn't included all the tips,
so couldn't find it at that point. I've got it now:  42c456ff81
(mergesort: avoid left shift overflow, 2021-11-16).

Philip
