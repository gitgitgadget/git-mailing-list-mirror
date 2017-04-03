Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A268C20966
	for <e@80x24.org>; Mon,  3 Apr 2017 04:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbdDCEZU (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 00:25:20 -0400
Received: from mout.web.de ([212.227.15.14]:50769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbdDCEZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 00:25:19 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAMkU-1corvk34by-00BgBV; Mon, 03
 Apr 2017 06:25:14 +0200
Subject: Re: [PATCH v2 4/8] Specify explicitly where we parse timestamps
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <cover.1491159939.git.johannes.schindelin@gmx.de>
 <7876460edaa85d93b60c0cc1b2f9a715de97180c.1491159939.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <1485481a-f2b3-a0a2-89f6-8f55dc241b19@web.de>
Date:   Mon, 3 Apr 2017 06:26:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7876460edaa85d93b60c0cc1b2f9a715de97180c.1491159939.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:CPI2GLBqzNGy0rIPZ1VOSSSScaecmJ8OldBtRhM17fgrjlPQsj/
 mqnJn1fungvjRJPLvgk5vecwQVEMag/d9gLX5UwHPuMgtt1YIEQizgtIOFx3YjK6Tru7bLP
 /sZeRrObk+HEmQ4vg0hP+ZpJs4vFgF7VOHbkK/rWqiCD7gOjuEK6iaIFCEg2jAJS/C5jZlV
 ZCe6YGTSfpvUmY7niJe6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/BzUzqxwfRo=:+Ezx5UEFC/lEnzMsiiMBpD
 Of+BTwgsnD1mDqKvZb3hrOChOJGyfhyuNh/J+oG0Dp+AR6hVmrkbvYCzctXJCs1qiB/mvG8yB
 IVnJ4AEEgBLF8DQIrdDoV2JsipqCnaQ5c5VaARIZ/A77jUJgOdyB6YbScu21BaG2Rfqk5ew6Z
 87gp6zfs79W90RQfftkm6JsPwofSu9er9Kqz/Gk0H0c3iOO8hzBvl6QiH3sN1vCoBtQbApZU3
 jleo+yUPLQXB26PdcT6fgqRIiquPsVa6bL0dUvWd88LEh5Hzao6xZgh1ZZ/Seve1dTqQo1O68
 eoqB1HRVt28EJxwUxUPHVOHdj85V9kemvc8xxoLhzCLvfpRSLuSkbxnIa7b+F4OQ3ElK9WftJ
 lsRJjaw0PFCojskRJfuPJ+kUxHVP930CC978Sb36Jbrs8tUh1MDac/sAtk5ci0Hsd2OUlIjlA
 5YHVSBNGqjiF3hcKlMxUxxq9j/LLK+jHtSf++R56Cwazi0+PpzbbFamVdQIsJx4k0gkZSmhNb
 kpCkRd+ayHZcav4r/hV9BBFlpgm56GRJb0PhTIZwtIA390gu9BYdBvEM+wUtNg0gBWWvVsgXD
 77J9A133YMukAFP0xI+l3TB6cLwYSORbsn4v146KM3dCUxRc7DcAezrLSL0IkW/C1W4xOX5Oh
 ZCxtm/oMkPOhqeSTCdPO8C4f8vep7m/GvIRdpR3BrkpmZaWGgTND0UOsdTMKnhmF7FRLpqE7m
 wbJC8dyxHimyXeYWyBGAEs7+P9D1GGxmuVlj8eKhMZelKVhUfWnPbtxycGW5s0IIBxnya8stB
 CctKuqh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -319,6 +319,8 @@ extern char *gitdirname(char *);
>  #define PRIo32 "o"
>  #endif
>
> +#define parse_timestamp strtoul
> +

Would
#define parse_timestamp(a,b,c)  strtoul((a),(b),(c))
be more strict ?

