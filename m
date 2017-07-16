Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3331320357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdGPLcd (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:32:33 -0400
Received: from mout.web.de ([212.227.15.4]:62892 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdGPLcc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:32:32 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MODW0-1dcDZ401rw-005ZOQ; Sun, 16
 Jul 2017 13:32:22 +0200
Subject: Re: [PATCH] ls-files: don't try to prune an empty index
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
 <20170716104114.7tfcuilsy3ab74n6@sigill.intra.peff.net>
 <e91c204d-0bcb-9614-b62d-cd87c03b92e1@web.de>
 <20170716110831.c442ihan6tzf7gmn@sigill.intra.peff.net>
 <31e6bebd-f2f5-b85d-2865-49611aecb2b8@web.de>
Message-ID: <c408be84-c35f-bf3a-4699-9dd0b5de93ef@web.de>
Date:   Sun, 16 Jul 2017 13:32:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <31e6bebd-f2f5-b85d-2865-49611aecb2b8@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZHkFGE8QldyqImvpMkze7zWeiNuZ5ryJ3GTN9DMGrFqwGONNELP
 p2tlmDSGdfr9W+vUTjYI75tBGj2djdheWvKtsx/rWcUrIHEk+ZNkg7odMwehaL5abZqytmJ
 DylVn6fqN/H9dAX4WzH5u6dstntFZ0xEJl6K4RzU2rLg+eyrYHfvoQHG6gt0wY+rNGkj2ao
 PqW/w3/QUnvdGPYOapDpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NYXU9zpMzWs=:ApNdPlM8HfqbGm9si+M41e
 Ki5Cv3TdBCQTZ9wV2uB3zALdWTSuWlI71+zbJzPM9AlaT9gcjWz+Ytreg31eLl/TcO4ZiIavb
 RAk+MFmCar3VXwiEwvycm53R5Vizzm9pnXEFZNMWTgSM3BL8wtCZ8AvRvmaj/RDVvuLqnBzMs
 LzVav5Amhsh9yuAXmkOhNLVjXH/tJ5jziTHnM6uQ4OeQpG5ojBzEhtvL7H8z9ksRZ/cLFSuHL
 4oj3cfQC30IpR2pyF6MOi9Jolght2jH7bBf5fyLaMhYIb/6kq7jhopbd2jpX8cZKeOY2CViqk
 iYAYfBOwDdkznTRxWCK1DFNZ9EG4qpOtMc9Ry6fpcD13vXZ7umMwrOdjS1JF5kRBoxEf+aq7E
 ToinakmDLyxorQgq/F6JMlfMRhQ1RzOAI8vx6s7OXZFGQKysIQSXvHJePbT6sCc0A6NuqoYQq
 uSzf3yu/Oq2/owXj++Az7r8m4bNE0+caFf+ZDzMZn1rBEEnsSMxuXt2NHa1fnI3kusBRh2aZo
 tLnJkEjvNS8CSDBH2IXDdHaHh1snNqPH5ZCwIpH0MrHX+Enmgjf2ZuSz+Xg/63K61Si0sonHF
 CIc2N7+BB+TTJVloK5voPYzCRbv61jwbEOPCZtQWs0rum5gsg55H1zhsG3iL45U/kMkBAdvfX
 bLEquT6N9k4UXGxE66bDqlX6V4cg9/EER45SI8I526ZJijRHanP8ZBLnhb+26s2Cnft9aqPt4
 bu+nKCZFC3R3Bszx9Ks/Mf7UXpbA9FkEQcApPjhPy0+GSs1+/hHcSr/qjVrp05PFLkYeVghOY
 4vdHDmaok5ugGBSHZy8BnxOp75cO7jz4rFXOch9DzB2dh5Y3CQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 13:15 schrieb René Scharfe:
> Am 16.07.2017 um 13:08 schrieb Jeff King:
>> On Sun, Jul 16, 2017 at 01:06:45PM +0200, René Scharfe wrote:
>>
>>>>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>>>>> index b8514a0029..adf572da68 100644
>>>>> --- a/builtin/ls-files.c
>>>>> +++ b/builtin/ls-files.c
>>>>> @@ -362,7 +362,7 @@ static void prune_index(struct index_state 
>>>>> *istate,
>>>>>        int pos;
>>>>>        unsigned int first, last;
>>>>>
>>>>> -    if (!prefix)
>>>>> +    if (!prefix || !istate->cache_nr)
>>>>>            return;
>>>>>        pos = index_name_pos(istate, prefix, prefixlen);
>>>>>        if (pos < 0)
>>>>
>>>> "git am" complained that this does not apply to its blobs. Did you
>>>> hand-edit?
>>>
>>> I didn't, but perhaps I messed up the order of patches?  MOVE_ARRAY
>>> patch 2 touches the same file, but I wouldn't expect the two changes to
>>> conflict.  So not sure what's going on.
>>
>> For some reason there's an extra space before the tab on each of the
>> context lines. MUA issue or cut-and-paste, maybe?
> 
> That's possible.  Will resend.

... pressed Send to fast.  Thanks for reporting the broken patch!

I use the extension Toggle Word Wrap with Thunderbird, but it wraps by
default with no way to change that, so I forgot toggling this time.
Grr, I've had enough of this!  Went past the warranty warning and set
mailnews.wraplength=0 now.

René
