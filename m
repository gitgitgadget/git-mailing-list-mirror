Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF051F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 21:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbdAaVDj (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 16:03:39 -0500
Received: from mout.web.de ([212.227.15.4]:58682 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbdAaVDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 16:03:38 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkPW7-1c2LZW3Ch9-00cOOp; Tue, 31
 Jan 2017 22:03:17 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Brandon Williams <bmwill@google.com>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
 <20170130222157.GC35626@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
Date:   Tue, 31 Jan 2017 22:03:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170130222157.GC35626@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:L/T3lwaayZIh9jyJjOJCy4h0WILFWGvm9pDmoexNetSANCOaOk0
 561knpE1WpahLK5p2qBd2vcPB3IMmF3W/pHrzyvy4IfpF/HXy6UhO/UB5jiB3nBpIf54TOV
 FDVhx3Vu+r7RMyy8A2+DBRFD56QZhutR7GCherTnmYDLDomUTAxKjeByEakOx+DS05knoBS
 +00d8dxMvUaeoUR5EmEaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QIckudT48mM=://Dgy+8ftOAjqEmGpuXqDq
 LNx26wp37vO8SOyti1C7RAFcVNeqUNiB6n+bpp3ZUjrBXWGwNAJY22YirM0ggeKP3VkYxa9ls
 4PXG1UjiAI/vdPQEPua5jBif4QOOaHs//5pwgmgTSOS5qekyAuDxMJAO1rpL+uGCxO16rrvKE
 anEeukLfXOFkIVPJdW95W7UyHhcQPcoBBfnkm2XRVQvRNAWbXdX1KUNeXuOsNZUT2vpRytNtG
 nTnfUOuiRgnkT2iy8RuXQWOjMY3yGBEVv7w4gke4qRej5LIXuv7iTKT1yvHzziWg+TUgpNS7U
 HLkOhujD150l3WMHB/O6/aOaoYxCBFCJxrBFkslUWzbUDtZvS7wQ3kiZc4xru4/Dfn0c8yU6K
 wVMTL09dMOMNwXacQh9DRa/ozceDEMc0iPh90SzWO1lhAyU456ixLmBu9IrmIEbILsWeT+hnH
 U10LrU97aoORfqyO7OSqQ6kIRc8vp4FUPaa1FMfgyAcbjR1zwZqzW2n0xHsWP+vr7OIHBAaRg
 xSsHxfv9+JoGBTA+DgwbCFVFNj/qsnevNaWvJM8J8yKz/RXICMNPXJVHP6HwWAKehtsWruMo2
 Q3nMvdGJCEdWEP2xRedYJ0w9Lk06LFcdnAC04oqq6kQS0bWCeeTmd5vNNMeijjkKSopTHiRBP
 PFvAe8KniH+VB62AucrwTvrVMWipBENNXOS/knHKaKYKhFkTIGYW3WD6qJJgG5glvac3QQAz1
 DOezEQ+EX4qtJZVO7AiBNzBVuLT70i4plvo1McmgwHxpYxRG7X1Zy7Sus4k7nfWKpNYkeNZk+
 +xnjPPQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 23:21 schrieb Brandon Williams:
> On 01/30, René Scharfe wrote:
>> Am 30.01.2017 um 22:03 schrieb Johannes Schindelin:
>>> It is curious, though, that an
>>> expression like "sizeof(a++)" would not be rejected.
>>
>> Clang normally warns about something like this ("warning: expression
>> with side effects has no effect in an unevaluated context
>> [-Wunevaluated-expression]"), but not if the code is part of a
>> macro.  I don't know if that's intended, but it sure is helpful in
>> the case of SWAP.
>>
>>> Further, what would SWAP(a++, b) do? Swap a and b, and *then* increment a?
>>
>> That might be a valid expectation, but GCC says "error: lvalue
>> required as unary '&' operand" and clang puts it "error: cannot take
>> the address of an rvalue of type".
>>
>> René
>
> Perhaps we could disallow a side-effect operator in the macro.  By
> disallow I mean place a comment at the definition to the macro and
> hopefully catch something like that in code-review.  We have the same
> issue with the `ALLOC_GROW()` macro.

SWAP(a++, ...) is caught by the compiler, SWAP(*a++, ...) works fine. 
Technically that should be enough. :)  A comment wouldn't hurt, of course.

René
