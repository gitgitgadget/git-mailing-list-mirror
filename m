Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09EB71F731
	for <e@80x24.org>; Fri,  9 Aug 2019 21:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfHIV03 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 17:26:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:34057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfHIV03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 17:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565385983;
        bh=LgrFTPXZcsNclmhHm48hqAsVnTavXbkBzMq7UdG04tM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AWVq27z39993C40Z+cljscEHBfzCMCyfFXgplyCxK3j9xB1qYH7iiLmrPc/EIFlOw
         44kQc+sfetDWOu3lC+Nq9vWrdaGGjTgi2HP5zk0GD8keVhyZX8c7Y84e8+PnFktkb1
         9o/sqw2zvgP6u8l8+shcAnA/9PwxVN91ValFuXBQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WRI-1iEiDT0S5s-00yghV; Fri, 09
 Aug 2019 23:26:23 +0200
Date:   Fri, 9 Aug 2019 23:26:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no
 crashes
In-Reply-To: <d239326e-11c3-5875-13a8-f4123baea6eb@web.de>
Message-ID: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com> <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com> <d239326e-11c3-5875-13a8-f4123baea6eb@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1158604040-1565385984=:46"
X-Provags-ID: V03:K1:ciqkqrzRvwr3hBqlcZNpFMRmqQ0To0KzbvoDwrU8GtVn1JXvf2M
 rXnALlXV9HfYwB96mzREu70+LJhhYiglQthJ5ZDalw1CXE+NdnwNxTkgqV1JyfyM/8tINZE
 rfDKOqxYfcmSaaF20O8XKS9a0iHKkL/MGXIr4pUyIByeij9hhK63VfKgFUYd5v/QQtAET16
 RUoPvZrDyIhR/PlAubpGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZcDEeGwPM60=:bQKXEOTDPnVA6iDRwMt2jN
 lb7Nn7rIftIR11d8EszP2jN8zqH2+O+53gpVk9uAn8w33Y76+49vzt4tOL7nWqTWjenHiE8LP
 0f1J3Fer16O3+mmpDu/f8PNX1JYBmzjY1kFh8Oj+1sAdaa6NsQIOpRSU7ikF5p77cDnZ7Pc/X
 XmCb40/ikAYx0zHd4SJ/0gr+ip5JdVPDHnybNE5Bhk8ZNree9eCWORO0vIARn+V2Ez7fcdU6N
 g/j1LcHkDVZ9jW5BdzDlyK7zht7mDMyjQmEgaM3JKsR5qawNZGByQOPBjpNpZFQ3JFyBEjWaJ
 PRfDaFLWyvmES4w9N1pgEJlY6d8+P40RPgyrBuhLjcGmlBKXKwcFQj51ELs9gIdrJmeXT6lGh
 A17ZoUovHNxiPBZblYFr//27dpPYGvZS8yCxINLD6xVbRLQKR5zGfJjukHK7vG5FyfdoBLpLw
 qsYAnSx8WJ97hUE6x0riuIUBBA2rN0mozYH6F1rVgZiljZX89/YsyD2bT6FOCunSnJ4meqKVe
 b6rBVKmv82J4rMpbSlDZG3mzcC8ytc4Hl4/HHyYR9zVrr0paWmlzV0enXnG9/FG8rGJguSgfm
 JECdgZrfb3Slg/FAdm11kumnhIO+JsVKfB4FVdW7lSYNI2bNq5ayFmWCq8poX1kpVNxCCGYoa
 avfYIEgw6WwZLc+fyEvBJjTfZ2kgGn9ccEWtHlDJxc1odmJtEvhfe5hBFikAEfeTxlwLTgCpe
 m6NFBNhnbr7mLqdW9l7Ab2Q11uyKGnW6FgQdkTSP0g1q7EQVBe9fifzYWcVkWrXyJwcJPJDbM
 KXo9vDtKRj1cEoTtry2+8LN7dJvn5pu1WRC8DI/vgR2kvI4Z8ZNUEzuBwdB7LEFCxDmZK1tYM
 gbHVVwmsCFt3/zwrXxLd5rUaUCC66WCBUNw64/FCJXLYp2PZfl1hepT3coLxQFy7JOPdi5kvp
 pisQIOZaADGsUkbl+ZGukaUmoHAcWVMZJT0mbV6d7VF8Pvsgbdg/V157mvGY0cIFX+oZHi0cB
 RmuTahOc1wTw/dFBapRAK7KqwMhD40oShw0nbD1xj3SbUFXv5wm5z+yXFyI79h6PfRI0JtMLk
 QLGFW6uWScw5ZEApW2NMgdYBYW2AJ6Y/olR3yjEd0s/xUKhM8gxsFzEWA/VSh/VY2YQE/fsWI
 ImS3U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1158604040-1565385984=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Fri, 9 Aug 2019, Ren=C3=A9 Scharfe wrote:

> Am 09.08.19 um 13:24 schrieb Carlo Arenas:
> > disregard this version, it still broken (and wouldn't even build on
> > some cases), the reasons why are still unclear though but at least it
> > might
> > seem from the last known run in windows that segfaults were prevented
> > at last and something was still off enough to trigger a BUG (shouldn't
> > be a concern with V6 or later that do PCRE2 migration to NED fully, as
> > agreed)
>
> So how about starting stupidly simple?

FWIW I am very much in favor of this approach.

Thanks,
Dscho

> You can test it everywhere, it just needs libpcre2.  It works without
> that library as well (tested with "make USE_LIBPCRE=3D USE_LIBPCRE2=3D
> test"), but doesn't allocate anything in that case, of course.  The
> character tables leak fix should be safe on top.  If you detect
> performance issues then we can address them in additional patches.
>
> -- >8 --
> Subject: [PATCH] grep: use xmalloc() for all PCRE2 allocations
>
> Build a PCRE2 global custom context when compiling a pattern and use it
> to tell the library to use xmalloc() for allocations.  This provides
> consistent out-of-memory handling and makes sure it uses a custom
> allocator, e.g. with USE_NED_ALLOCATOR.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> The function names are ridiculously long, I tried to stay within 80
> characters per line but gave up in the end and just kept going without
> line breaks.  Fits the "stupidly simple" approach..
>
>  grep.c | 23 +++++++++++++++++------
>  grep.h |  2 ++
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index cd952ef5d3..44f4e38657 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -482,6 +482,16 @@ static void free_pcre1_regexp(struct grep_pat *p)
>  #endif /* !USE_LIBPCRE1 */
>
>  #ifdef USE_LIBPCRE2
> +static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_da=
ta)
> +{
> +	return xmalloc(size);
> +}
> +
> +static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
> +{
> +	free(pointer);
> +}
> +
>  static void compile_pcre2_pattern(struct grep_pat *p, const struct grep=
_opt *opt)
>  {
>  	int error;
> @@ -495,12 +505,12 @@ static void compile_pcre2_pattern(struct grep_pat =
*p, const struct grep_opt *opt
>
>  	assert(opt->pcre2);
>
> -	p->pcre2_compile_context =3D NULL;
> +	p->pcre2_general_context =3D pcre2_general_context_create(pcre2_malloc=
, pcre2_free, NULL);
> +	p->pcre2_compile_context =3D pcre2_compile_context_create(p->pcre2_gen=
eral_context);
>
>  	if (opt->ignore_case) {
>  		if (has_non_ascii(p->pattern)) {
> -			character_tables =3D pcre2_maketables(NULL);
> -			p->pcre2_compile_context =3D pcre2_compile_context_create(NULL);
> +			character_tables =3D pcre2_maketables(p->pcre2_general_context);
>  			pcre2_set_character_tables(p->pcre2_compile_context, character_table=
s);
>  		}
>  		options |=3D PCRE2_CASELESS;
> @@ -513,7 +523,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  					 p->pcre2_compile_context);
>
>  	if (p->pcre2_pattern) {
> -		p->pcre2_match_data =3D pcre2_match_data_create_from_pattern(p->pcre2=
_pattern, NULL);
> +		p->pcre2_match_data =3D pcre2_match_data_create_from_pattern(p->pcre2=
_pattern, p->pcre2_general_context);
>  		if (!p->pcre2_match_data)
>  			die("Couldn't allocate PCRE2 match data");
>  	} else {
> @@ -550,10 +560,10 @@ static void compile_pcre2_pattern(struct grep_pat =
*p, const struct grep_opt *opt
>  			return;
>  		}
>
> -		p->pcre2_jit_stack =3D pcre2_jit_stack_create(1, 1024 * 1024, NULL);
> +		p->pcre2_jit_stack =3D pcre2_jit_stack_create(1, 1024 * 1024, p->pcre=
2_general_context);
>  		if (!p->pcre2_jit_stack)
>  			die("Couldn't allocate PCRE2 JIT stack");
> -		p->pcre2_match_context =3D pcre2_match_context_create(NULL);
> +		p->pcre2_match_context =3D pcre2_match_context_create(p->pcre2_genera=
l_context);
>  		if (!p->pcre2_match_context)
>  			die("Couldn't allocate PCRE2 match context");
>  		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_sta=
ck);
> @@ -605,6 +615,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
>  	pcre2_match_data_free(p->pcre2_match_data);
>  	pcre2_jit_stack_free(p->pcre2_jit_stack);
>  	pcre2_match_context_free(p->pcre2_match_context);
> +	pcre2_general_context_free(p->pcre2_general_context);
>  }
>  #else /* !USE_LIBPCRE2 */
>  static void compile_pcre2_pattern(struct grep_pat *p, const struct grep=
_opt *opt)
> diff --git a/grep.h b/grep.h
> index 1875880f37..73b8b87a3a 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -28,6 +28,7 @@ typedef int pcre_jit_stack;
>  #else
>  typedef int pcre2_code;
>  typedef int pcre2_match_data;
> +typedef int pcre2_general_context;
>  typedef int pcre2_compile_context;
>  typedef int pcre2_match_context;
>  typedef int pcre2_jit_stack;
> @@ -93,6 +94,7 @@ struct grep_pat {
>  	int pcre1_jit_on;
>  	pcre2_code *pcre2_pattern;
>  	pcre2_match_data *pcre2_match_data;
> +	pcre2_general_context *pcre2_general_context;
>  	pcre2_compile_context *pcre2_compile_context;
>  	pcre2_match_context *pcre2_match_context;
>  	pcre2_jit_stack *pcre2_jit_stack;
> --
> 2.22.0
>

--8323328-1158604040-1565385984=:46--
