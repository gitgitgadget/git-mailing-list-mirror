Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22EF1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 17:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfASRIR (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 12:08:17 -0500
Received: from mout.web.de ([212.227.15.4]:44669 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfASRIR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 12:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547917687;
        bh=UZK/L4W2kmRUKvdw++D+SwHojzF+LpEi76pxFjoW5/M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sWcefTCj5Z5SMcvkE4ZxRzPfcfTPacoIYaCP74nsWUpOpor+Awmj5rZSL6/YIFTCN
         Wcv2AqL9c509rZXiToNfJ9rLOD1GHDdp1GCnOQw9/RQHCSxe4fi4ERoMOYRHm7PGOK
         utZ/IbjPUOvdATfb9juySFX3AF8+sPreZbTLj6Hk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.88.149] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEVU9-1h02FK27k9-00Flq6; Sat, 19
 Jan 2019 18:08:07 +0100
Subject: =?UTF-8?Q?Re=3a_git_add_=e2=80=94ignore-errors_causes_--renormalize?=
To:     Jeff King <peff@peff.net>,
        Dmitriy Smirnov <dmitriy.smirnov@jetbrains.com>
Cc:     git@vger.kernel.org,
        Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        Aleksey Pivovarov <aleksey.pivovarov@jetbrains.com>
References: <401130AF-056B-40BF-8001-8492223B8A6B@jetbrains.com>
 <20190117162711.GA7935@sigill.intra.peff.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7fb24fe7-4d14-a2ba-f8b6-94c88cb0ecde@web.de>
Date:   Sat, 19 Jan 2019 18:08:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117162711.GA7935@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Gn7C+NQw9nbJc4QfwzbanxPyeAx/3HBwNzRsyI/kqqFPQLrMYn
 7e6hEoeaBxLROzt0JekP8ZB270k36taWm4Iamvn6KxruqywqU7isKzuZwayQamIgL63100f
 Lv9BDCuFsAmNs3gc9UUHPZypfJ4MEQdSaYgIMOYbYfUZ3AlMdwLOAG3o9lhmCDkSuRDz7Ww
 A0sw7EbKFOLH3Eucjaycg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9fJqFn6uNBQ=:sCIwHREIfOJ4pQbyi1EAc5
 gQvZetpI0thcTqqbm1FSwMmOlU1V8e7QpCOvnDU0YSTjAwiILG1zyRGoBKA//MvPFyHaoAdbL
 IhdlxqM6nI5Gc32UC5I+76VbjwqJx3nmSv43GnuNjWE0HdT3VB4DavGkIPm+7fVtyrthiiZqP
 NtmhN9N5hkIb8gxdW5E4ELIByaGFWajZKJIPkvU0aBXjc8PxZDhAucSPwduab9PjSlWScy/ET
 P9cvrfGCZ5C5uYKX57TMsFVxtbPjb0HbYBsDgWhjNGfoAiXP12yMBc9v4xeG1X7czLgsEjdug
 VrL6wKdcvgNLUTVHY1fYvZmAVkapM3HfJa3JoEER7ZODJlq+SOUTWPTZ4msy/VKiJkaIIlkTX
 OIAyjMkzvLfXok5j0WWhGdB/JJYzp4+F2i/A0WIB1r+NUN6vog23vGkGrIHAxTgVSCcmySz8J
 HnJDBLdp2jqeA1027aw2fIDu9lsRpoaWOrGsqQXeyNTsGzp2MQ3kJQ8qfuTL2Mz4gzETsLkgW
 /hGpCTrz9geH5nMlLng/eGsTbfxpkAvW6iCNBitSU7cOCN2Q/K1P76uV8FjSXXV4T2ZOH60oY
 H6fbG9RGITUfz+5D0GrYgBVEz+Zatu/W/ptgMUBRtAOBvs1JOPBaU/CzkEzIbHsbsWkI6QgZ6
 XxrQk6rnXKJ1UIJdWT5/QEgS3gFmBpY/ynBrC5KNCSzWnl8Sz2fq96gkuRWwIfOH3YGu5H9SC
 lWun5sPclZeCfbiNpdyVS2ruqLvEwvOUfKp1h8zLGdwhrowoiKoATMW12YgSZSMBJppAv+Vkv
 nW1pzrLyXKqJGkgbOQYpNbjCQwUPwgMxaxX2WmKc16mlxrLc7C8kLlriVTaO3GX03Aef7RztE
 PgZWz7pRAf2LuJADElmKz0tA7IM9fBqtpmtX/tC4XuVfa2Kl1rhExdebAi3A1Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.01.19 17:27, Jeff King wrote:
> On Thu, Jan 17, 2019 at 06:22:05PM +0300, Dmitriy Smirnov wrote:
>
>> Calling `git add =E2=80=94ignore-errors` appears to be equal to calling=
 `git add =E2=80=94renormalize`:
>>
>> Main.java is saved with CRLF in repo
>> git config core.autocrlf =3D input
>>
>> $ src  git:(master) echo line >> Main.java
>> $ src  git:(master) git add --ignore-errors Main.java
>> $ src  git:(master) git commit -m "Ignore errors"
>> [master cf24b3b] Ignore errors
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>>
>> The reason appears to be wrong bit mask usage
>>
>> #define ADD_CACHE_IGNORE_ERRORS    4
>> and
>> #define HASH_RENORMALIZE  4
>>
>> Looks like a regression since 2.16.0 - 9472935d81eaf9faed771878c9df0216=
ae0d9045
>
> Thanks for a very clear report! The patch below should fix it.

...

Thanks for cleaning up my mess


