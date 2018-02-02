Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE74D1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbeBBSuB (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:50:01 -0500
Received: from mout.web.de ([212.227.15.3]:56387 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbeBBSt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:49:59 -0500
Received: from [192.168.178.36] ([91.20.50.7]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lj2Cs-1fIP4Z1a06-00dJTq; Fri, 02
 Feb 2018 19:49:53 +0100
Subject: Re: [PATCH] cocci: simplify check for trivial format strings
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <376eb2e8-0a95-233b-743b-cdc1caa49015@web.de>
 <CAM0VKjnoux1CBq-HvzRW14hXZyviG_z_Rv-qv7d0kakh18zXcw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0df36d0a-6066-05c4-d471-f25a76ce301c@web.de>
Date:   Fri, 2 Feb 2018 19:49:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjnoux1CBq-HvzRW14hXZyviG_z_Rv-qv7d0kakh18zXcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ygIWcaPfLNb3mdEDsC8mIhCHwjw5OrK6U+LsWMfS7RPAh27hEdL
 MQ6+5hcha34eyOQJP8UVXmGTeWWIjat2Wtns48K7xBhxBfSD9qmCPAv+jcSydwch3gPgZpg
 2S9uIqZEG0uQS9MUYEeo88hK0rFILhYsj+85sbNt74/bpanznnsbu5pyANWbYdlidXyAsCt
 xlNJ9jc4/FWlDvJn5s0VQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9b1fl+qH8vk=:TVGj/CkyHPYRprSyeyqPGi
 ysYr8/LI1qm4Xo6/wlP/6QSBawp9SsTvaRyVBc4hbDSPISYiuYAgZTxapJWrJUgiIxllFrDHk
 +KOqUx8UpZGsEalFN+Csm5nuTzMwySjAqldpIU0yJ73RH+cqtl0NLwy+0P94hELNJcQ5YWjeF
 F7o9W1jgrgAhkfZ+KcgrRH5RmMbqJI49NiFT2c8l9tHrUb7UkkLLmyJjch+02pX6B6WLCOVVX
 n4331mSlz19DIXrdQfD1JQcjTJGxSW7tuvBXn3HsdFBOYWgk1GYUV0AmFYohoxTk26XkLlquG
 +tNs+V/aadH5tRQOz6U3AIYZY/a6ZjsJS4a1n4CBFr7uusYzBCOtsIu1Dik/QGcod4/RF+aHs
 GULOpuYNFOhWcldK9UNmhyz/msLBv37/96/fAVWTOmwTDjKi9YEzT5358791pfdy0LNtaV2H5
 4boFOMPBHoOIU/dK2CLNAex03vNdIcNdmLlw9fnD+QAPw1XN0klySnEAAnTWXM9pOnaJd+LsP
 ufu8Sgyk2pou5YIYm+uYM5qsfVPWdrzaYci1tgO4O/U5Zl+8itGBzmUhGJVA4s5cRCq6Fr96L
 npeGIuW3W+b04wzPOtF/2u0LNDdOm3xuyOZEqjSBZ6QoxwSNup9CM9uITMtxqDvB2frFDSyen
 Jb9a1mQ+1cn5fU7A0RqrKj8rKlEAOcdQa0elyPA4H8w335cpmJGYmOY/uT0F5O9Kuzy+/Va0/
 rcXr0PLDUuYkHNlzLVYt/JAmoCtI0VU0S99h2LpVjLLxWL17iBuHCI4xvNf+FWB7Dq2vLV3NF
 v94MDPUmSy2SRnz1qLXnIaKn5gtWH97xri7M1cosSM1weZIz7I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.2018 um 15:34 schrieb SZEDER Gábor:
> On Thu, Feb 1, 2018 at 7:56 PM, René Scharfe <l.s.r@web.de> wrote:
>> 353d84c537 (coccicheck: make transformation for strbuf_addf(sb, "...")
>> more precise) added a check to avoid transforming calls with format
>> strings which contain percent signs, as that would change the result.
>> It uses embedded Python code for that.  Simplify this rule by using the
>> regular expression matching operator instead.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> Inspired by the Coccinelle package in Debian experimental, which lost
>> support for Python for some reason.  Tested only with that version
>> (1.0.6.deb-3) and Debian testing's 1.0.4.deb-3+b3.
> 
> FWIW, it appears to be working fine with Coccinelle version
> 1.0.0~rc19.deb-3 running on Travis CI.
> Applied it on top of 'rs/strbuf-cocci-workaround' currently at cd9a4b6d9
> (cocci: use format keyword instead of a literal string, 2018-01-19)
> along with an other patch to show the resulting suggestions in
> '.../*.cocci.patch' files, and the results look fine:
> 
>    https://travis-ci.org/szeder/git/jobs/336573242#L1466
> 
> and are the same as without this patch:
> 
>    https://travis-ci.org/szeder/git/jobs/336257153#L1466

It's good to hear that it doesn't error out, but there is no code in
master that would trigger a good or bad transformation.  It should
propose a patch for calls like this:

	strbuf_addf(sb, "just a string, better use strbuf_addstr");

... but leave those examples here alone:

	strbuf_addf(sb, "200%% more percent signs");
	strbuf_addf(sb, "error: %m");

René
