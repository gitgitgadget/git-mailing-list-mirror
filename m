Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E2C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiCBUTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiCBUTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:19:10 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F63E0CE
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:18:25 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4K85663lDnz5tl9;
        Wed,  2 Mar 2022 21:18:22 +0100 (CET)
Message-ID: <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
Date:   Wed, 2 Mar 2022 21:18:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.03.22 um 15:26 schrieb Jaydeep P Das:
> diff --git a/t/t4034/kotlin/expect b/t/t4034/kotlin/expect
> new file mode 100644
> index 0000000000..7062b67319
> --- /dev/null
> +++ b/t/t4034/kotlin/expect
> @@ -0,0 +1,34 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index 3cfa271..20d26cc 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,21 +1,21 @@<RESET>
> +println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
> +<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
> +[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
> +!<RED>a a<RESET><GREEN>x x<RESET>.inv() <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET><GREEN>y<RESET>
> +a <RED>shr<RESET><GREEN>shl<RESET> b
> +<RED>a<RESET><GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b a<RESET><GREEN>y x<RESET>===<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> and <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>^<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> or <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>&&<RED>b a<RESET><GREEN>y x<RESET>||<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET><GREEN>y<RESET>
> +a<RED>=<RESET><GREEN>+=<RESET>b c<RED>+=<RESET><GREEN>=<RESET>d e<RED>-=<RESET><GREEN><=<RESET>f g<RED>*=<RESET><GREEN>>=<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
> +a<RED><<=<RESET><GREEN><=<RESET>b
> +a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&<RESET><GREEN>&<RESET>b
> +<RED>a<RESET><GREEN>x<RESET>,y
> +--a<RED>==<RESET><GREEN>!=<RESET>--b
> +a++<RED>==<RESET><GREEN>!=<RESET>++b
> +<RED>0xFF_EC_DE_5E 0b100_000 100_000<RESET><GREEN>0xFF_E1_DE_5E 0b100_100 200_000<RESET>

Many of the a->x, b->y changes are redundant IMHO, but they do not hurt.
This looks good.

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..bb701100c6 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,16 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
> +	 /* -- */
> +	 "[_]?[a-zA-Z][a-zA-Z0-9_]*"
> +	 /* hexadecimal and binary numbers */
> +	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
> +	 /* integers and floats */
> +	 "|[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*"
> +	 /* unary and binary operators */
> +	 "|[-+*/<>%&^|=!]?=(=)?|--|\\+\\+|<<?=?|>>?=?|&&?|[|]?\\||\\|->\\*?|\\.\\*"),

Some of these sub-expressions match single-character operators, but that
does not hurt.

How many tokens will the word-regex find in the expression X.e+200UL?
.e+200UL is a single token. Also, X.Find consists of the three tokens X
.F ind.

It's most easily fixed by requiring a digit before the fullstop. But if
floatingpoint numbers can begin with a fullstop, then we need a second
expression that requires a digit after a leading fullstop.

>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

-- Hannes
