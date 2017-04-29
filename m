Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9051FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969613AbdD2SQf (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 14:16:35 -0400
Received: from mout.web.de ([212.227.17.12]:52710 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969491AbdD2SQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 14:16:33 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1e2WSG3hYB-00yUT9; Sat, 29
 Apr 2017 20:16:19 +0200
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
 <070a4b85-98e0-12a4-6c9c-557f3dfa733c@web.de>
 <20170428214934.tuqihgch6qeen3ni@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <11699799-6bdf-484d-5a1c-8e8fa7981594@web.de>
Date:   Sat, 29 Apr 2017 20:16:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20170428214934.tuqihgch6qeen3ni@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LMad1AvfBfsw9qLj0dCBlVsFKIRDljGDQG96QkupU/78bmBMmat
 E5BBM01lr78183hp+xr6/zUBAabtVuXHiVWmm5eyIijHM7o1E7xK5BGFGCelb37mQ3bcnUo
 fTJVeTexq5kI7bIIpYHpK+DUBtZqfQ9T3bfX51GcmlBbVgot2Rx5yzwLl2unvcs1FLuqJdA
 43gzLrG9jqgvamgahyKFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CH3wXBqi93s=:wMQJsLSLHtr7MR4iBNaAIN
 AeJpLhFsSW2AKmlNF32kdaWOa9ZH1/nohGCfqgjxUrINXOnIowkyO/bF6mWH7WIHbGO+anhPq
 5AaQpmveL2EVx1IktzfTZ0fBOrtgXy8ZWgBDgw4faOEUVMQmYL5xnnQtTff98UjhqhvjUdBVH
 WdpX7q/ZDZHtA12xihqvcxGjaYelBRZ4+yth4JW31P5VvDsCIW3+ADldJKru3AWE9WkCmExeP
 28da+AMK7FSaTTw62KC7RH5xCJwryK2MH5vz1TrMFAxETW0gF/E2xQSO7lLMViuyFIvkY/8nr
 nvXF0nEH/ojSr1cfPS417LO70kz6HrUs8WKJalh88TgGzaOEOQbyqTkYHg/ka9Hgb2ae8y98M
 OMjvCM7MmxpHI9iunx/X7P64b3c2U1geyzESrJgzb3pyElGnb3EWedSOrI0Rag6dTk8LX4im0
 lhM3uk6beMc4dA2mFojgW5TOMPHDP8pjFqMH/Utl/KnEZLJHXhb8eFwQS2nnV6x81TCTz5ARJ
 91FZNWEL4SvezRkZVoUjWiQqQFcPDmjSZKmqZgomERI0DUTFnTTcVD0IXqxrunlgwWAyoPuF4
 zAYiptdNNx0jTITkCHACa15eeZZx9PuII0UoldIgrpTq7kbeHEDj3wOr72l441GEQt2pzHXhz
 FlnRWQWdOO0MjTwxiQVFlDyZLMspD2UfOBNf4ypHs+/qEimTFsQBiFtzgp3Hyfc00mMh+Ima4
 +wcgP0tcEQwloh/mSw29MA47SyhAVTp/8BrMxUgXynJjtvIEyYS6yrc5rboq6j1/nvjW+k0wm
 hl/k8iW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.04.2017 um 23:49 schrieb Jeff King:
> On Fri, Apr 28, 2017 at 07:04:51PM +0200, René Scharfe wrote:
> 
>>> What should:
>>>
>>>     SWAP(foo[i], foo[j]);
>>>
>>> do when i == j? With this code, it ends up calling
>>>
>>>     memcpy(&foo[i], &foo[j], ...);
>>>
>>> which can cause valgrind to complain about overlapping memory. I suspect
>>> in practice that noop copies are better off than partial overlaps, but I
>>> think it does still violate the standard.
>>>
>>> Is it worth comparing the pointers and bailing early?
>>
>> Hmm, so swapping a value with itself can be a useful thing to do?
>> Otherwise an assert would be more appropriate.
> 
> No, I doubt that it's useful, and it's probably a sign of a bug
> elsewhere. But it's likely a _harmless_ bug, so it may be irritating to
> die when we hit it rather than continuing.
> 
> I dunno. I could go either way. Or we could leave it as-is, and let
> valgrind find the problem. That has zero run-time cost, but of course
> nobody bothers to run valgrind outside of the test suite, so the inputs
> are not usually very exotic.

It would be  problematic on platforms where memcpy has to erase the
destination before writing new values (I don't know any example).

We could use two temporary buffers.  The object code is the same with
GCC around 5 and Clang 3.2 or higher -- at least for prio-queue.c.

With GCC 4.9.2 (that's what Debian stable currently has) the result is
actually slightly better with two buffers because a 128-bit move starts
to get used (https://godbolt.org/g/18HQDQ).

>> Swapping with *partial* overlap sounds tricky, or even evil.  If
>> we want to support that for some reason we'd have to use memmove
>> in the middle.  But that would still corrupt at least one of the
>> objects, wouldn't it?
> 
> Yes, the overlap case is probably an actual bug. Detecting it is a bit
> harder, but definitely possible. I hate to pay the run-time cost for it,
> but I wonder if a compiler could optimize it out.

How is it possible to arrive at such a situation?  We'd need two objects
of the same size (we check that in SWAP) and one of them would start
inside of the other one, i.e. the pointer difference between them would
be a fraction of 1.  So the type system would have to be tricked into
it, right?

How *would* we detect overlaps?  The obvious checks (a+len<=b||b+len<=a)
are undefined if applied to objects that don't belong to the same array.
And members of the same array would not overlap to begin with..

It may be my laziness speaking, but do we really need such a check?  If
someone constructs interleaving objects then they'd need to implement
the necessary checks themselves IMHO.

>> The line in question is this one:
>>
>> 	for (i = 0; i <= (j = (queue->nr - 1) - i); i++)
>>
>> Assignment in the middle?  Hmm.  Why not do it like this?
>>
>> 	for (i = 0, j = queue->nr - 1; i < j; i++, j--)
>>
>> Looks less complicated to me.
> 
> Yes, see my other reply. :)

Ah, so that's where I stole it from. ;)  Perhaps my source amnesia was
in part caused by confusion about your reasoning there: The code does A,
B would be better, so let's do C.  Wait, what? :)

René
