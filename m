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
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D971F731
	for <e@80x24.org>; Thu,  8 Aug 2019 13:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfHHN5Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 09:57:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:52577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732524AbfHHN5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 09:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565272639;
        bh=Pmal/sAFfdz6+FIB7P6IjCeojNV0swznaqJk+mP8V+w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OUEJu9O68EyeYZQgiLxhhoxfkgIUSHw1Qp281Y6mSyGJLDCJms3xa+T/JX29jx9mQ
         KjloN1pOFxbSBzKLviqj9Te0GXb331tPMuY5N2W2XBaksquJSfsuFEXvRRQxULI8yj
         3e5dwbyvVI8OT13I0oKMFcx2duD27IlYMr9OBG+4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.183.103.17]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6jIK-1iGqnS1M28-00wVLd; Thu, 08
 Aug 2019 15:57:19 +0200
Date:   Thu, 8 Aug 2019 15:56:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/3] grep: make PCRE2 aware of custom allocator
In-Reply-To: <20190806085014.47776-3-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908081556020.46@tvgsbejvaqbjf.bet>
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com> <20190806085014.47776-1-carenas@gmail.com> <20190806085014.47776-3-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1978650622-1565272639=:46"
X-Provags-ID: V03:K1:RkOK2IUijYY+f2CB5pt58rnTuzhHPMXTmhvYMWvraBIsyJXKttA
 1ABMTLzjlcrBjGK6p/LNMtpiFB2h/DXGqQHuqGxjplOmqesXvnj1w32Nlv0Xg0uUStVaqi5
 oW+mRYl0uEp+Uj7bTIxaEswqPalNxs5qUUZbq1a2w8vC7M4x62Ylug4jgkxrPNH4pVQmU+D
 lh/XDVBmW03ml7LIveSIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/eRkCpF+CrI=:4KIXgOl49RkU6obACH69fu
 UHRKdPufidUNL2GVN/1kc2qr42WQXF9w3OPoo80oZwbMIeZPwHPUu0bLiO6uJpinFL+nxCI0Q
 YLknKfyVJNRhTBmz0WZmVoGnYRanYENBoN9O6lf/tbEB9DVt89tNV632FNEv/z7i2fb4lGgFK
 O0TehoC7xGTK9zQIlTtgxHACi2tCBVWmAzag/3FxW1DdO7P+UtM7R4OUMsUJgYj6teiYELmks
 VFsZOl+OtUiiPL6+a770fN3bp/oDdtEosKWH4UDfOa96owdDZ6elQzG4YBNm75dx1jvIMrALy
 3gZY/r2YYKsH4Dc1hKXmH3WvzNrLBP62ekYNXqjo5VS+10dk6blMVlV1nbsbkyYudBpdShofg
 lQjtvXE+6hhXeLorMupDsXVgV1GfXPupPJQjRn14IKLkAwNY9oaGlnOmOq1jtgqvrYA+7Rqqg
 s/xT6k4Ft9dpAQL/COGzBlmkrQStSG+P/OCi0KWt2YIbuBWMj/MWh1cbSMPeH2Ve8n9VhDW+7
 dIAbfRmx2ajCqa2vfCohIXt94aHnKF4ylCm3KhvJkDxqUgUGiZss1Y3/EEB/TSuwPSRilpKXi
 Gf6fzoh/CsE+e/R9uLoS4y2ecNCnPEnyA1RC3/w3zw6JAupZ+g+bs4iICJh18wgpS+UpH0YmM
 x8wq10uzt9fsg+QV+uCRuNKqYidMD8W+AeWCKIbXMtzarP3SPVf24hXWJPZ6OA5qSTToJqg/a
 Z2qIL3nJhv1QC+UqOB2CgUYM1702FxcR6u1TF+YfS3IPzS1BzDXW+QB/b6yqetiKpQDZXxkdA
 9H7nRoX9i+/9i7JKEC6ANUxYv9H/yrFkF6H0Ub0CrASixCu8A0b07YRPOwCnyW4ZPzyZw4PG0
 jZcjvckPjdP5bG7s0BVqVMSygqg+kggE/dhUbyvcUe4rtx61Ew+yqfNxYOrNiWU6fJi6NDUgx
 zwvJ4gRCLKm+HQauUJ+M9+qOOSUsrvzT+q2hNkAXHemUxTLIAMlDI5pvPfXblRcs6NnDrx0AC
 w1DToCKBHmYK+bsZsKvjPGZ7gVu2VLCCxANDqMhumTQsDTPd5ZhicnWvRPUQf3v9PBm3SXeyz
 4EQvHa7ymkP2U712DADKwERX9M+ZOV0sXC4bRC8GHE8JxrSdo6PSt8JSTiLAo8244Z1ocqW8a
 E1y5g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1978650622-1565272639=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Tue, 6 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Most of the code stolen from[1] to easy on comparison and including
> the deficiency of setting the global context even for patterns that
> won't need it.
>
> Ideally, the call from grep_init could be moved to a place where it
> could be set without needing a lock and at least with this approach
> we have a place to clear it (which is obviously missing more callers,
> but at least shows how it will look for the grep subcommand)
>
> I had also dropped most other users of the global context in a failed
> attempt to make the change smaller, but also to keep the current
> behaviour so that we could see the effect of enabling NED for PCRE2
> more clearly.
>
> Sadly, that will likely require a Windows box, as NED (at least our
> version) is horribly broken in macOS (maybe it wasn't 64 bit clean)
> and in Linux builds, but I can't reproduce your crasher and it is
> most likely slower than the system malloc.
>
> [1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com/
>
> Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Actually not so much suggested by me, as your patch still causes
crashes (mine didn't):

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D13935&view=
=3Dms.vss-test-web.build-test-results-tab

Ciao,
Dscho

> ---
>  builtin/grep.c |  1 +
>  grep.c         | 31 +++++++++++++++++++++++++++++--
>  grep.h         |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 560051784e..e49c20df60 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1145,5 +1145,6 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
>  		run_pager(&opt, prefix);
>  	clear_pathspec(&pathspec);
>  	free_grep_patterns(&opt);
> +	grep_destroy();
>  	return !hit;
>  }
> diff --git a/grep.c b/grep.c
> index 0154998695..e748a6d68c 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -16,6 +16,20 @@ static int grep_source_is_binary(struct grep_source *=
gs,
>
>  static struct grep_opt grep_defaults;
>
> +#ifdef USE_LIBPCRE2
> +static pcre2_general_context *pcre2_global_context;
> +
> +static void *pcre2_malloc(PCRE2_SIZE size, void *memory_data)
> +{
> +	return malloc(size);
> +}
> +
> +static void pcre2_free(void *pointer, void *memory_data)
> +{
> +	return free(pointer);
> +}
> +#endif
> +
>  static const char *color_grep_slots[] =3D {
>  	[GREP_COLOR_CONTEXT]	    =3D "context",
>  	[GREP_COLOR_FILENAME]	    =3D "filename",
> @@ -153,6 +167,7 @@ int grep_config(const char *var, const char *value, =
void *cb)
>   *
>   * If using PCRE make sure that the library is configured
>   * to use the right allocator (ex: NED)
> + * if any object is created it should be cleaned up in grep_destroy()
>   */
>  void grep_init(struct grep_opt *opt, struct repository *repo, const cha=
r *prefix)
>  {
> @@ -164,6 +179,10 @@ void grep_init(struct grep_opt *opt, struct reposit=
ory *repo, const char *prefix
>  	pcre_malloc =3D malloc;
>  	pcre_free =3D free;
>  #endif
> +#ifdef USE_LIBPCRE2
> +	pcre2_global_context =3D pcre2_general_context_create(pcre2_malloc,
> +							pcre2_free, NULL);
> +#endif
>  #endif
>
>  	memset(opt, 0, sizeof(*opt));
> @@ -188,6 +207,13 @@ void grep_init(struct grep_opt *opt, struct reposit=
ory *repo, const char *prefix
>  		color_set(opt->colors[i], def->colors[i]);
>  }
>
> +void grep_destroy(void)
> +{
> +#ifdef USE_LIBPCRE2
> +	pcre2_general_context_free(pcre2_global_context);
> +#endif
> +}
> +
>  static void grep_set_pattern_type_option(enum grep_pattern_type pattern=
_type, struct grep_opt *opt)
>  {
>  	/*
> @@ -509,7 +535,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>
>  	if (opt->ignore_case) {
>  		if (has_non_ascii(p->pattern)) {
> -			character_tables =3D pcre2_maketables(NULL);
> +			character_tables =3D pcre2_maketables(pcre2_global_context);
>  			p->pcre2_compile_context =3D pcre2_compile_context_create(NULL);
>  			pcre2_set_character_tables(p->pcre2_compile_context, character_table=
s);
>  		}
> @@ -560,7 +586,8 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  			return;
>  		}
>
> -		p->pcre2_jit_stack =3D pcre2_jit_stack_create(1, 1024 * 1024, NULL);
> +		p->pcre2_jit_stack =3D pcre2_jit_stack_create(1, 1024 * 1024,
> +					pcre2_global_context);
>  		if (!p->pcre2_jit_stack)
>  			die("Couldn't allocate PCRE2 JIT stack");
>  		p->pcre2_match_context =3D pcre2_match_context_create(NULL);
> diff --git a/grep.h b/grep.h
> index 1875880f37..526c2db9ef 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -189,6 +189,7 @@ struct grep_opt {
>  void init_grep_defaults(struct repository *);
>  int grep_config(const char *var, const char *value, void *);
>  void grep_init(struct grep_opt *, struct repository *repo, const char *=
prefix);
> +void grep_destroy(void);
>  void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *=
opt);
>
>  void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patl=
en, const char *origin, int no, enum grep_pat_token t);
> --
> 2.23.0.rc1
>
>

--8323328-1978650622-1565272639=:46--
