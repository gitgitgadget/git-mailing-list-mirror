Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5F11FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755546AbdDFUU7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:20:59 -0400
Received: from mout.web.de ([217.72.192.78]:55624 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754719AbdDFUU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:20:57 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFtH8-1cq9tA0YRa-00Eygf; Thu, 06
 Apr 2017 22:20:38 +0200
Subject: Re: [PATCH v5 3/4] test-strcmp-offset: created test for strcmp_offset
To:     git@jeffhostetler.com, git@vger.kernel.org
References: <20170405173809.3098-1-git@jeffhostetler.com>
 <20170405173809.3098-4-git@jeffhostetler.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4da78dff-7caa-b560-8af9-f5a3dfc0bed2@web.de>
Date:   Thu, 6 Apr 2017 22:20:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405173809.3098-4-git@jeffhostetler.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:zKQ4Zl2SmsUGkkmjCF3szY4w6xBf7b+ZGpEKi4wmMjDYYX/GNOg
 YboWWW0tsDTnT3fM7gfNq0/JwJ0+0VifDOdHqIYqsfNpIcuCAuoRQqrnQ/jZM9vWYfO1PTh
 dfqdOIKi+MmffBMlFzLhArogsk9fIPNW3pSc3Y4+5xZ0CF7ocCxJQpdGYJQoBU0EvmWhVv4
 OP5VtHY/DRAVFQJHpw8aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SfpbKcaIAZ0=:Kte1NKMkOnIAq534oxfoEf
 cVral7TsVbVsB+u7advFOzsiuE3RPwp6XEzYdT1GNjmFAnC0O8c9ZGyJjdcHn/cWmsMWTaFG+
 zMJAiTCO/nmEsKJJbDNENMv0eAoe4vJQzR39n6B9Ky8Ghci3z2wfyEDBt0gIVr5aUt7nkD46o
 DjQ0qEmiCUGo0s3RSuHJl2khIQJ3C9A3vMAjcPRFzPPUE2RAchjkzxmeWHD+yktywuJ2xqQHi
 LhP7gzbYCIE+iV5gBOv82pq4SHAHQjwdIXonclWlh4ChRDovrBWiEsQIVl/OrhR+TJ5TO1l1V
 a3Ttn4cuXiUs42Kd4bMmo0aXbHftk4cEyPNgqSzkLcIWErEq17l8iWH7julwmg64C2V1l9lk4
 Igm9t9DuVMx6lQx6YxSvhoSjB7ytvqlTcj8XR9E9IRU6v/OSdDclUO41Nv6QRCP4ZMpJB8A3w
 SC90Rt0tWBu4/I/bfwORXSb0Sru3rHCaPU1JxFOFk0cat5GkRpnnIBMk0B/a+nhi6mKf57zRD
 CHAhvA4K28eC9DOm5OgrEH+7VqYTKBHOOGHHq0jo3/o4SqEbFLtK6k1TSYuqPXkXx5CRBecpF
 2RndkcbZvkMeHvgMjvMOP+tjNOSpX7imtF3uKWJYdYcvw9O8iAfeZOfoTgKpjxMAnyq9Fwb7s
 jcCits3mV4g6a1BkfgU0VjERIk1MlcHuq0O8b/xk+ZJJNU8RKWRoyna4+H2YjYvewlzWbB9F7
 GP5YWC1oSipo1oQZYiocQszF5UQawDz7ENwQoDPFruIQWWvWHITPbhz8PqE2Cap1k/cxwVzIp
 MXsY5ET
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.2017 um 19:38 schrieb git@jeffhostetler.com:
> diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
> new file mode 100644
> index 0000000..fe01318
> --- /dev/null
> +++ b/t/helper/test-strcmp-offset.c
> @@ -0,0 +1,64 @@
> +#include "cache.h"
> +
> +struct test_data {
> +	const char *s1;
> +	const char *s2;
> +	int first_change;
> +};
> +
> +static struct test_data data[] = {
> +	{ "abc", "abc", 0 },
> +	{ "abc", "def", 0 },
> +
> +	{ "abc", "abz", 2 },
> +
> +	{ "abc", "abcdef", 3 },
> +
> +	{ "abc\xF0zzz", "abc\xFFzzz", 3 },
> +
> +	{ NULL, NULL, 0 }
> +};
> +
> +int try_pair(const char *sa, const char *sb, int first_change)

This should be static, right?  Found with -Wmissing-prototypes.

> +{
> +	int failed = 0;
> +	int offset, r_exp, r_tst;
> +	int r_exp_sign, r_tst_sign;
> +
> +	/*
> +	 * Because differnt CRTs behave differently, only rely on signs

s/differnt/different/

René
