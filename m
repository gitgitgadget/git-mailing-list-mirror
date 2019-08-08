Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E511F731
	for <e@80x24.org>; Thu,  8 Aug 2019 13:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbfHHNz1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 09:55:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:58157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732882AbfHHNz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 09:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565272521;
        bh=fHbHmrvzi36OvAy/YneczqJH2tukzUFK/dzaUDtLx9I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fE0TPSSYYy/mXeiOEirVOgf2ThgTgMH+y0jVqDWUL37iZPmyK1E/Pft9scLoEPAOd
         hoLwECHIjB3teG0IAyTG1dC9ZXbT29IMWbYE058/lVYrBW2i/tff1G/nehLDYxio3m
         uEPcJFRpOHqFEPwCt1+mCcZCtS3tuzCf5GBmypNE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.183.103.17]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3u86-1iE4z40ZgA-00rbvG; Thu, 08
 Aug 2019 15:55:20 +0200
Date:   Thu, 8 Aug 2019 15:54:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/3] grep: make PCRE1 aware of custom allocator
In-Reply-To: <20190806085014.47776-2-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908081552440.46@tvgsbejvaqbjf.bet>
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com> <20190806085014.47776-1-carenas@gmail.com> <20190806085014.47776-2-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1144544887-1565272521=:46"
X-Provags-ID: V03:K1:8MJRXaiGYJCbPQCmB/pEZuAVJVO/0GAAbZjr5+hy2kRUsApQ65p
 trBfhGwXgo0nf9qkGQ55cYb5KN6xgvDuS9IR+q/0B5cIpP6+rTWlu1o704J6u30W5KWU+tk
 3O3pVR8IzjImiCsKfmhVuBsCcRpQhA9QNpl2qFFphoZaJEs8vSebLaXh8mDtJduOr2Ew3Bu
 pH9U+xLjK3WOjeg0fZiyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VDwyEgYGy9Q=:jSP4ocNmz8AqkTj6cEY5RS
 nIEW4Ea/JPS/BUvtDTZM1wqKyQasr/3y1Yesj8XrC8i/NvYl7YzH5vSlgfwOfu3B94hF3GsoU
 CXwyDQxPdNdnE1JtaiuXRoIRg+ugh+cswFOTlBlbdhvOjqPogcuyk/edPza7Ezp9pGfG0p7h6
 LtAVoG7/Qdhd/ocAKJjKYCsD/04ehsLYx1rrCcyHVvYXuj0uoTYLYDRwgQzglkX8UTYLUxYlB
 nZtS1VKCrbt9nia3RLwSxDNnbVjJFduF6I8WLF0oB6qhpiXtLz7MdFuHunbU9rUdGWIqBF4Jo
 B55hbPkAfJq9kVv7+Qj/cv/HoXoSp9IHjbS2WnH/cuz8TwfQE5eeYLxr4OJW0TIhoel7FbQqu
 XnR5DeOFdq+IuYhtlqk1X9sIIt5JzNUBlYF+SJZPs3Hf3weINV0jbMPImzHnaKFZXE1li9M7A
 XLmaDTDpB6AlmZRVuzYK9DbbcnhRo7fwurqujF12GQq1ZCJILk9xid8Kcl+p1Bb+/yWpvKm1r
 L/7Mk6ceYtAcM/FsMc53vjzLPGL/ze1LvilHHj05gsn9Xd6ZJms3N1iCReXwF0B4lqZdsqdKE
 u/ZMvrJotfieN/xLR19kBbrOkoZkP44N5bxt+hG5p9idmlr4S4Kw6i0kNoPYtkMCyAGao0xdN
 0LUgntOJ9u2GkRK+HB/8WJgOJnsux+z3yeW/LTlI5TEgKab5nUZ99PGIhi/rZCXsJp5qwnMf0
 JtJ6yxZiIdY5lWffvIxjspswRsfItd8+ho4+EhX1W3/pALLQUdC2glS+BNFpQ0e1J63grhV2p
 pEmbOflgnmLUzcOzMVyi4Wgd6avBeSwFDXqGtitXZn4FdgS10sxN+xSOoKH4xH6kwVhLO7vZ3
 v5d7koP3GqILcNilE1v4rEsRHzj/Wcs9q8jA1ItH+YC2n4NmHEWPHqfrBKtolzhYP/Xt2j1O1
 zSC5KlAIfFEhkmvQiMB6oZjdgaVT+4iUbh5NTqqGIkyC8RKJSa4AN8sZ0uTupBn5Bo1Iku6zB
 DiKFOUgnIufubilX3fVFLpxqs2SPQxgk2zVcBC+C30cc5UjYvIh+Ijh0tFmjg2v6t8NkIAxny
 T2DdpFRFAYl2+CjqjArUR5azfY7sGy1pkcJf2j85Q6a9Qm3E1rMBQrbWqaHFAHXQTvNQRhKMJ
 xKHzI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1144544887-1565272521=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Tue, 6 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09) didn't include a way
> to override the system alocator, and so it is incompatible with
> USE_NED_ALLOCATOR as reported by Dscho[1] (in similar code from PCRE2)
>
> Make the minimum change possible to ensure this combination is supported
>
> [1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile |  2 +-
>  grep.c   | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index bd246f2989..4b384f3759 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1764,7 +1764,7 @@ ifdef NATIVE_CRLF
>  endif
>
>  ifdef USE_NED_ALLOCATOR
> -	COMPAT_CFLAGS +=3D -Icompat/nedmalloc
> +	COMPAT_CFLAGS +=3D -DUSE_NED_ALLOCATOR -Icompat/nedmalloc

This pretends that all custom allocators are selected at build time,
something I tried to stress in my commit message as not true. You can
pre-load not only nedmalloc, but also jemalloc and unless I am mistaken
also tcmalloc. And mi-malloc.

So the premise of this patch, that you can tell at compile time that a
different allocator than the system one will be in use is simply
incorrect.

Ciao,
Dscho

>  	COMPAT_OBJS +=3D compat/nedmalloc/nedmalloc.o
>  	OVERRIDE_STRDUP =3D YesPlease
>  endif
> diff --git a/grep.c b/grep.c
> index cd952ef5d3..0154998695 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -150,12 +150,22 @@ int grep_config(const char *var, const char *value=
, void *cb)
>   * Initialize one instance of grep_opt and copy the
>   * default values from the template we read the configuration
>   * information in an earlier call to git_config(grep_config).
> + *
> + * If using PCRE make sure that the library is configured
> + * to use the right allocator (ex: NED)
>   */
>  void grep_init(struct grep_opt *opt, struct repository *repo, const cha=
r *prefix)
>  {
>  	struct grep_opt *def =3D &grep_defaults;
>  	int i;
>
> +#ifdef USE_NED_ALLOCATOR
> +#ifdef USE_LIBPCRE1
> +	pcre_malloc =3D malloc;
> +	pcre_free =3D free;
> +#endif
> +#endif
> +
>  	memset(opt, 0, sizeof(*opt));
>  	opt->repo =3D repo;
>  	opt->prefix =3D prefix;
> --
> 2.23.0.rc1
>
>

--8323328-1144544887-1565272521=:46--
