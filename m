Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2BB1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 12:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfGaMYN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 08:24:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:34267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfGaMYN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 08:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564575842;
        bh=xgiDcNPeDlqB3VWxK8QCQuzqfatl1/eS+SIXQuq7RL8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dARVb2EwDieFX+SFAvue4LXrBVMZfoavF/Gw24Hmdl1SzoHFCw/gCE8Wn3U2odYxV
         5teCnqU8MU+ALmz/KHmc16LMmowQB+SBU1oWxt4zz5Dzq4GxD6HDlDMhYl48W8/c+d
         et9eIKhNpF5TPlzi+Sn1XDtAOaXVVmTLj2llCobo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1iR9e10NZf-018Gar; Wed, 31
 Jul 2019 14:24:02 +0200
Date:   Wed, 31 Jul 2019 14:24:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, avarab@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
In-Reply-To: <20190728235427.41425-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907311421140.21907@tvgsbejvaqbjf.bet>
References: <20190728235427.41425-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-162684488-1564575843=:21907"
X-Provags-ID: V03:K1:Xd9tkwSFnStJ+BDlEjIlf9g7eDdF6GrLxad+o9ae1VXJ73LpjQh
 WifiJ9jypDaIf2zUx+q1mVgxtDFzlwd3/55T3/q7Pst4l/HU1BVhNEfcT0egVWNeQ/2+hoG
 GjmqRYbMTOED+OnsbAe17qbAIh69F+PyEzSc3vOn4d6laqIW7ZUQ6rkwfi5vL1Apfuvb+yq
 L/ZOqvn2GxDnJzE+e5nkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tuqbew2f9hw=:Aw2z8fthd9sTRSpJeKGhhN
 GZhtoPnC74iLZPRye5o5S0PsduIEKfSqgrW+CPvQkxXqiHZ7leG/XJarqRQsTDOJmXTKNzCnF
 S/zJjQr2CXUJXJG+W7avwgYAEyq4K/G7XV2IdG/bCOtseFkutKYvHhCflqkdjPd5NkWlgCnrN
 IZxQA0zbgXuDZ4u7wp6alc23kx4kdEPkEyn77WVnDPBzW8iVXL0j4GIfe65pge+hL68r3I3Vv
 I2WNmUF5vckLro73EBzaQJdQRqs54g0xWTgexjSWHkkvJQBZZuDFYyL5H/2W3+2C/H0kGHwKO
 ClDiVaXWsufS6NW9P71NWibf4uKxTA9BlwMEX1ZyYV06YhYsXrG6CJa8UUSgzQ1NdrL4tnqkH
 BGhi0HBFt9CGV7IS5Sg1H0Ufez3SGbsaAyccsONYJJvLdNOybU+m4sXbyKotaDZDS6nR0Y+Mq
 YupVZUONSOmQRcIcP08ge+LVj6W/UIM0g6dTiH9+T83uiSRJpfYOrALlitWth84uSsYftfijn
 tOmZ03BdTPnsYdYJqssVgS6ZEKd+Z81tpCSDkV3VTKMMVw81wBn9VI6/uXv2jmm5GrHQWfmVr
 s6GHalw5tt/9NuRT0IcuOuctXikEgPig/kpnemVScf4t0WqbZblCRxaV1L0iHiD5uY2s2yF6c
 5uG2YhJu+YZ5caT58nwvKbVfDkRZaKnTNyNBG7sPYaJz+b45mb5gX34yZ4PkZDDU8cIJhTNZd
 08vOTxzWf56zkXrxCRGaCwhx+OeY0woo6s/dVi7p0cG8KdPz64bcoq/npGMdYeMWiY2SIBqQS
 ewo5sHeUxP+iXtqxIQ/884euZPy7nrGQ4Upd3+MSyyH0PzdxwIyyUtlIUCosCPtxJ0dk4teKS
 QsxHW5sQZhRivpqfJZWzMagjGP3JBbyQu7mi3BlPl18S/B/MzWz/MKI3CIu5Mm1oOMaohNK6d
 V+cERSwjD06AF+cFkSQKHyL2gJXWAvNwtdP46iMUMtb2AJWgJ/ijvDHn1kZglXUHnXOwI0vJF
 CSjfCC7oRiXYDNeqZGzn0YNgMcC7QVgd0oIyfPAYKJtEtuGn6qDsMhwYtRKc/k5VLVS/DI233
 +wZmZX5vRxTG97tD9FMHIFgxgRsrnBh69zO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-162684488-1564575843=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 28 Jul 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 never
> had one, forcing the use of JIT if -P was requested.
>
> After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
> the PCRE2 engine will be used more broadly and therefore adding this
> knob will give users a fallback for situations like the one observed
> in OpenBSD with a JIT enabled PCRE2, because of W^X restrictions:

Just so that nobody else needs to feel like an idiot for not knowing
what on the burning planet "W^X" is supposed to mean:
https://en.wikipedia.org/wiki/W%5EX says it is essentially an OS-level
mechanism to prevent executing code that was written into memory by the
same process, i.e. JIT.

Makes me wonder whether node.js works on OpenBSD, or any decently fast
web browser like Firefox or Chromium...

But I digress. I just wanted to chime in with the results of my web hunt
for that "W^X" term.

Ciao,
Dscho

>
>   $ git grep 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -G 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -E 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>   $ git grep -F 'foo bar'
>   fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Documentation/git-grep.txt |  4 ++++
>  grep.c                     | 15 +++++++++++++--
>  grep.h                     |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index c89fb569e3..ff544bdeec 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -69,6 +69,10 @@ grep.fallbackToNoIndex::
>  	If set to true, fall back to git grep --no-index if git grep
>  	is executed outside of a git repository.  Defaults to false.
>
> +pcre.jit::
> +	If set to false, disable JIT when using PCRE.  Defaults to
> +	true.
> +
>
>  OPTIONS
>  -------
> diff --git a/grep.c b/grep.c
> index c7c06ae08d..3524d353dd 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -56,6 +56,7 @@ void init_grep_defaults(struct repository *repo)
>  	opt->repo =3D repo;
>  	opt->relative =3D 1;
>  	opt->pathname =3D 1;
> +	opt->pcre_jit =3D 1;
>  	opt->max_depth =3D -1;
>  	opt->pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED;
>  	color_set(opt->colors[GREP_COLOR_CONTEXT], "");
> @@ -125,6 +126,12 @@ int grep_config(const char *var, const char *value,=
 void *cb)
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "pcre.jit")) {
> +		int is_bool;
> +		opt->pcre_jit =3D git_config_bool_or_int(var, value, &is_bool);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "color.grep"))
>  		opt->color =3D git_config_colorbool(var, value);
>  	if (!strcmp(var, "color.grep.match")) {
> @@ -163,6 +170,7 @@ void grep_init(struct grep_opt *opt, struct reposito=
ry *repo, const char *prefix
>  	opt->pattern_tail =3D &opt->pattern_list;
>  	opt->header_tail =3D &opt->header_list;
>
> +	opt->pcre_jit =3D def->pcre_jit;
>  	opt->only_matching =3D def->only_matching;
>  	opt->color =3D def->color;
>  	opt->extended_regexp_option =3D def->extended_regexp_option;
> @@ -393,7 +401,8 @@ static void compile_pcre1_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
>  		die("%s", error);
>
>  #ifdef GIT_PCRE1_USE_JIT
> -	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
> +	if (opt->pcre_jit)
> +		pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
>  #endif
>  }
>
> @@ -489,7 +498,9 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  		compile_regexp_failed(p, (const char *)&errbuf);
>  	}
>
> -	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
> +	if (opt->pcre_jit)
> +		pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
> +
>  	if (p->pcre2_jit_on) {
>  		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>  		if (jitret)
> diff --git a/grep.h b/grep.h
> index c0c71eb4a9..fff152e606 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -151,6 +151,7 @@ struct grep_opt {
>  	int allow_textconv;
>  	int extended;
>  	int use_reflog_filter;
> +	int pcre_jit;
>  	int pcre1;
>  	int pcre2;
>  	int relative;
> --
> 2.22.0
>
>

--8323328-162684488-1564575843=:21907--
