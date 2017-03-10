Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291C21FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbdCJSby (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:31:54 -0500
Received: from mout.web.de ([212.227.15.4]:61503 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755050AbdCJSbw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:31:52 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3BeZ-1bwEgB2Hhf-00sroM; Fri, 10
 Mar 2017 19:31:36 +0100
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Jeff King <peff@peff.net>
References: <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
 <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
 <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
 <20170310175719.cxol7d262n2rlcb2@sigill.intra.peff.net>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3a1cd5cf-cf13-7ef1-7b47-d4b083b64d11@web.de>
Date:   Fri, 10 Mar 2017 19:31:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170310175719.cxol7d262n2rlcb2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qk6EHdB4obAGLkGldGHbZJMDFJTq6tyDJV3r8e+oEoJN+10+NF7
 8cAq1cwTU1sgFQhsfAfoSe0OsHcRIzNx20dbP87zvaTjpPpwP1Ekp0guIdq84F3l3fICEFL
 vUzd4XNoKI9n6Gile6NBjfryk8ERzjuEVZUJmitM58qxAIZ/uVAE+/MJBpyMSLA/BmlK4I+
 AxvfM1MIH8PSj5XdO94wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fUk4j0NWiKI=:gWyXW6bw2NIdlUghwUYyXJ
 xdOaxcXAmMjGfJlqlwSo01+5nlLjVN+jlqzOPpRwXJBBeye0dF+ZVObxuPG59x56PS+SmWfqQ
 NSAMZUlrTpsAdjDbsKDW/PqUmYcLKXUyYk8DVPWjXTrzdvnz3UGqLXBVOi5lVh4iZpAWCQkSP
 gi2vkrRt2MrUo3w/rO52qCCzchOX69/lolBg6qF0lLIBh9hgwQZ0Q0tXReTHAbEFX9+syy9I4
 tqSHSq3GdQvUcSOz0JbVeJbPb1fyBwtYI1qaW4jxcsnlLmpzu7v2mvPd3Rd4cCNgDrs484HkO
 ixUGO5ukALwccpjcLqk2GFuY7hJ9dgtvczXcTrMY/Tgkt/McyIOTM5PduHJEIsU/QPk/pHpKS
 yLt8afchSRcHft29/Q5s9WmXtipJXz04DAYObGTHUhCUBOIvy2JJkL27gJq2rmoM1FCos/jfc
 sLW4o+JG4T6AkaOdFvQvOz3ph/VRhedZ5TB3x9mNUFfnCbd1PlIPgox5lcxFZMpHeSwcY7nGJ
 Nuii0EtapyCMKKq9Uo/3nDS5wBU2fefSpI8UCSyRYF5FhAbeoq0dZg/DhuwArUkl3c4U5GO7a
 ep88wzCaMAgyHLkBefzrbLS+HsoiG57RyfM5Rn4Np7ZQ9U5J/9r6aBWYMClYNScXSzjqJgUC4
 vITSuPY+RGFlYpJeuIbCLqbnP9c7lNZyB+/QsLDJHM/M8slYxfH4YeJUNwKJV8Wo6WxuS0Tqr
 AEO1D5BB7N4xs8h1p+7aCnBlq11je8IJYuyHuPSbN0oheN6WsGWU/CndZlBPqeWJeXVyU+P6s
 bXiXiQc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.2017 um 18:57 schrieb Jeff King:
> On Fri, Mar 10, 2017 at 05:20:13PM +0100, René Scharfe wrote:
>
>>> I think this misses the other two cases: (*dst, src) and (*dst, *src).
>>
>> ... and that's why I left them out.  You can't get dst vs. *dst wrong with
>> structs (at least not without the compiler complaining); only safe
>> transformations are included in this round.
>
> I don't think the transformation could be wrong without the original
> code being wrong.

Avoiding to introduce bugs with automatic transformations is essential, 
indeed -- if we're not careful here we'd be better off keeping the 
original code.

> I'm also not sure why mine would be unsafe and yours would be safe. It
> seems like the other way around, because mine will do:
>
>   *dst = ...
>
> which would fail unless "dst" is a pointer. Whereas in yours, we end up
> with:
>
>   dst = ...
>
> and somebody mistaking pointer assignment for a struct copy would not
> notice.

If dst is a struct then having *dst on the left-hand side results in a 
compiler error -- you can't get that one wrong.  If it's a pointer then 
both dst and *dst can be valid (pointer assignment vs. content copy), so 
there is the possibility of making a mistake without the compiler noticing.

> But either way, I don't think we can have a rule like "you can use
> struct assignment only if you don't have a pointer for the destination".
> That's too arcane to expect developers and reviewers to follow. We
> should either allow struct assignment or not.

With an automatic transformation in place it's more like "you can't use 
memcpy() in this case any more as it gets turned into an assignment with 
the next cocci patch".  I think we shouldn't be that restrictive for 
pointers as destinations (yet?).

René
