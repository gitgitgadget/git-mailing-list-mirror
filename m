Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CD71F424
	for <e@80x24.org>; Wed,  9 May 2018 16:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935387AbeEIQev (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:34:51 -0400
Received: from mout.web.de ([212.227.15.14]:38117 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934806AbeEIQeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:34:50 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lr2I7-1ecBHw3mOR-00edlc; Wed, 09
 May 2018 18:34:47 +0200
Subject: Re: Can not save changes into stash
To:     KES <kes-kes@yandex.ru>, git <git@vger.kernel.org>
References: <6015131525872315@web37g.yandex.ru>
 <5718771525872436@web47o.yandex.ru>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7105a838-6c1f-97df-55c1-ea8312ddc9ab@web.de>
Date:   Wed, 9 May 2018 18:34:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5718771525872436@web47o.yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CTa7A2eHwqVdcAmkqOXfsw9MEEF/irqNRa1aJJuvnP9SPDX83lw
 tq9Xrm+pQOQ/fX0nMR57+SZ9HOagYcuTlHwGbXz0HwoCH52efeAs+CV0I9YXvUmUrxSP0nO
 bgX9Dg6Kx9D5pYeZioXKvwAGnV+LSHDKlFdr0zkLsw1YBfjf8cyXUNFPqfcZO7UNKtH0nM+
 FlFFCs4ovAMSyMEh45UFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HDssaXA3baU=:k0wm0v3bZBPJDet6Q39vHB
 7wACldT03zWR8Rb+TKDhJnm/0mW240cu4cLAZl/1S3PJeCU/y4lXn267LZ16FoQdY9f1PAyKv
 iAbp64k77V+JmEdkVASl7O0sv+fHdGEiEfZ/UAjxz7pw0suAVggjmoAW4z7PxTIAoHj5cFmBH
 GEi0fHD3LYhd0emd0S+NTymUu2ytGk5thGtmlWgf3MtHDq4JfGa+qYFh6mIfqgfYFcrlNl0zu
 VtcAwArZZ2l1cqCskZCz7XBVHmoeBns+1dhAnYTZvdTilu5h9+pbVKXFPE46qcCJqz5HrzWn2
 QF1TwrsURUmcPsJturbwKJgblvn/Ijk3rj3y1TpIcYgcH/4K7Mp0qXNe89yVS9lQ3tNT6gpGO
 2NXPHjPgyfAiTTun8M8Rm71bhcLMheygZATHxTsLeh9YD7Sa/k13s7l/yBT2I+8g53CqBVLJF
 YsfF67ZOhdHg+mt8VeUTB9J83RidhJ0MyH0kfEzyCiEAUL1gtcELggd0e463/6OiRXe5+Bnv6
 f0AfontXzxtI13vJf6bMszU1KD/lh5XZNRGCrAOjHpa4QkuUn86gt9CqyCLy5Cp2u9uHE31v3
 s9+ZdA+Fn6UeX5CUdoNOWZr4A3B3Q9Y2qEEhXwZ0GywXk+VVZ9KA/Chw+31w7eI73zDRCn2h/
 /3gngUjm+dEt/FotcS+M5wQ2Yp5JcbNfMVgcTo80XTy2oBKtl8RCk3uBLBPenoy20sWTEcRB1
 kKfgcGuFcmcTVsFqxFm5arLwvq0JQm0cvk70tFXlQqMg5Z54SPrt2XamyT4eaEqBkGnXGFdfP
 XGISVkG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Please no top posting here]
On 09.05.18 15:27, KES wrote:
> I even can not drop local changes:
> 
> $ git checkout local.conf 
> error: pathspec 'local.conf' did not match any file(s) known to git.
> 
> $ git log local.conf
> commit 6df8bab88fd703c6859954adc51b2abaad8f59ec
> Author: Eugen Konkov <kes-kes@yandex.ru>
> Date:   Wed May 9 15:31:02 2018 +0300
> 
>     Implement module which allow override target option
>     
>     Most usefull to configure application on developer host
> 
> 
It may be help, if we have some more information,
either to re-produce your issue or to help with debugging.

Is this a public repo ?
Which Git version do you use ?
Which OS (Linux, Mac OS, Windows anything else ?)
What does "git status" say ?
What does "git diff" say ?

> 
> 09.05.2018, 16:25, "KES" <kes-kes@yandex.ru>:
>> How to reproduce:
>>
>> $ git update-index --skip-worktree conf/local.conf
>> $ git pull
>> Updating 0cd50c7..bde58f8
>> error: Your local changes to the following files would be overwritten by merge:
>>         conf/local.conf
>> Please commit your changes or stash them before you merge.
>> Aborting
>> $ git stash save
>> No local changes to save

