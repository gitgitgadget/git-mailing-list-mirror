Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7684202DD
	for <e@80x24.org>; Fri, 14 Jul 2017 08:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdGNIk7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 04:40:59 -0400
Received: from mout.web.de ([212.227.15.4]:62785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbdGNIk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 04:40:57 -0400
Received: from [192.168.88.103] ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MM1eu-1dZGbX1L3M-007mPW; Fri, 14
 Jul 2017 10:40:51 +0200
Subject: Re: Git on macOS shows committed files as untracked
To:     Lutz Roeder <lutz.noreply@gmail.com>, peff@peff.net,
        git@vger.kernel.org
References: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <914898a3-24da-403a-8e1c-e90b53df46a9@web.de>
Date:   Fri, 14 Jul 2017 10:41:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CANmutwCSGgLxESPmTJZXkid6P1N6HwwOTaz=7QHOsSPrrHQ4EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mJSGlBR8obHuVf5L7YHWq72pFCjiX8urTAnkA5njNTdGXlOsW17
 DY7ri7v35FGdvA6MKw/gt3QLePjwQjJ72R+PT6xsthACyFO2OIvrIICC+yVC2ePQqjmzXZn
 WXTB7Jmz3Oo/aYGwuTP9Z1bOwFqNGn8U4M5vrKO03P9L83nLSTeOrfm84MN1hqnJPr5ECud
 7H59wlhfHubZ+v3PNpWDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qcOsckV3z1A=:VkKLEu1oE888I0YQcs2x8r
 tqQr2DZgdxu0r3Nzl0f9fk0Wam5efwD0WfHh+MtralnS1m23b26bmeNRbkddLOb5J7W6sAupo
 H7Oc2WLkpFM1LEMNLO84wmNvjDSTZEcrC9MTO8uDAMIEBtupadDFzGSOH8crlTB5uXa3o51t5
 SKdNZL8MzfgZB/R0eW7HkTKtPzSNkvtGX8HkBH13PKDrJv8HwHloiBqqKVX9b5DQI6vUCLGmB
 +za6Y3kXtRYimf3kvg7nQ/bKt8Pi+FCoXdHqt5WWkdMu2+V1F12uk1EzfgT0s7aDoF7zA9Ur9
 1AwvNiFGQee6XV0kmqRduRO3kuX2ssWaqhgpGsk16E4ScTAOVmkoYq2GYsATEhuSBpXrSsuo4
 6aRMwLPmnEMECgn42Zrr4TjkEohvlszMzncoqbXOLJOAv5gqC+cO2V9NA7n7D8ncAW7vti0H9
 5qEaJnWo5i8vnp4VJBUjDByzdJd5KKaEK5FXy5e1wU87+MA6Q3WZhUeQGJUe57q+dD7WGpLOS
 7LEkiHPMvzrWSqr6NkynVmvyILAO4B/o05WsgyDe/ENq/JrfdtT3c/zupRQNuoTTbMENk0rx6
 nb598w+jMsFLBgxSI1P76Js2v+UN6J9gCktiqWMEO0rjd5IGKtvFVpxY7p18iiBenNHLJEiTo
 Hh31fgjow3wQnCivqRwMwWi6N/m1XmH3oznlWlESrvvvSwgZ633KPzNQBKhZSdvwgXk6mGnuU
 jNuxKWDY7Am1YTdzYOh4eMigJOyCwVda03qasWkIDfQjC+qugDclgtcimlxiMpEyWUSqlxfrU
 cqe3FAInAc2JaUWdC7q8AzYBxMpjhFimxEu5n+tDcP+ed8wB5U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/07/17 06:49, Lutz Roeder wrote:
> Using precomposeunicode still reproduces the issue:
> 
> Repro steps:
> 
> 1. Download https://www.dropbox.com/s/0q5pbpqpckwzj7b/gitstatusrepro.zip?dl=0
> 2. unzip gitstatusrepro.zip && cd gitstatusrepro
> 3. git reset --hard
> 4. git -c core.precomposeunicode=true status
> 
> On branch master
> Untracked files:
>    (use "git add <file>..." to include in what will be committed)

A (short) investigation shows that this seems to be invalid unicode,
at least from a MacOSX point of view ?

Unzipping your repo shows this:
  git status -u
   deleted: 
"\341\270\213\341\274\262\342\225\223\316\265\357\256\257\360\222\221\217\342\227\213\342\225\223\323\262/test.txt" 


===============
If I run this:
  xx=$(printf 
"d\314\207\316\271\314\223\314\200\342\225\223\316\265\357\256\257\360\222\221\217\342\227\213\342\225\223\320\243\314\213/")

echo   $xx | iconv -f UTF-8-MAC -t UTF-16 | xxd

iconv: (stdin):1:5: cannot convert
0000000: feff 1e0b 1f32 2553 03b5 fbaf            .....2%S....
===============================
So I don't know if we can do something in Git to improve your repo.
How did  you end up with such a directory name ?
And would it be possible to rename it ?


