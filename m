Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D31C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjDAPYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDAPYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:24:32 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5BF4EF2
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680362649; i=l.s.r@web.de;
        bh=Xo844ySUcbXxkZNnNzi+32Mxgts+TAOcSL3UKEc2I9o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=owqywJ0khls6oe8N0foJUoxi4wrdj6pfXT2xoRfNc0EIZ/MiUiKNDDUGIWJEdK7H2
         AThOFgoWS7QWvgoxCyifeD3+3i9tYlnTrYQpKKuaxmfR66jqc03/z7CgsUIH99boV/
         WTThtMdm3letlMXb+3LUpvZCTcGe12ZCO2+glg4lvvxVjgKU14dpdQ0Qe6ccOcLhKS
         kbMuZT0wIVpEz+OlsFQ4BWWy1tqWqTAPaCaaGGr7c8mo37KL0EzltmKyC5At+BJ7dz
         cE5k+Kg2/uqDtfvxVyJ0eKTUipr1PHx0dv3KlYvMV1OWBCbphkVkBhsCp11wm+H1/C
         nJP6PVMF4vsvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9IOZ-1poyCs0hYl-006Ccq; Sat, 01
 Apr 2023 17:24:09 +0200
Message-ID: <58a6b697-b403-308a-dd71-6179ec128661@web.de>
Date:   Sat, 1 Apr 2023 17:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [ANNOUNCE] Git Rev News edition 97
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
        <tboegi@web.de>, Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
References: <CAP8UFD3adabbwdvaCmEXW9fQ88s6Zniim42vR3cT7VMobxFoQg@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAP8UFD3adabbwdvaCmEXW9fQ88s6Zniim42vR3cT7VMobxFoQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Ss+r7bgekGyTpQXgv9eZZ4krkQcb7bz0o5uNK+wKTjeAIN9YsI
 ZoY2A9YUeeDVX5bDbYYivWjlAIb3y40A+m8qk0mRZKP7fiOrxrUpi+k+NIgI2pG0f59ssfJ
 d56FLnRWg/20/aX818cIw2Q3R1toswxocEqH5RpzGGaRh+dVIDUaIih/rwVqDeOSbzTOvkr
 V2yX4ihXhvdnOgiBkQctA==
UI-OutboundReport: notjunk:1;M01:P0:FTJNnDUND8A=;nHQqgE1no0vy6dlVaM5ye3DVSYq
 G3pUVIPzwVx8Bc5dZ3GV2vMI4dPhNmb5R/dVWvBADS7Z0RhYvRfh+pUnUauPFTBS1QZkl5C03
 h07mqOUn2zx3kJc/k1CzcKiT037gYaowA+HByK6Wh4tXr/3IaAn+SrJrUcArRqfiLyH4P8tHc
 jnR2wrDp0JsjEQLlWn/Pgz6TPqHp5PiAAA6iTYetB52LYWnEo0fCIEZK6TDl+8F0Vzz0un8x1
 VhbUjIlOfybDDxEB6DoYqradHXAA7qHHdqKzgFNf9rzt/C1SJS1LjQUn7aOm7Jrcds/jB5kZk
 2S1M6c69IJFKgjKcjaoq+IZVDU0a2tsiSMmXR0Wk15aaSyghqKpkHiqdv36VvhSj2n+LAQCcA
 beFUZIWClVTPZ5zc0Y0iIb5moUsWFOsCzNVPt0XKI9xYmzowkzMKuE6rIGkt0Xe4Bl4ufnTpN
 ds8Dc9N/aWKFjzARTjY6LNkHcIXoenr65QD+qGMx2APeiyjcG0p7Ay/lL9Sj4XXt394uDiz37
 OxWdG5TxHM+zn63xuqy7ErDNXrPFnfOZRThm6ACDBH1fETuNVPR9IBESI3ocPNICtOninLuNG
 C0JrcYHu1wzrOFW4nUGexrMR0Ac+pzIszQV5IOTGYlD/aOAwEnWOw5aXzCMZAbJxAP5FmR3Yd
 c0nEcA5AGalOjxeJKnI6NjZkjJwPBN9DwAbsqABhMazTDIcWumWVh257K8neTHuASlq9YNlkG
 tN9a+jZ94if8blUS42Mk/7K+aeGF4t5WkuKmGhpig5NjhldsKQ6XtcMn0+Y0vsApNXarEq6dw
 Aa44DLxhuiGqzeDyszmgX7qKDmdzfBnzR0qTRy6YF5q1iwSrLEzVeJ/vCATT094mYyxGq7giI
 5V1QKA0G6Ov/TKP4bTS/6ImWG0GMpPM9q2OaPfU5fxcUQLQPsyx4PuPGadGWRJyeU4w7cYtHe
 9Ca1KNXpc8NNW2f/nb6SEb+HcKs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.04.23 um 17:00 schrieb Christian Couder:
> Hi everyone,
>
> The 97th edition of Git Rev News is now published:
>
>   https://git.github.io/rev_news/2023/03/29/edition-97/

I get 404 File not found.  https://git.github.io/rev_news/2023/03/31/editi=
on-97/ works.

Ren=C3=A9

