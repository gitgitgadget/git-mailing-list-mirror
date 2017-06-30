Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69AD20209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbdF3JWZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:22:25 -0400
Received: from mout.web.de ([212.227.15.4]:52487 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751421AbdF3JWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:22:24 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LcPm2-1e7Ol12SHe-00jsjD; Fri, 30
 Jun 2017 11:22:21 +0200
Subject: Re: Bug with automated processing of git status results
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LXRgdGC0LDQutC+0LI=?= 
        <s_shestakov@playrix.com>
Cc:     git@vger.kernel.org
References: <CAM1TZMGXiDpzt3uhpDaE41KR8GWyjMq=+Mcvz5Zrj0EffNrGrw@mail.gmail.com>
 <vpqr2y1u9j2.fsf@anie.imag.fr>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <70c9a162-ac2f-c347-d13b-f24ac24d1133@web.de>
Date:   Fri, 30 Jun 2017 11:22:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <vpqr2y1u9j2.fsf@anie.imag.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HPP91XXaj0fR5j2keNAqShuPhlA/+R9OC84qCDjkYaAc9eO38+8
 DMMw/2CUX8gOC1JSQuAoFUDxP1v68xTO38wpkO4FT0SxRwYk6ApPZ53Y3VefCmSy6Cfb4+g
 VqLhsi9fdmRolJlgpvkXRAsj4riZ0JPgOISA/JcvOQXBwBj2aMFxUxS0g8oKS71JETf5FKj
 aVV5x0MprVLM+lZZxfeHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C9js0Ufo2Bs=:eHLNT3HSl8AFCZktN9qyXh
 /aO2aCQkhIHJEq8Gl3Ka5F1gCuOTovWWVWzB8DBtt2pqL7L3CKZy9Y2ZKv6tWCTulJhUrgz9G
 4+hqommSh7/sH/8Oj5Dso5IOhIijGkzCWsQ7AoO60C6y5PH8y1hBj11TTlyjnkBf70oi5+ucU
 BSp+dROtGxfhjtVXMEF5fHZSKteXcXl+pLLPU3osVz25VuVvahk6CUbQQCBzXu/FhAI/NA9We
 WaVfMsac9BhLnCRgjHLYcWBFS/uLsXaaLOkgV+glLlHmcj9o7XE/M+B6wP0wVcrEuH6appL0d
 kho3KdGJJnl6v9FDf02CGWl7XOrclZg5hxfWrbQ7cyMubQ9L+E4ZLV7RetOUCx8NWEBsM5XX/
 IxSf9A1C3/aJxDcUKxLRBcFLsV6ciGOXlWYlNOeVQHOGGA3yo52BQUMG3VaUMHwb14n337jAX
 QRtzv0dugrAP1qU71wcGK2tVj0Tmk8pA/2bvRP+IPaxCndEzmDF7SL4GxiFBGelNKeXI9ODkZ
 vFxRVTccHhRnp0ktuvFPnSVKhK7498s0DmmGuYreI2K6IdSyqsaYlRx2qEsr9jPSNOHOPaoaY
 ZzYzA87gX5nP6S+KERlhdCFWdwIzbK8lpltpWpH6yKurWzEBY7ipD+BYeSOZfwkKdaxWKHkXU
 cQxpmulghr4dtwCiRJbMUtQJxIRH7biXlRXLegvfdwjdP7bKzRwDcNBehKqTikDSGqxYgH2zq
 QPr/X8pMTkZaErxvignEWXT2PAb9RdHPWuL77rfAf4PyJsyxJJq/shzzmdHGu9dUtCfXl5M3i
 CmX80wH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/06/17 11:09, Matthieu Moy wrote:
> Сергей Шестаков <s_shestakov@playrix.com> writes:
> 
>> I understand that we can turn off core.safecrlf, but it's
>> inconvinient.
> 
> Note that you can do that without actually changing the config file:
> 
>    git -c core.safecrlf=false status ...
> 
Beside that, I would recommend to set up a .gitattributes file:

$ echo "*.xml text eol=lf" >>.gitattributes
$ git add .gitattributes
$ git commit -m "xml files are text with LF line endings"
