Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2B320281
	for <e@80x24.org>; Sat, 23 Sep 2017 18:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750959AbdIWSgZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 14:36:25 -0400
Received: from mout.web.de ([212.227.17.12]:49320 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdIWSgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 14:36:24 -0400
Received: from [192.168.178.36] ([91.20.61.209]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lr2dj-1dQdKR1ezr-00ebYC; Sat, 23
 Sep 2017 20:36:12 +0200
Subject: Re: [PATCH] mailinfo: don't decode invalid =XY quoted-printable
 sequences
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <d48b3d67-5f03-19f3-5a32-ec7e8397c98d@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f06d0701-281c-07eb-d053-78b8fcdd00c4@web.de>
Date:   Sat, 23 Sep 2017 20:36:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <d48b3d67-5f03-19f3-5a32-ec7e8397c98d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ymX7rPCaax509Ac7cFbDqbV7PQotBb2Nt9q6eXWI73ah1rFSz7F
 KfXHw4QlM1f3XTBNWFapcsrgLMCTlYNVP8UXqqhwBigFwJE+ZPncyDXQtcmZwI23kLe4HzS
 6t4tLWRu2Y480uiXwjUD4TD+a9padT0h0jn8UcRMBz0YFsu5uVmY9X7UFRG+3l1bDiOIwfl
 3PtaDZOGE2IoRKr2JHiRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V2WjU0VZZIg=:gZpSHxJXWtqE3c5PMmUqXA
 Xq3cZYQhzchZ8saTYIHOknbfax1Ug+2aP2pxMhKOyS2afN5E9cV7rtslA2giyCOXMoukZi35t
 mVTjclX6b0mxwQX3qnZAC46tOoCSq6wUX/DZLW0xPBJR7sPuZsFyrkl/+i1YJW1XxCQuCWX7h
 xufScYHjIRknxI0AKv2jf0mj3rYI9pqD9zSljYz7iY33YcR2ZbQsDkT1ZjCIMqEAtdrvrescz
 OVsBQ6QORynrwcYA2w0d47Eug9mgfssrSAHFHQiAfeE6oO+w5qY8B9FiG2tLUz+AdnDBcN5zy
 Hu8XABbGqHO52mF1FhNVI46qcvpOxMNH1A+YRgy+cm/uJC0XWRWi0CFxA84j4UZLtzJtkCjNV
 QDu9ePLDTjq1lTc4bycPijCmLY0HIhXEk32Nwq9FNfkuwGcUh/PxktHfT7dx97E0I+oOnnSuw
 vyRq7jvctZAxQDdwmbhDIE3iQrGdxQvodt5Oxetzoo/0yHP4+qQfvWgKYXBBOH5Itpg/uGxcR
 uaqb6oNsA0j+cLMbeBh8xu2mNJcUQy0M3/4OCDbozTAFcBcsp2yIbjDw8uJEf7yCIBYbwHWlU
 AQQPloY2xoDJb8MDpJA970IHDZQ72qOcFWCHzct+MZliVy144lxbZshyc5eoavPypjnEdyv53
 mxBP8VDeYcPeWNOHt3iFC7NGeA9fbUjMl9woVuPNqQSjCiEUIFtD73uVFPHOXiA7xtY/Ru4Vf
 02K3/EDFx/WqqODbE7Q1u9qfgxM+w1hkpXCMVgjYa657GACjQUiThU+Z55Q/omxkXOR1MO4wQ
 fxdJxNsSlVczGy38MW5QgnD2EK/NEcdXiBMGHMhLjqggd8/4J8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.2017 um 20:04 schrieb René Scharfe:
> Decode =XY in quoted-printable segments only if X and Y are hexadecimal
> digits, otherwise just copy them.  That's at least better than
> interpreting negative results from hexval() as a character.

Forgot to add:

Reported-by: Jeff King <peff@peff.net>

René
