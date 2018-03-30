Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731351FAE2
	for <e@80x24.org>; Fri, 30 Mar 2018 06:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeC3GSP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 02:18:15 -0400
Received: from mout.web.de ([212.227.15.3]:41099 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbeC3GSO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 02:18:14 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5OaF-1ecYEj3BS3-00zXbA; Fri, 30
 Mar 2018 08:17:58 +0200
Subject: Re: [PATCH v2 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
To:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180330052830.57251-1-me@ttaylorr.com>
 <20180330052830.57251-2-me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9e25f8fa-6518-5c15-f249-c874dbe1761c@web.de>
Date:   Fri, 30 Mar 2018 08:17:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180330052830.57251-2-me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1QUTOMuuFKyXJobkjsvGT3PzZ2upJk/qEhzIsNUIWRrdVqiep4u
 csjjazH4Zzxg+NlFVaLi1mFI4xfcf4Hx5dUHxAHZn6ckQoRZMTN8nJ9CtnVoJh2A046YwrK
 pPx3EjZa5lAs0WPIn0oxqOj0GbEUxUXFUd69lBKTYL5BszQRXGLb08kvWWbrfSLA0astd84
 fGFZTxbqbzLm8oC04mY3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r4KXas8C/A0=:xsziddAbLoBFGmOfZ6Upob
 XXKOdHlQqSBCtObpiAX6Ljwo3RHbd/bsrJa+KQTM14z5kPrKQtxDGv9h392cGQBGYqNv6tkLw
 tXUtKmQqMRGR2ujw8jO6C+787sqvkqC1HA1aprSp228MdOoJoACwJPjDtJkOdjIH6fhVlkOXC
 LBdCIceOFJ4Q0K4aW1zu/3YC45B6T+VlqJOWzDydbXC89QIrrW6KQuwxvOBQeNTUbeXR4FWQv
 tGK8xap9VLyFKiozIJ5znJU0WYRE23EdWMSKSDnSalrZiyHRaUtvksesznaAhQytJRsYLnJuX
 RmiQJyoWfhlctQc3j1lPVEP3VMkLA5mMQDIfLniBUgevz5YHnYsZVxwdcgpoUORd5XQu7DWvz
 873ufrVtFzL5PULG8K8C+T5xcRDJxsNzqLDZBGhFet/pvpdnTY996noMqYNwkp+NR7zDWfqb7
 AR8SLXI1sn6BXLg8XIF4LkgqHjiGZTtPBVEGiJxR9V4zGBwHfzlZT0/kmIoC6dg8sbHh+sQQX
 kedSsy7/cNGxLy4SkD8mH5Zz/ltJdzv/EijWtEvrOjnLFBrkVdWkaOpVArFzYrV7b9Q703Qt4
 OLidGRjoOgSByD+o2fJLkxCOQetI+h8Y24fIMsW2UJekGHvqFzwILXUERMHKjQmgwAdP/src3
 G6MOe3v1LghTY1tqwrcRueRaukekOUlcO3y3Nje9QDlZ8IjoO7J1xqS8FuYZgvb22GuzpH+Av
 L8h8/FsIH+KFKcKcpphEPyvD6Qqjj4rgn3+8tPJc8l5UrdLgjdxppdk7BMWgMS5/s+3WDvToh
 e8RP42RnLT3gLpUGe9hEkgDlyAHH5sxWdSjQxrot84/YDBB/D4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.03.2018 um 07:28 schrieb Taylor Blau:
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index e09ed5d7d..9956b03f7 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -160,30 +158,34 @@ See also <<FILES>>.
>   --list::
>   	List all variables set in config file, along with their values.
>   
> ---bool::
> -	'git config' will ensure that the output is "true" or "false"
> +--type [type]::
> +  'git config' will ensure that any input output is valid under the given type
> +  constraint(s), and will canonicalize outgoing values in `[type]`'s canonical
> +  form.
> ++
> +Valid `[type]`'s include:
> ++
> +- 'bool': canonicalize  values as either "true" or "false".
> +- 'int': canonicalize  values as simple decimla numbers. An optional suffix of

s/ize  val/ize val/
s/decimla/decimal/

René
