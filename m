Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1D2A1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 21:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfKPViR (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 16:38:17 -0500
Received: from mout.web.de ([212.227.15.3]:49641 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfKPViR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 16:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573940295;
        bh=5aGEW+QUxZtjOUG1uLJQ5Vd6RAxgZcqfx4bM8HF2EFc=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=Uioe2U5UTaGPY6VVK50nxrR1s9vJuFm8XVdVOJhrtD5Omw0ymn7e8+B7Rhk+bIO7n
         QzCtDii8UCrEYGC9xl8F8M42Ztu++P72U/Bk3TDDA+m8kW4Gj6g8IdZo19KX3kb469
         5m3/J6VqcbjV/bYQiiLs/47ENa+aZXLrUrpkeq7w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFcDF-1ibqXi17Cv-00EfaZ; Sat, 16
 Nov 2019 22:38:15 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
Date:   Sat, 16 Nov 2019 22:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <05ab1110-2115-7886-f890-9983caabc52c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9AXr8Xi1BZYWU0ZJS4FJM4/SALhd6GuCcMPmFIUAxng7NEbPha
 CxZDPZGSyIY7njSOxfYDjLRHwEC0Hr8tnHmmNAnNUsIMrmw32dhd7gP7V7zz5ChatACfPAY
 VVGtv2z8s98Vs/I8qX5lUWS2yAIH5uylUJMVoMU1ONWBbdxj2RtZ+fJ7plTFAdR7OU9KFQb
 /8ZnO4IsX1GO3HEbKWDCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wmmp3vL3VLk=:Neq5ZJyrqS2XQc6+72mASv
 MA+o0nosvQg9bJWCFb41bzXQQFOgZEs44p5fkqM7kehhNED2pnri/qHybvh4kKwnXiUjDM4hu
 /ptKM1I9XkA2MrfJyLdn/Yc7RVMVrZNQwK2GX2/TLL6lxe4ZlwFxApMJCGt9K2WMPgWFaDtAp
 daT/dmbqckJcP6G0QzOsjlV4BmA3adUrLVzRyrJVdRp2vrMxzHNwbRlNWnQuV+8RO6+TU4Y0b
 04bXd9Cd6Q7d26yqwk4g1oHe/m/26VOheTK4ih08CP4k9z+yLg2GwMphgDaCrKLNPkOB0aVGL
 /veSS3o+DloxTQPEoaFbAwif5R2GlLCrPBGYU91EoNgPur8IqTpW8gQHSkufzZ7TEBR4ih8Y6
 ZOFbMTUfaQ0fd6LAMCYBx4vyFR7f5y9F8sMFC60ezuDu8n7Gj8TlUc24yMLUkFpFDGI4uo8LW
 Re9ztOoj+Y0IsI1EG6t1bvMlBhsAmGNqE147JbN8lFjlvu6SK9zRVJPmnpQtuNu6Omfsau77y
 GLzwGtWxu8P+WRs6jVcJHf7TQ3FgzitvXQ9+ebLaOtJva3tSYB/WcF4QPFRZGZ+NmJzoDIoFt
 dX3KluStp6TqJYzT/3T74cTc99Sw7sYGyic9myhvsZh3ZTaV+FOXr7ncfQwPJwGQCWQpJc1OO
 RsjIf50ZgHJaW0qpQJQsPWKvCD7peNBEB5BTE8y1lasXBCsiXAWHGpMStJh/e0zjMX8RkYqj9
 PD4Imdj9IQn9CYPcQwqDp4qBZGq1p/Ruk6BLHLWpgOCxDnNa5nfvXnwyYr/99e1sTVUwI8EnZ
 6pQ2VLsKhlRHqijSpcyU1kkfEhFD3Lg83PloFimzixw6gD1Zah2zCw1y4ZVvKmT+kNRyLdMn4
 CXBoO/+M/uOjFng8+pLcKz9GDvaJdxsjr5k9SrHNvrN4c+ybgO1YMiycb1bW7ZjaqqMjIDC+a
 CKTdLRNnkOnazc0I8odjjbed4nxs5k/f86sftoDf19cu8KeEcaIULNpyQWzpmAZNGdQmfxN2n
 1VB7UtP63dWoediTcnIY+fjzwgMVy1FqZDeZ+nX0kqHLQBh52PT5j43wuKi+z9cndXVjf40ew
 bRAIOeBsHkCeSIfhcJgYgo31JPCg6/H526u5KO705qBPh/g1eUpuuoCINDA5yKqT8p4htljXk
 AOpcOSyy8u2OiLhshXmCs35PHkhGEnlgN7EDmT0gpqanGnLeIwGG++DRL/4NApH84XN22b4Ky
 BkbD0YMu0sfpI1Qy9TxJasqtsQVBn2wncqx3kXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.11.19 um 17:33 schrieb Markus Elfring:
>> This reduces duplication in the semantic patch, which is nice.  I think
>> I tried something like that at the time, but found that it failed to
>> produce some of the cases in 921d49be86 ("use COPY_ARRAY for copying
>> arrays", 2019-06-15) for some reason.
>
> I propose to integrate an other solution variant.
>
> * How do you think about to delete questionable transformation rules
>   together with increasing the usage of nested disjunctions in this scri=
pt
>   for the semantic patch language?

Which transformation rules are questionable and why?  Removing broken
or ineffective rules would be very welcome.

Specifying disjunctions inline can make rules shorter, but harder to
understand due to mixing languages.  Perhaps this is a matter of
getting used to it, and syntax highlighting might help a bit.

> * Can a single transformation rule become sufficient for the discussed
>   change pattern?
>
>
> @@
> type T;
> T* dst_ptr, src_ptr, ptr;
> T[] dst_arr, src_arr;
> expression n, x;
> @@
> (
> -memcpy
> +COPY_ARRAY
>        (
> (       dst_ptr
> |       dst_arr
> )
>        ,
> (       src_ptr
> |       src_arr
> )
> -      , (n) * \( sizeof(T) \| sizeof( \( *(x) \| x[...] \) ) \)
> +      , n
>        )
> |
> -memmove
> +MOVE_ARRAY
>         (dst_ptr,
>          src_ptr
> -               , (n) * \( sizeof(* \( dst_ptr \| src_ptr \) ) \| sizeof=
(T) \)
> +               , n
>         )
> |
> -ptr =3D xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
> +ALLOC_ARRAY(ptr, n)
> )

memmove/MOVE_ARRAY take the same kind of parameters as
memcpy/COPY_ARRAY, so handling them in the same rule makes sense.
The former could take advantage of the transformations for arrays
that the latter has.

Mixing in the unrelated xmalloc/ALLOC_ARRAY transformation does
not make sense to me, though.

Matching sizeof of anything (with the x) can produce inaccurate
transformations, as mentioned in the other reply I just sent.

> Would you like to clarify remaining challenges for pretty-printing
> in such use cases?

Not sure what you mean here.  Did my other reply answer it?  If it
didn't then please state what's unclear to you.

Ren=C3=A9
