Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F1E215F4
	for <e@80x24.org>; Tue,  1 May 2018 14:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755100AbeEAO6V (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 10:58:21 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:30857 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754907AbeEAO6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 10:58:20 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40b4KQ2DpQz5tlB;
        Tue,  1 May 2018 16:58:18 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 936FA1C92;
        Tue,  1 May 2018 16:58:17 +0200 (CEST)
Subject: Re: js/no-pager-shorthand [was: What's cooking in git.git (Apr 2018,
 #04; Mon, 30)]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
 <918c69be-89ce-c66d-92ee-4821e9412793@kdbg.org>
 <nycvar.QRO.7.76.6.1805011351330.79@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5cd81e58-7cd4-f5df-14e8-2ba3d221e128@kdbg.org>
Date:   Tue, 1 May 2018 16:58:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805011351330.79@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.2018 um 13:57 schrieb Johannes Schindelin:
> Hi Hannes,
> 
> On Mon, 30 Apr 2018, Johannes Sixt wrote:
> 
>> Am 30.04.2018 um 05:25 schrieb Junio C Hamano:
>>> * js/no-pager-shorthand (2018-04-25) 1 commit
>>>    - git: add -N as a short option for --no-pager
>>>
>>>    "git --no-pager cmd" did not have short-and-sweet single letter
>>>    option. Now it does.
>>>
>>>    Will merge to 'next'.
>>
>> I consider your argument that -N is only an abbreviation for an unspecific
>> "no" a valid one. So, I would like to be sure that we are not painting us into
>> the wrong corner by squatting -N for --no-pager.
>>
>> I find -P is not that bad after all.
> 
> To me, `-P` would suggest the positive action --pager rather than the
> negative --no-pager.
> 
> I wonder whether `-!p` would be better/feasible?

We do not have this pattern, yet, nor do I know it from some other 
utility. I do not want to set a precedent.

> Your use case is quite the corner case, I hope you realize that, as it
> seems that everybody else is fine with having -FRX as default options for
> `less`... And with copy/pasting from the `less` output. So introducing a
> sweet short option for --no-pager, for the benefit of maybe even only one
> user, seems quite... unusual.
> 
> Granted, you cannot simply introduce an alias for `git --no-pager`. But
> maybe that is what we should do? Maybe we should start supporting aliases
> without specifying commands, opening the door for things like `git -c
> ui.color=false`, too.
> 
> Then you could add `alias.n=--no-pager` and call `git n show HEAD`, and
> the -N and -P short options could still wait for a widely-popular option
> to require a short name.

But then I can just as well have alias gitn='git --no-pager' in my 
.bashrc. Maybe I should do that.

Given the ambivalence (or inconclusiveness), I retract this patch 
without offering a replacement for the time being.

Thanks for a bit of sanity,
-- Hannes
