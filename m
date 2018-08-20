Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD55A1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 14:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeHTRqR (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 13:46:17 -0400
Received: from mout.web.de ([212.227.15.4]:37151 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHTRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 13:46:17 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuuC9-1g0fEh3CS1-0103Tt; Mon, 20
 Aug 2018 16:29:38 +0200
Subject: Re: [PATCH v2 05/11] t0027: make hash size independent'
To:     Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
 <20180819175351.449973-6-sandals@crustytoothpaste.net>
 <CAPig+cS6Z+U-Z26m-eW-JX5D29ONSb_Zzur2fvWGb_ZMbmF4UQ@mail.gmail.com>
 <20180819215732.GJ70480@genre.crustytoothpaste.net>
 <CAPig+cTTmOw-d7umES9p2xv4uCkjTnNtjTni_DaVFKbhc8WTgA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <31634401-f889-c551-4232-4745b9ccce44@web.de>
Date:   Mon, 20 Aug 2018 16:29:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTTmOw-d7umES9p2xv4uCkjTnNtjTni_DaVFKbhc8WTgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pKB5T//3+HG4bFwlXtc9dPAdeRirRyg/kQ2evcdHgOXQibVCWCO
 6DKYJPuoT5YZ+FnAK/LXtYhqjWlWRAnyiXNx/S71daa2V4IXWV4udFNsh0NmEO8iDWEUefd
 8Gk+gF6kbfFlBuSkNGUK/HP9wif9Dcq3BLtj1yeqef+F3wRNb+RattwOV0dUhdVGD1Hnz8H
 2smx7oaWbdmQs8P/lkbvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F3eHtMXgHpY=:AYiu0yol7CGEns4BiRynmT
 RBIOPDqhjOeJKETyrs3ux2pVQdzNqZC93fQuNYTZS36FhkRDEIkMcLcNkViJxqXSd3ZY9cJKo
 CI7USzsjLUWMmoBx7liWN8AbEm1A/SgHxbs/s3+ZPb49E1s8opyUO6C4uAPig7/HR6jokd8cD
 Qrzh9n7fgAjiQQMYUnEEiG7es2fHvCy/k4mohETI1HLoKH33Y2ox8waHh/RuZz9BtGL3Xkpkm
 uB7W/xvz8Hf33EZZRAa9Nr8L3maMlVNxgXZOvBlbW+XLiJf5/XJIyIIyOG4TnQ47CDiZuQ/NL
 fO2U8DQGg99UjR6N5GSw13kL1eoA+57dH451Rotwq+qHUgmVyw5/ZUhHWDq2zJt6yeLRmbf5p
 xsz0TsjSMzR/hRsKSqw82RDrndSsmaf5wIexRrIFXpDGbU1Abw62/bAJBcc0C3YG76ChxHIqq
 295YsjNH1uazhv0MzXouPwxaiCVHI/o+LS88XeIV/d/CsKSKUVmS3eJQpV0eK/RMvk8B2p7i8
 aVPLVGqcRPVqm1ERQwOfqp7OZRmwuT0fS61eD0n4D7toyEVUvD36P9eWaaBPga+D8U+5xIWxM
 iMkQ7X47FNyzW3llntmhQ6w2UnTrqSM27kS2cH8CaFGWLKGZp+7eKJk0wmh9sGgk2v8tUWz+P
 /hocxZHLKctWjlsm0bdTehzfGvWrUtPXkEoxRS5g/jmAWYqhIeZ4HzvqShzp0olvhszGq3U0E
 7hgZ8aPvuX64QoRbOvgm49hofRRnwWkPHoWJNXzp2Sidg0EWGak9ltlGGrqOdVtronPIfK+sf
 627ZyEN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.08.18 00:10, Eric Sunshine wrote:
> On Sun, Aug 19, 2018 at 5:57 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On Sun, Aug 19, 2018 at 04:10:21PM -0400, Eric Sunshine wrote:
>>> On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
>>>> -       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
>>>> +       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp+" &&
>>>
>>> My immediate thought upon reading this was whether "+" is valid in
>>> Windows filenames. Apparently, it is, but perhaps (if you re-roll) it
>>> would make sense to use a character less likely to cause brain
>>> hiccups; for instance, "exp0'.
>>
>> The reason I picked that is that we use it quite a bit in the Makefile,
>> so it seemed like an obvious choice for a temporary file name.  If you
>> feel strongly I can pick something else, but I thought it would be
>> reasonably intuitive for other developers.  Maybe I was wrong, though.
> 
> I don't feel strongly about it. My brain tripped over it probably
> because it's not an idiom in Git tests. In fact, I see just one place
> where "+" has been used like this, in t6026.
> 

Probably "tmp" is a better name than "exp+" 
(Why the '+' ? Is it better that the non-'+' ?)

Anyway,
If we re-order a little bit, can we use a simple '|' instead ?

tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
	sed -e "s/0000+/$ZERO_OID/"               >"$exp" &&
tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
