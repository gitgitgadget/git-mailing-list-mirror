Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3C51F453
	for <e@80x24.org>; Tue, 23 Oct 2018 16:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJXAoF (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 20:44:05 -0400
Received: from mout.web.de ([212.227.15.4]:50501 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbeJXAoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 20:44:05 -0400
Received: from [192.168.178.36] ([79.237.252.49]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhyU6-1fsd0z3VYI-00n7DF; Tue, 23
 Oct 2018 18:19:55 +0200
Received: from [192.168.178.36] ([79.237.252.49]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhyU6-1fsd0z3VYI-00n7DF; Tue, 23
 Oct 2018 18:19:55 +0200
Subject: Re: [PATCH] khash: silence -Wunused-function
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net
References: <20181023113416.90958-1-carenas@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2518b1ff-d16d-da95-fdc2-698dddb61a36@web.de>
Date:   Tue, 23 Oct 2018 18:19:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023113416.90958-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TfSUwsPfvuTTBRK6uAXRSQCtEGNF9VGrxDakd3F+2x952w524Rg
 JsnAkZWxjnYKP/AE9kVP0X4yuKcN5LpNy/GumGOSqd+j2QBfXA16M9Ip3+A2Y82i59g5Xr+
 J2Ve7IQ22yvstt6bSPeY8PqwTq2HiU0hZ/n9xBTma/S5okaYXpYtloLFiAk9ufAS92XMtP+
 4VThihDwYZVphE2Fv9HVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HjV9xliUOhg=:ktQaapiOW44VcUUrclppTo
 9gidPg17tnyUtMUEfPjeizZSAnuQETBX+WAvmKqTIpfwBGvp6lNAPMHFguf1UqJc3x7R6Hu/z
 ZJ4+YXXUgIrWD+5G78lFjQIO1kspzw+3bqz/ZHR52lFBhyUaSPmKWlTFOYy8YAUcx9cKqgA28
 RtnD5XrSowGzFsW0LJn6u7HVqwb1y3IDXPasDPc2nZ14KMNTSexewBU0yjUXXJVguzsYoHnHj
 P/LK7jRYQeEFehnvErWBuhfwOCZu8W8eaX+7PRYIZmP2efYy6RicBe7nL4BsIOVMZ+yK95MqP
 q+H4be9jB75hr8DiZ3CXzIIKG2FS29MPnqqMcDotWdWamweS7mWDpcWps1zg6teXhxprJUxTY
 eKMcb2XaI/63Hm7rHhKEBhiXqz+WCZqJCXvDYiwRZlRNe8FfnuYadNuw7vyhsDKJyhdq9qV2f
 XjbvQgStOU4d79nz2FVG4bB5bZdFqJg6e1mvK3qHyyRFYhIlvcGeahnxvoAlaf99TnDNHw8zR
 comNcv5wrCNeVuNzzXXR2LRu+WDLmMf0HX9VLNCFdQyzp0J7+2g35jbhwla/DZNPxRHbn8RGn
 uAwgLB5CJJvzd5Pgn5m6NE/ENFV9OYm5mi4SfSUCMpzpfRB1OY0viHAjp6kCbQxcmIkwhTUBo
 b5yi36ouOeS2PrwIYV4fCOb0sChR3mxos6CA4rjKg6tW/s1ua+yWbXUQQRrsarBKX5Zvkoaoj
 bAi9DbtdTIoWvxYbQvBYUSMDJtTEgHS1R005jX98JviSvn8IeAe7h46gelY/ahwo3AHrIbSzY
 m/uT/iZbpGBsRSzhw631iEgvWp1SG+rCQrfooWU7s0kCPcHmE4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.2018 um 13:34 schrieb Carlo Marcelo Arenas Belón:
> after 36da893114 ("config.mak.dev: enable -Wunused-function", 2018-10-18)
> macro generated code should use a similar solution than commit-slab to
> silence the compiler.

With Clang 6 and GCC 8 on Debian I don't get any warnings on master or
36da893114.

With Clang 6 on OpenBSD I get warnings about the unused khash functions
in delta-islands.c on master, though.

What do you get, or in other words: why did you send this patch?

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  khash.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/khash.h b/khash.h
> index d10caa0c35..39c2833877 100644
> --- a/khash.h
> +++ b/khash.h
> @@ -234,7 +234,7 @@ static const double __ac_HASH_UPPER = 0.77;
>  	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
>  
>  #define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
> -	KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
> +	KHASH_INIT2(name, __attribute__((__unused__)) static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
>  
>  /* Other convenient macros... */
>  

This fixes the warning on OpenBSD for me.  So does moving the KHASH_INIT
line from delta-islands.c to a header file (e.g. khash.h or
delta-islands.h).

René
