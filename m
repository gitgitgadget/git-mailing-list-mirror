Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05721F829
	for <e@80x24.org>; Mon,  1 May 2017 04:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425652AbdEAEv1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 00:51:27 -0400
Received: from mout.web.de ([212.227.15.14]:54939 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425162AbdEAEvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 00:51:25 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoYFm-1dk8M70jOM-00gZao; Mon, 01
 May 2017 06:51:13 +0200
Subject: Re: [PATCH/RFC 1/1] t0027: Some tests are not expensive
To:     Junio C Hamano <gitster@pobox.com>
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
 <20170429153454.16879-1-tboegi@web.de>
 <xmqqfugpi8bk.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f79dd912-f798-7fa3-e8d0-cf90aef53bd5@web.de>
Date:   Mon, 1 May 2017 06:52:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqfugpi8bk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:a9cao+p5T+RQGqzUv5BTk4bbZCABpoKqE7Yx+aLm1iyCfekHJ6l
 DA1VyaCDNnPllCV+XqFIZAkQ7dK3K9vg4Gb2FvC5zPaXUdBctfK34wgOIVaMnDGwhYBU2Fi
 +l0yyWCS8KlJCJt+/J4jk/VkBhZ/gCcyghFbKEnE8ccf4kzir0jQ8bzG13P/+0CmLDJdliQ
 DH40T2BpuDmUB2C+8wFRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3bgBmXTWqDI=:iFUjsEZIrfR/xMBEGZjgup
 WffjVmVnLWu0e5tr08o1FOLyKFIfgAugEHpdWfCDISwIFYKOluf4Eh8dftm+ny95NAXl6t7Tj
 /M58/AcPVXkIHucuofGpliI9a+mFewkmyI19fm0GYMXnM5PvuenG5DuuJPfFjdaR/nr6h64/4
 YfSDwOTCR5jlavZX8hbAxn+IR+gTVODIXDeO0YjgdD5wUB8Ayf3gJBeyRRQyx9oBzIV81dCoI
 FkBVKsIldCkOO0kVjjwS/aa/Tcz+W9Ws8kT6rT8NILDUz9KMy+qcPKJfcXME7dtVH/988mrOy
 j8Z55jMgnP14hOroPbSxn4KHxBgHk2Z3m3qfkgDzmXtTArxkWGN7Ebbg8vf2xnEKlOpF6CTdg
 sFdG5G4iOyzO7Vabfxz5ggdP91I8N8Pu5WCX6S6oHpTsAjV0pOK72iQ0RravJAJMGA1t69FUP
 DZVOCzSr6AQAa/b6yX5ybZ7t2ZhOON09ODj+JoeowMPdfaQD9mPOdYQaKkHYSjmK8OGD476jh
 FLkWLZzPCzlRc9WqwSjUi10e/Iosm4zRSMKSI0gCKN9zJqkqVYjNpAlGNMRkI5NYUbg8Wxkxv
 OnXg/s2Rl5z2XgKCHsQbauLAcOy9nReeC70RKm9u2KEzBmotjFiEyCpiKccMD0yeI6O7FvjZy
 HPCDsqof/TeLiG4rZZtLqavIVYjXS8OiEoylL92RB0x9lx9Yrx+gXcbdxlHo+0hBcqXSHuW9p
 C232USF3Zv0cBfTxZUMY8cj1XLRL3uZV9XU1FynZQbgAlhNtl2MmNvPttp3MqtrYI5TvrIkqe
 8reBJac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/05/17 05:07, Junio C Hamano wrote:
> tboegi@web.de writes:
>
>> From: Torsten Bögershausen <tboegi@web.de>
>> ...
>> The execution time for the non-expansive part is 6..8 seconds under Linux,
>> and 32 seconds under Mac Os X.
>>
>> Running the "expensive" version roughly doubles the time.
>
> Hmph, perhaps none of these is truly expensive if that is the case?
> I am not talking about ~10 or ~30 seconds in absolute terms, but
> reacting to "excluding the ones only halves the time."
>
> The files used in the test vector seem to be all small.

> Is the expensiveness due to the fact that there are so many of them,
Yes

> and not due to some specific conversion being very slow?
Yes

The easiest solution is probably to simply remove the EXPENSIVE
precondition from t0027 and run it always on all platforms.
At the same time t0025 can be removed.
Unless somebody objects, I will send a V2 the next days.
