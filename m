Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE11207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 18:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdFZSb7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 14:31:59 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35460 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdFZSb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 14:31:58 -0400
Received: by mail-wm0-f54.google.com with SMTP id w126so5142170wme.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hjNR/ajZXubUgSNkiQB3rJStzkEsXD8lQ6tEFOqS8Xk=;
        b=DEw7GG0tGWopucLUc7RoiMEdSiRYuJUubkPQ56pYF8OV7G4vNr2GpMZ2Z+Qb1qLCcF
         CJgpYgfrloFAe0NuaUmPk1tzRagbEtmTSFXRRWI2tOU2LQuU1Pnl/mxNkhLCh3OC/UvV
         hevaxgOYX6prQ8kLv8lO/AINL+kO7qJCN0NtkaRzqwCGqKvGj6KHmVSSk50KfqfCrwlq
         AOflAr0q34VSys22ro2/QiUJes7DE8P3OflclvYKfO5QWIEj5Y97kYaj2LRnpsG03kQv
         GA+H5LZZxPye5mnnbYGAqgRiORsgi8hL5r6Cs5WiS88IYGUGBOxQQZ1VWWbi1bRoKd65
         r5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hjNR/ajZXubUgSNkiQB3rJStzkEsXD8lQ6tEFOqS8Xk=;
        b=AISk5RGBC2ahbAv3WLpBHtlf/MLMoO7HaG+AiZPST7HXMza+VnWDvD4uponDiUAQ6V
         bFNDPK1HqYtzG9noNddq7QiidVQCR2vOl8WU9A/cviJdZ7Vs+r/wDi68QZOCA3sZ63sS
         8KdV83ZV5KTdWRixRF5rZhIssw3oeR/ZeX/hLsK29ptjyZcXOS3WHO4lKyyxdBKVIxFq
         qUcM5MBUPxDTPITk6HjHhf5k39SWICNOGs7NG3r1DRxMusj/EDayKHdvdExt2YUsTBO/
         OdfVArEAA0YXgIACpjDNxMns3Y/AKGsGj4sqpXq1TP3o7Y1KasKhp/tPTk7pQifxRdDJ
         4jAg==
X-Gm-Message-State: AKS2vOz6nJPbEeWEf6OLRsYAQxLsMXCEymEZEBvC1Oj8o9TH8azNv07A
        JRqjDrJgf8RpUg==
X-Received: by 10.28.198.66 with SMTP id w63mr596895wmf.110.1498501916442;
        Mon, 26 Jun 2017 11:31:56 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id t204sm453846wme.2.2017.06.26.11.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 11:31:54 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPYni-00020L-5L; Mon, 26 Jun 2017 20:31:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Kebe <michael.kebe@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <87lgofcf7r.fsf@gmail.com> <CAKKM46syoE90y-+5okxtk7A982ztaDFem8aL6GrxWhS4gGSGqg@mail.gmail.com> <87h8z2dig8.fsf@gmail.com> <CAKKM46s25LA+ywu_W5fyTaZ-r+3VyURptaa6whZsonzggQV-+g@mail.gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAKKM46s25LA+ywu_W5fyTaZ-r+3VyURptaa6whZsonzggQV-+g@mail.gmail.com>
Date:   Mon, 26 Jun 2017 20:31:54 +0200
Message-ID: <87h8z27g85.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 26 2017, Michael Kebe jotted:

> Still no luck, with one or both patches.

Could you please attach (or pastebin or whatever) your copy of
/usr/include/sys/isa_defs.h? And what Solaris/Illumos/Whatever version
is this?

Maybe this patch works for you:

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index facea1bb56..4f747c3aea 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -36,17 +36,19 @@
 #undef SHA1DC_BIGENDIAN
 #endif
 
-#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
+#if (defined(BYTE_ORDER) || defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || \
+     defined(__BYTE_ORDER__))
 
-#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
-     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
+#if ((defined(BYTE_ORDER) && defined(BIG_ENDIAN) && (BYTE_ORDER == BIG_ENDIAN)) || \
+     (defined(_BYTE_ORDER) && defined(_BIG_ENDIAN) && (_BYTE_ORDER == _BIG_ENDIAN)) ||   \
+     (defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
+     (defined(__BYTE_ORDER__) && defined(__BIG_ENDIAN__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
 #define SHA1DC_BIGENDIAN
 #endif
 
 #else
 
-#if (defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN) || defined(__BIG_ENDIAN__) || \
+#if (defined(BIG_ENDIAN) || defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN) || defined(__BIG_ENDIAN__) || \
      defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || \
      defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
      defined(__sparc))


Make sure to run the test suite after that, because it may compile but
not diagnose you as Big Endian if it doesn't work, thus failing horribly
on runtime.

> Greetings
> Michael
>
> 2017-06-26 14:47 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
>>
>> On Mon, Jun 26 2017, Michael Kebe jotted:
>>
>>> No luck with the patch.
>>>
>>> Still got:
>>>
>>>     CC sha1dc/sha1.o
>>> sha1dc/sha1.c:43:58: error: operator '==' has no right operand
>>>       (defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) ||   \
>>>                                                           ^
>>> gmake: *** [sha1dc/sha1.o] Error 1
>>
>> Does this patch change anything, with or without the previous patch:
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 047172d173..1327aea229 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -131,6 +131,14 @@
>>  # else
>>  # define _XOPEN_SOURCE 500
>>  # endif
>> +
>> +/*
>> + * Bring in macros defining _BIG_ENDIAN etc. Should be brought in by
>> + * the likes of stdio.h, but include it here in case it hasn't been
>> + * included already.
>> + */
>> +#include <sys/isa_defs.h>
>> +
>>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
>>        !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
>>        !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
>>
>>>
>>> Greetings
>>> Michael
>>>
>>> 2017-06-26 10:42 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
>>>>
>>>> On Mon, Jun 26 2017, Michael Kebe jotted:
>>>>
>>>>> When compiling 2.13.2 on Solaris SPARC I get this error:
>>>>>
>>>>>     CC sha1dc/sha1.o
>>>>> sha1dc/sha1.c:41:58: error: operator '==' has no right operand
>>>>>  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
>>>>>                                                           ^
>>>>> gmake: *** [sha1dc/sha1.o] Error 1
>>>>>
>>>>> The define _BIG_ENDIAN is set by Solaris on SPARC systems. So the
>>>>> check in line 41 gives this error.
>>>>>
>>>>> The _BIG_ENDIAN define is used few line below for defining
>>>>> SHA1DC_BIGENDIAN. This is needed for Solaris SPARC systems.
>>>>> See
>>>>> https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694a9ee1b79c24be45f9eab5ac0e1aeeaf271
>>>>
>>>> I can see why this would error out. In sys/isa_defs.h on SPARC there's
>>>> just `#define _BIG_ENDIAN`
>>>> (http://src.illumos.org/source/xref/illumos-gate/usr/src/uts/common/sys/isa_defs.h),
>>>> and (on Linux):
>>>>
>>>>     $ cat /tmp/test.c
>>>>     #define _FOO
>>>>     #define _BAR 1
>>>>     #if (_BAR == _FOO)
>>>>     #endif
>>>>     $ gcc -E /tmp/test.c
>>>>     # 1 "/tmp/test.c"
>>>>     # 1 "<built-in>"
>>>>     # 1 "<command-line>"
>>>>     # 31 "<command-line>"
>>>>     # 1 "/usr/include/stdc-predef.h" 1 3 4
>>>>     # 32 "<command-line>" 2
>>>>     # 1 "/tmp/test.c"
>>>>     /tmp/test.c:3:18: error: operator '==' has no right operand
>>>>      #if (_BAR == _FOO)
>>>>
>>>> What I don't get is how this would have worked for Liam then (see
>>>> 20170613020939.gemh3m5z6czgwmzp@oracle.com). Differences in Solaris
>>>> versions and how their headers look like?
>>>>
>>>> Does this patch fix it for you?
>>>>
>>>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>>>> index facea1bb56..0b75b31b67 100644
>>>> --- a/sha1dc/sha1.c
>>>> +++ b/sha1dc/sha1.c
>>>> @@ -36,9 +36,11 @@
>>>>  #undef SHA1DC_BIGENDIAN
>>>>  #endif
>>>>
>>>> -#if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
>>>> +#if (defined(BYTE_ORDER) || defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || \
>>>> +     defined(__BYTE_ORDER__))
>>>>
>>>> -#if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
>>>> +#if ((defined(BYTE_ORDER) && (BYTE_ORDER == BIG_ENDIAN)) || \
>>>> +     (defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) ||   \
>>>>       (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
>>>>       (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
>>>>  #define SHA1DC_BIGENDIAN
>>>>
>>>> I thought maybe BYTE_ORDER would work after searching the Illumos
>>>> sources a bit more:
>>>> http://src.illumos.org/source/search?q=BYTE_ORDER&project=illumos-gate
>>
