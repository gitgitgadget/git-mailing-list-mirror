Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CEE91F731
	for <e@80x24.org>; Sat, 10 Aug 2019 13:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfHJN5w (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 09:57:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:60713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfHJN5w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 09:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565445466;
        bh=2DIYfLU0S8F1AiJEY47TW4rqyFaopICCFli8J3ZzFh4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QFCM/505Rr4M6vAllUW8DGEF1o/YM/IeNw5juKxyQDv1dP6eQ6iUnDPr9XRo3ewrS
         gQQjkg2jOZveODupbXDBvsM8wOuhrLIEg1QTvB8kUsnshEXb0tdC/FGuViVSAyFD67
         /iTmjcTHEyn86tdGA1CcV6W9MbPF4Fg6q5B8+vt4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtIdP-1iKC253EiZ-012siE; Sat, 10
 Aug 2019 15:57:46 +0200
Date:   Sat, 10 Aug 2019 15:57:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: Re: [PATCH] SQUASH
In-Reply-To: <20190810030315.7519-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908101556530.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet> <20190810030315.7519-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1402099990-1565445468=:46"
X-Provags-ID: V03:K1:Dk1vOwL8C2KHxu0xA54z0VVP6h9zt4pi1kklhF1lg2wH8toQdH0
 t1ispjIwXM901hP+TNuzdYW6SHeJywg7+E6NyzVwt/HACPcBG7jyIDRnW4rWYpT61kOnq4w
 ZCHfj8hZrJaEQGII2Hfka1mtXWQtmUaKmmWMewOQej1nfg9Ak32exDn0KDpSWnq4zY7uFdl
 mp94Waonsb0zXHRm3P4Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KuD0ZMfRsCg=:9Ex9KyENBzJ6uQZtW2tV4p
 UWS3Mz8SwTiNasGfGoC/hRR3YWE9glcYJLcg8I4WQjePEps0fyZH1uLY6iBlBNHd/wdlGEFK0
 wTXm6kqW4PtEXY8jrIxwJuPGsifjoCdnOO5k9oat8wrrKdjBytp5BGZ9Q8UozpPv2pdyLNcOs
 Io3exlIULNnlxYMwZ0hbG2CDlB1W14MnFhPAlnxh2cgRjiTgkd0T5xj9vYXXGtrfCwUfKVoP+
 iiKvEvXXPRFftehCtRZSarRgW1TsSpFe65wUNsrE/gtRcoEt9HYbHwPw+hv41jSAn3BxOlIJM
 O61W6mu4iUt2W3FsH8l3e2DUBxHrSDP6Zn8Cmx0d0IZnL6yQNwCiQD35VzNLZJ1jnc8YmHlsf
 j8NK2CVwfDWmyzLkocJ4EA7jMCLvOShEOLSm5Z/uC0KbiCdmDwRQh7BBsRCW0Ts2hK8NHhaEW
 7bO90WRM+maZ3t17RnOrq9Md+SYP7BLWHwmi+1/kwsEEA0PMDYXwzTf13tTOqSE3V5fWgHYZ8
 e6LNTVC/ILpvAJVLGXuCCTKGj03id3RGBEEA4Tr4qkmCm5N7eK0flJXHw64nsCxRiqr8yPwOi
 1E1QgiEQl4uI9a/i0nQZVYD8tGLygpEp8hsTr9T6uWJZvjioWnCtglQuC4iW4OQjyEGUji+6E
 8IsDpESPBF5Fon4q1jSlWbdLh1AderPLZa9/OptNjgnJMMPyliIWWEv2PDoCbSBf5VRMWxez8
 EtbSQo7E2Z9mJ0h1PnLKAXOWdHoxH3wYHE5yGzlR2SCJ0uVdRE037sVmsJIZL+H53JvVI3wD1
 6EUvfHqQjbNuObutwVJ0B4UGXEJglNVkqdAkp81wj2fl18p5zdZ2HB9ZdazbqawWmOEZTLx8o
 ZCgTiqGk/jp5cWdUWhiJ0T0dUq3HiUiDRS3dWx7WqNc+GmyuGLP2IcDXauAmKtlFpuP1O18Is
 G39znibyOyOdYpeuEnMWpdZGjOgu06ox8dxP9ygTB/wolelYbzYlpp4NL75TC0/KC7+yz+AJ8
 grMonjaxjMMZA390MV6Xr+kEixBD5R9/Kuz+zLSEM0aRzkyJxRmMicx3yOmL9QS8kSLmJ3Eik
 zD5+qmJX1dusVx21RoysLxonvSDHTnSxkLr2WAeyqKJYj5zFKs7AYzVnsEc8Py1OzfR1Jsbq/
 5L3eA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1402099990-1565445468=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Fri, 9 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> diff --git a/grep.c b/grep.c
> index 8255ec956e..233072ed80 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -482,6 +482,7 @@ static void free_pcre1_regexp(struct grep_pat *p)
>  #endif /* !USE_LIBPCRE1 */
>
>  #ifdef USE_LIBPCRE2
> +#ifdef USE_NED_ALLOCATOR

I really, really, really, really, _really_ don't want this to be a
compile-time thing. Really. No, really. I mean it.

Ciao,
Dscho

>  static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_da=
ta)
>  {
>  	return xmalloc(size);
> @@ -491,6 +492,7 @@ static void pcre2_free(void *pointer, MAYBE_UNUSED v=
oid *memory_data)
>  {
>  	free(pointer);
>  }
> +#endif
>
>  static void compile_pcre2_pattern(struct grep_pat *p, const struct grep=
_opt *opt)
>  {
> @@ -505,7 +507,9 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>
>  	assert(opt->pcre2);
>
> +#ifdef USE_NED_ALLOCATOR
>  	p->pcre2_general_context =3D pcre2_general_context_create(pcre2_malloc=
, pcre2_free, NULL);
> +#endif
>  	p->pcre2_compile_context =3D pcre2_compile_context_create(p->pcre2_gen=
eral_context);
>
>  	if (opt->ignore_case) {
> --
> 2.23.0.rc2
>
>

--8323328-1402099990-1565445468=:46--
