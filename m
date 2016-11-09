Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C035720229
	for <e@80x24.org>; Wed,  9 Nov 2016 08:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbcKIISr (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 03:18:47 -0500
Received: from mout.web.de ([212.227.17.12]:56578 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752104AbcKIISq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 03:18:46 -0500
Received: from birne12.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M5wzV-1d1pCF2uXB-00xoWx; Wed, 09 Nov 2016 09:18:26
 +0100
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and
 APPLE_COMMON_CRYPTO for macOS >10.11
To:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-2-larsxschneider@gmail.com>
 <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
 <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
 <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <11cc8bbd-2e67-f53a-c8f4-2244409fd6af@web.de>
Date:   Wed, 9 Nov 2016 09:18:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jEQgR3q3oXbEdKEGX2vcgXCpyLVxzCiw+7Erddv4PkBS/F0hFbQ
 9Pc/TRF/mOa0wM4OCKGnApx8n5s2uHAFGH58jCWnJ+hoNTdufhBcqRzx/8uwVzkjuNX0Dai
 5dqGKIxo6vgKOmpKeT6QoNPKR7MTnGs1zpAqOIt7CvfxqKhXE7t1hbUZ8VcYGGU/oME1x74
 DBsIhnY1djiX947awO9Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G2bjrBPVN8c=:xoF+2QdoQFD0GY58CAjJJe
 iBTiUG3egBvuEHHaUFkQI8S0SeJ0wi3FMB7E64Hh7YS+8/7H+Xxl4uVL1cOFPWOp1Cx74/Pf1
 UlxHiMlTQc97jZu32HypZFqrS72dtfLQ828IFtQsYVJmQHYz/AUChNxI8SXV2cL7YwwJNc+eQ
 vURCYiMsjOhcT13DzG3/W0p/n6Ja6BfHgYFs8FU2kfsEJnJ6nAvOzqm0xDLYeHJKfZ/04Foth
 9yDjufHfulJKIPTMwvA5h9m/fm/jaZu9SFFiXNa4SRdxQB6yvt+VMh+IiKnPKQrqcdz84jWOZ
 W0zYcFf/nO52XnDiB9M2baAL3uIEa1DSUOva4SDwhUu7RvbNygHLuT3BpMjm/CWgcXKut1sJa
 wYyemgaB4SIXM+/p4SpsGBbUncGGjxv1a3DS+tMsPvyZexprHhPSFnV53UHDAXFICQbOlc2w5
 FTsEFkaKAaztMW/AIsEW7keWtlyO05iOs2+EKWR3jVT1048uuw1dNv6nwXMVovdduuZ79xy9X
 osHGEWaBiQiYHvgHyELEQVmkScErqacVFQ90Q1V2f31/N7l/ab+JdUG9vGoW2xDnn/M0XI7Uc
 zikYVMWCZD8p+NVlOvrBFoC3ZFxgDH71NA3GntANRlXBLPueTf47w05vJm+txE9wN43gvoMO8
 l4pFGg324ElQyuxfDd0BIkzv2GbYx0f8ZfdhkU9QWzVKV0PZrlutfSthJcANyNwsENFST6tT2
 NGtsMrCLBNs642+zH96lOUi0RHzbtYIUYWC/aAhPK8FsKdzb2CLTKfCeYLnthbYhd4Cvh0HXj
 qNzigmh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.11.16 18:26, Jeff King wrote:
> On Sun, Nov 06, 2016 at 08:35:04PM +0100, Lars Schneider wrote:
> 
>> Good point. I think I found an even easier way to achieve the same.
>> What do you think about the patch below?
>>
>> [...]
>>
>> diff --git a/Makefile b/Makefile
>> index 9d6c245..f53fcc9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1047,6 +1047,7 @@ ifeq ($(uname_S),Darwin)
>>  		endif
>>  	endif
>>  	ifndef NO_APPLE_COMMON_CRYPTO
>> +		NO_OPENSSL = YesPlease
>>  		APPLE_COMMON_CRYPTO = YesPlease
>>  		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
>>  	endif
> 
> That is much simpler.
[]
I don't know if that is a correct solution.

If I have Mac OS 10.12 and Mac Ports installed, I may want to use
OPENSSL from Mac Ports.
How about this:


diff --git a/Makefile b/Makefile
index ee89c06..e93511f 100644
--- a/Makefile
+++ b/Makefile
@@ -1038,17 +1038,22 @@ ifeq ($(uname_S),Darwin)
                ifeq ($(shell test -d /sw/lib && echo y),y)
                        BASIC_CFLAGS += -I/sw/include
                        BASIC_LDFLAGS += -L/sw/lib
+                       HAS_OPENSSL = Yes
                endif
        endif
        ifndef NO_DARWIN_PORTS
                ifeq ($(shell test -d /opt/local/lib && echo y),y)
                        BASIC_CFLAGS += -I/opt/local/include
                        BASIC_LDFLAGS += -L/opt/local/lib
+                       HAS_OPENSSL = Yes
                endif
        endif
        ifndef NO_APPLE_COMMON_CRYPTO
                APPLE_COMMON_CRYPTO = YesPlease
                COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
+               ifndef HAS_OPENSSL
+                       NO_OPENSSL = YesPlease
+               endif
        endif
        NO_REGEX = YesPlease
        PTHREAD_LIBS =

