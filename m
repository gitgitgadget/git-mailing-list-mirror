Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F96D20986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbcJDUbP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:31:15 -0400
Received: from mout.web.de ([212.227.17.11]:49250 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbcJDUbO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:31:14 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Ljaiq-1bKfWH1v2m-00bc3a; Tue, 04 Oct 2016 22:31:09
 +0200
Subject: Re: [PATCH 1/3] add QSORT
To:     Kevin Bracey <kevin@bracey.fi>,
        GIT Mailing-list <git@vger.kernel.org>
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
 <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
 <83398160-555f-adab-6b1e-3283c533b5ff@web.de> <57F290DC.5080303@bracey.fi>
 <9ff725eb-3536-638b-1ec0-ff9130478abc@web.de> <57F33E12.4020900@bracey.fi>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <29d3dde0-c527-3ab8-914c-6fbdc5e81e1c@web.de>
Date:   Tue, 4 Oct 2016 22:31:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <57F33E12.4020900@bracey.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JMDywi4GejnyJgwi+QMjZgGzKxLAJWlxV77NoM6iHATyHTIaPbQ
 JrkTQDfTEcDQ+uU7YncYSDXO3WD+84gzZN6GoeSZOJZMZHN1DvDn+AlSdrjm59MNw8hcMwI
 yxvBxkno2Dr3niXoxzbTtaIBSodg/PvQZr3E5PRxfVyeSDDm1lqpex2vwwgAbIoB9UkSco1
 t4IlD2HGYVnVQGKuOLQNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LRX1xXCh9BE=:ZGGMm2esp5SraRLUb+zby4
 Juj4osn0HHixMsj/t8ocMlN/AgilDC69B0iYkHvAxCbWa5Q6wYSbK3HVDXn2I/mqC1jQ5wI/N
 TutSMUONbUkJUyf+W4NhWAdITygyLLjxFGB96tGVntgKVZwxdXYciQYnSJOQERI+r/mH7oxIp
 25tyIdNi4AJxKaHj4+MAAxUlVQR+v8RE6Wmhqr7KEmWdyIz2NDZI1xqkSDFK3qTCli60iEARg
 1WWLtGqa9UhFNxvqsYvtqhf6vKwL4942lp4JeAcH/wQrSWGcdKophxmZJrZHG9rkOsJhNzV/L
 UCNdkF5PplXlQsq70pEtif45LV4sLHyQUDzl63e0X7TCDZOgzj7/5yyN+qBbwaXkAtcMb12JS
 hyZ/QnRScqI0XydvvozxIXd0SEqAskFJxak5F7F9B4sTFPn0fDbdYvVTHE7TiDIbcGcrZ8DSA
 VR+fbzgxX13hzvDHh8ZzDhPlV/8MOO3j/NME/KDiFTdp/zQ8ewfWWjMForv6guLtL2t4xFrko
 e+pBe39PVU/BpCQL4oUc0ETPzh9F8u+WCQmqkzx9ry4ZAF9a0EeO8cZCiWGxCmoIWunMPO3Gs
 Qe5F5XW29dIkiC8Fq00/eiuxkvvGybdmGydhTb1Kl3yCyB9/zG/X19Ag/NkSckkoDD5Y+IeCD
 dKfSiLNIw1fNwN6sEbNZiD46TJPKDhQPH7BWz3Gd9Bk7ltmSAYKknjAzlWLGH3XUgCk0veMcf
 O2BiO+fKHts2n0FBc+pxV7MjVKmrvaiRbncOINBpmA/QpYqAFjp+HoXuUy3m0zQg00tFGsjc9
 MsBwQ1V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.2016 um 07:28 schrieb Kevin Bracey:
> On 04/10/2016 01:00, René Scharfe wrote:
>> Am 03.10.2016 um 19:09 schrieb Kevin Bracey:
>>> As such, NULL checks can still be elided even with your change. If you
>>> effectively change your example to:
>>>
>>>     if (nmemb > 1)
>>>         qsort(array, nmemb, size, cmp);
>>>     if (!array)
>>>         printf("array is NULL\n");
>>>
>>> array may only be checked for NULL if nmemb <= 1. You can see GCC doing
>>> that in the compiler explorer - it effectively turns that into "else
>>> if".
>>
>> We don't support array == NULL together with nmemb > 1, so a segfault
>> is to be expected in such cases, and thus NULL checks can be removed
>> safely.
>>
> Possibly true in practice.
>
> But technically wrong by the C standard - behaviour is undefined if the
> qsort pointer is invalid. You can't formally expect the defined
> behaviour of a segfault when sending NULL into qsort. (Hell, maybe the
> qsort has its own NULL check and silently returns!

A qsort(3) implementation that doesn't segfault is inconvenient, but 
still safe.  I'm more concerned about NULL checks being removed from our 
code.

> So if it's not a program error for array to be NULL and nmemb to be zero
> in your code, and you want a diagnostic for array=NULL, nmemb non-zero,
> I think you should put that diagnostic into sane_qsort as an assert or
> something, not rely on qsort's undefined behaviour being a segfault.
>
>     sane_qsort(blah)
>     {
>          if (nmemb >= 1) {
>              assert(array);
>              qsort(array, nmemb, ...);
>          }
>     }
>
> Can't invoke undefined behaviour from NULL without triggering the
> assert. (Could still have other invalid pointers, of course).

We could do that, but I think it's not necessary.  We'd get a segfault 
when accessing the sorted array anyway.  (If we don't look at the data 
after sorting then we can get rid of the sorting step altogether.)

> Usually I am on the side of "no NULL checks", as I make the assumption
> that we will get a segfault as soon as NULL pointers are used, and those
> are generally easy to diagnose. But seeing a compiler invoking this sort
> of new trickery due to invoking undefined behaviour is making me more
> nervous about doing so...

I was shocked a bit myself when I learned about this, but let's not 
panic. :)

>>> To make that check really work, you have to do:
>>>
>>>     if (array)
>>>         qsort(array, nmemb, size, cmp);
>>>     else
>>>         printf("array is NULL\n");
>>>
>>> So maybe your "sane_qsort" should be checking array, not nmemb.
>>
>> It would be safe, but arguably too much so, because non-empty arrays
>> with NULL wouldn't segfault anymore, and thus become harder to
>> identify as the programming errors they are.
> Well, you get the print. Although I guess you're worrying about the
> second if being real code, not a debugging check.

Yes, but the optimization is valid: If nmemb > 0 then array can only be 
NULL if we have a bug, and then we'd get a segfault eventually.  So such 
checks can be removed safely.

> I must say, this is quite a courageous new optimisation from GCC. It
> strikes me as finding a language lawyer loophole that seems to have been
> intended for something else (mapping library functions directly onto
> CISCy CPU intrinsics), and using it to invent a whole new optimisation
> that seems more likely to trigger bugs than optimise any significant
> amount of code in a desirable way.

Yeah, and the bugs triggered are quite obscure in this case.  But having 
richer type information and thus restricting the range of possible 
values for variables *can* enable useful optimizations.

> Doubly weird as there's no (standard) language support for this. I don't
> know how you'd define "my_qsort" that triggered the same optimisations.

The nonnull attribute is a GCC extension, but it's also supported by clang:

   http://clang.llvm.org/docs/AttributeReference.html#nonnull-gnu-nonnull

I don't know if other compilers support it as well, or if there are 
efforts underway to standardize it.

> I've seen similar
> library-knowledge-without-any-way-to-reproduce-in-user-code
> optimisations like "malloc returns a new pointer that doesn't alias with
> anything existing" (and no way to reproduce the optimisation with
> my_malloc_wrapper). But those seemed to have a clear performance
> benefit, without any obvious traps. Doubtful about this one.

Still we have to deal with it..

So let's summarize; here's the effect of a raw qsort(3) call:

array == NULL  nmemb  bug  QSORT  following NULL check
-------------  -----  ---  -----  --------------------
             0      0  no   qsort  is skipped
             0     >0  no   qsort  is skipped
             1      0  no   qsort  is skipped (bad!)
             1     >0  yes  qsort  is skipped

Here's what the current implementation (nmemb > 1) does:

array == NULL  nmemb  bug  QSORT  following NULL check
-------------  -----  ---  -----  --------------------
             0      0  no   noop   is executed
             0      1  no   noop   is executed
             0     >1  no   qsort  is skipped
             1      0  no   noop   is executed
             1      1  yes  noop   is executed
             1     >1  yes  qsort  is skipped

With the micro-optimization removed (nmemb > 0) the matrix gets simpler:

array == NULL  nmemb  bug  QSORT  following NULL check
-------------  -----  ---  -----  --------------------
             0      0  no   noop   is executed
             0     >0  no   qsort  is skipped
             1      0  no   noop   is executed
             1     >0  yes  qsort  is skipped

And with your NULL check (array != NULL) we'd get:

array == NULL  nmemb  bug  QSORT  following NULL check
-------------  -----  ---  -----  --------------------
             0      0  no   qsort  reuses check result
             0     >0  no   qsort  reuses check result
             1      0  no   noop   reuses check result
             1     >0  yes  noop   reuses check result

Did I get it right?  AFAICS all variants (except raw qsort) are safe -- 
no useful NULL checks are removed, and buggy code should be noticed by 
segfaults in code accessing the sorted array.  So the advantage of the 
current code is that it won't call qsort for nmemb <= 1.  And the 
advantage of checking the pointer is that the result of that check can 
be reused by later checks.  I think the former is more useful, but only 
slightly.

René
