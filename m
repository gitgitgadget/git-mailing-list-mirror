Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF3D1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 15:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934712AbcIFPti (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 11:49:38 -0400
Received: from mout.web.de ([212.227.15.14]:54059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933176AbcIFPtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 11:49:09 -0400
Received: from [192.168.178.36] ([79.197.217.192]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M1G6y-1ao6aZ1wWe-00tDT9; Tue, 06 Sep 2016 17:48:27
 +0200
Subject: Re: [PATCH] introduce hex2chr() for converting two hexadecimal digits
 to a character
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <ac454d89-e1cc-083e-5cea-fc9751de9a0f@web.de>
 <alpine.DEB.2.20.1609040947211.129229@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <86d0aa97-f56b-3d6a-c6bc-07697ac1256a@web.de>
Date:   Tue, 6 Sep 2016 17:48:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609040947211.129229@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BT7TyvwHgf3nYHpgu2OuHgrb7BecNETKLcs+GhFG47h7YVvqra4
 hF7n1qGOyTgduftURJLDqIEVkoIl1v1SP+56DRZbm1EC205V51BlvwNCzzzFkrwnkrjCuD6
 i96HeEKLxAUO+Z6U+5sQmKAbbf4PMY9kiKWCg3FqK416+990xC8Xs7uoT/9+MYYmjmysGC7
 tJan8uYmu71OCvhPhdQzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+OuyZq+HhnA=:Ya/7fqlNdJI2a6wx8uXH4X
 HNIV/SFfnwwaNqVHIQzJT5bcYa6JBAi85M1tj7HWobcV2DnB+Ts8iqCODG0imYFe9l4GqTp+O
 wjq3sHwwU1F9FTreKu5UjcXLA7nUJ9KyVv3DheFtSfYG51dt1OnUx+CgDkjc8onlQ+izwyZxj
 RrZ5Is0dzCAbd9Cl8wKPuxIUx+W4Br8Sky3FMfiu6zotEHr0FU5menwHZ1UCed3ALjdE3EDGW
 E//Rx0gJCLB39x1MeEUOdeXWGoyluTXS2fS2TEaaZMtqfZ4pLQkoaFQinqbbhLicC9hdyqRMC
 zwDzqX8wuZCdKHz+soEaQl2GHNXnk/uRYT611Brn+tdpF1rNsN+qwZJLSGgQlv0Y5/3fIEdXJ
 wYxyvoOcwwN5ZkRfpbGObQw5PMdI2fuWzeLj/LcnLrRMGRt+USOYkmzuYXElZbzrVFs7hkLxi
 +HeuuuktCg29BOqsc1csxmxRPDiCtfrrRNf0G9OTHAkfr/8gpV8Q5Zpha0rMg2breAdQAT0dz
 vrHXrQlHs3UX9cVxNVn+nbhdbd9LD7i6MVdkEh0D3ccvvV5Oll3Al/VITbl8U8YWR8P1F1nWr
 ABHGMs/Yp9j8dW8TltbX2fA5xfJmgvAzmc7GXkLCNtliRrT0JMoRnK/R7dy8P0V2f4dOWgJ5y
 fGklUyasT5wkCapmlAjxfArcZC4n1t5rFXrvCwj1PvfNhS9Tf7+3IFcyR9yXmQpgc+QwsaHmS
 ta8Vb4gHBHaD4gNqF6NwNr2wCbBGOkDkOIGbrMGP0Xq/0XOQPTBVqeB6X6EVqjVjrXgJj/0Sn
 RFdF7Mv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.2016 um 09:49 schrieb Johannes Schindelin:
> Hi René,
>
> On Sat, 3 Sep 2016, René Scharfe wrote:
>
>> Add and use a helper function that decodes the char value of two
>> hexadecimal digits.  It returns a negative number on error, avoids
>> running over the end of the given string and doesn't shift negative
>> values.
>
> I like it! Maybe stress a little bit why this is a good change? Like, DRY
> up code, makes the code safer (bt avoiding shifting negative values)?
>
>>  6 files changed, 21 insertions(+), 78 deletions(-)
>
> Very, very nice!

That's the main reason: Consistency.  It's intended to be a safe, easy 
to use and reasonably fast replacement for those other (lengthy) 
variations.

René
