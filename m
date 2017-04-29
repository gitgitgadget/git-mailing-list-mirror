Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3945C1FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165629AbdD2W2Z (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 18:28:25 -0400
Received: from mout.web.de ([212.227.17.11]:54762 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033306AbdD2W2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 18:28:23 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPpIE-1d9WXB1DOM-004yrj; Sun, 30
 Apr 2017 00:28:19 +0200
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <edf33657-f74b-3cd5-44a7-8e16231bd978@web.de>
Date:   Sun, 30 Apr 2017 00:28:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kb+DHFEbW8bhG8UxYRWZpTaOJ2+hIIekGiPMAQLoDSn8d6EFIYQ
 zvyEXeJi/NtkdB+eLi3LZNqVu+lYXoJhBUoNGpdrXYuUmP5xXeQLgk7S5h9dQq2uh2QHL8w
 BkkHay3Dl33uf6U/71ZMA9rUQJwLbvL6DD6MYaGZZDJAdk+K1Opi4ycEDsWvmjAmLL8VXpd
 +G6/xPem9DbA2ft4nzYjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ys6oI9/X7nQ=:CKAr0q5gbR2hf+S/09ynLj
 ApjstYQeesFkQYHTI19EwD+JXUSjlAXRb1UFPyaBw25hF2hDnCtORu5GgYd/O87FRCDxmj2sS
 tmEGpuGOkMFvTui+jUJQ8jBptCygQT21r4iQDCrpPXR1gVq9VPUPAUIZ2MVTGAcWgPQ880qjH
 lecqHWGi4EVvEmW6/jmjbYv66oLshlE75/mttqR9Ja5UmzDk4bR+60o2vtLlNUXRFDwjn13uh
 0Zx3PangjfXgaRkB7aR66IgcWQd+BztQPq3q5CsHM87MNJ/rC6Hhib2ckWvhMPR07/PcrKxsZ
 hzTYiEiq+DWV/TbdzvixwfKK+8wI4sztLKunPWTrzQVod3m8jGtGwXfz/ho/jLOm+iZxBiKFq
 gYdm8m44y3m5aNFSE3JVKfy/aAc/TMVYxgD0cS1W+f5TQDTJPc96UwyrERZlZv/+dLE/Pw0EG
 tZeI+oCzxfG1eZdqy2hdl8uEzrgHsSEuQhl0EOrzrUcu3uZMLo0gAMcmOdR6B5F5uxi003y0X
 M8WS/JT/1sz4S69dSldP/LC137AveQtH1PT3FB0cmj/Da/ByK8JXQqabhozgLyffakcpO++gG
 j3c5zL0aCqO0ZVpBQWpYTB9Ajr4YMaRFJtM76hv7wmKsrTdCxcWYxN35KOP4FSpnFrbWWW3rk
 AQIODo/B3SuDFvK7OmRtYB8173F7ESXBAa+WCagLeuqvPT/DiFrk6SotepsAcLmpaXdVU5x0E
 /GUVb7REG9E7X2LWAQzFtSfj0/Kwc7w3+O3JbUmJMNk6/0FHm/JOeNOn9F2hDeE4gY3nES6/A
 DClBPnx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.04.2017 um 23:00 schrieb Torsten Bögershausen:
> This fails here under Mac OS:
> commit 4cdf3f9d84568da72f1dcade812de7a42ecb6d15
> Author: René Scharfe <l.s.r@web.de>
> Date:   Mon Apr 24 19:33:34 2017 +0200
> 
>      archive-zip: support files bigger than 4GB
> 
> ---------------------------
> Parts of t5004.log, hope this is helpful:
> 
> "$GIT_UNZIP" -t many-big.zip
> 
> Archive:  many-big.zip
> warning [many-big.zip]:  577175 extra bytes at beginning or within zipfile
>    (attempting to process anyway)
> error [many-big.zip]:  start of central directory not found;
>    zipfile corrupt.
>    (please check that you have transferred or created the zipfile in the
>    appropriate BINARY mode and that you have compiled UnZip properly)
> not ok 12 - zip archive bigger than 4GB
> #	
> #		# build string containing 65536 characters

Which version of unzip do you have (unzip -v, look for ZIP64_SUPPORT)?
It seems that (some version of?) OS X ships with an older unzip which
can't handle big files:

   https://superuser.com/questions/114011/extract-large-zip-file-50-gb-on-mac-os-x

Is the following check (zip archive with files bigger than 4GB) skipped,
e.g. because ZIPINFO is missing?  Otherwise I would expect it to fail as
well.

René

