Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D801A262D
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487601; cv=none; b=pEoYMCW51JtOZk4+xqtokkQLrmaURoj3Pam2hH0FQ7BExQ9Rm7kzGE+cXZQuwt1F1tRy1LpQGTxh+MMA9cRGQ38f+CqLHtRkitohZ3f+qDkhPEjePO1H3Oiz1pNR7hTDL0xiJHu218ROzLsKCH3reumX7vLN48mJrBbwNC1XfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487601; c=relaxed/simple;
	bh=kgR3UKwVrwrv6diPArNhGLDnUSggaiV/QY8k2ocjzEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfUpf7plRb9ICAZbBgNmNfbIpQZE4YuKDPRaDkBVR2yYH/2R2mUd1FoLdNT/XrA4eMNsi7r4wKSzQO3JqXGEnjo9E0ehG4bcvaXACuEyZPc/yG/JKriCOtlVJNdwi4NPPWLMrOega0lPonGzL6PSkc1C2AkoMicTcdzPzhiVCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=ubNlCHEk; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="ubNlCHEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728487589; x=1729092389; i=tboegi@web.de;
	bh=i79qz/KFvNWtwEaMA+Np33PQdAChqTTc/1WitasR/dI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ubNlCHEkY9nvBkhajUW7GK50gYjs0gyTnql07aPSgvEpBM+rCVjNuhWwngR67og4
	 TEuz6hb9CBXyHnqDmWrRwljGBFDyCdBhZN2zIDyh5cC8gSK/2jW6SINM1LZbdAdQ6
	 jkYMY0n9dOYGBRUSvO5oaQJR/Z0YQY4sUvZ/ZpQXJtVrc5uequRY9kfnt39jz4iAd
	 UYySK6NS4Ph+wLwTdf5jHLd+mWVosVOCg6IVahDpU7WzXntxY6bTBJ+HbnjhXGRFY
	 jOWnn17caUcwYhWNsrrCshhnRtFNJ0LTv3LFGeoX3TU3nXQBOSiOqktt6x99U0chD
	 b7GK9NH6e9luJLDl9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1tp0qM1uvT-00tBdC; Wed, 09
 Oct 2024 17:26:29 +0200
Date: Wed, 9 Oct 2024 17:26:28 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?S=F6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] mimgw: remove Compiler Warnings
Message-ID: <20241009152628.GA16993@tb-raspi4>
References: <20241009103541.2887-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241009103541.2887-1-soekkle@freenet.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:gvS8d+Bxabhbl3j/6b7I4GbjmX47yzEviQ0mY+p+81uCGBv+wjp
 xdea3uDwTCsxd1vcm9dwel9z8RRIG+cUHNdk/Jb5zjKXR/t5jKajWqJ/1yVKzuQhhuFEkkP
 xi6XIjcpoJ1tIFnEgnK95+sLkgRGDQbk1A8zfsR5OmZOuqgqcjIKkVICaYMcTq8HgpXGIVv
 /2BC8BGo2lsIBJt+Sk9lQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X3wN7T4SIfE=;i1me0Rsd7nn57OPBKaKSLdFNn0O
 cw/2k+oqB9SQ7NWrY75PqWvb3lTD/iwlrm5ZRYNVTutkuXf3EyUSFw1Uy8TJVID8BfGdKyBLK
 s4uI6IkIAPrM6Ya8k6RUBtNvZFu83n04P6HMvjHaGoC/baQMq3l41LyRwIvGh6xlOoRFRCXtk
 kaE6j03GyLru4CTnBID6cjGTd4PtGtkFhAvpyTJac/KwvY9XJXP8sX0b68/b/SJAKKUuVjoHM
 iaTz+6CyL5f16V/ZDkU7oBJPwfamXiR/hFsfIonDRIKNvD59+3BXXe/JtsqJzmBn8zozM3ybX
 oE6Hk21X70vOtFPpLluCT39DhZ0UYG3yxOVzoJUOze68Ip7tsPRiIFEGmacmI4hV1V0UNXG0I
 wQNNrV8n0cjqiIR6nN97T2tYcAMjCxJwGuVVg7SWJh7UeFbyHRvnTaBughcKidgrdenx02DZd
 9SKt+oP0NU2nSxsEscvugbrwTYqYuX7PvJNrP59ACCPnLvccFC1wuA/mi/JAZH0+6Xk7MbmUl
 JRTMikhLuqCc9iY5Rc8m1TFvL61n/0aIOET/MYvcBelpcbjGiSr3Th+SFpZW+wdHGu2WaASmE
 IgqxVYqG/6PPzEy4GgRHXDGK3XIunjqQPaXJw8vlIMuR8bvxR3R6P7gV7ClH860O/Bext3iOX
 pgrcxKDEn/ob2rXxNT/0ceDH7JBV98NFHG2MoO3Nxap1VIM3anMgSQ37PKGPp9Tn6gv3Zsszb
 DxvgymXEJhFPVT5kHpoRg1i6Mop6yOMa7qtaMIP0/97qZBqSFOUyR/jSk6ocsSPGGxExsxRti
 zU/3oxvGIWY+CRYWf5OAASkA==

On Wed, Oct 09, 2024 at 12:35:41PM +0200, S=F6ren Krecker wrote:

Thanks for the patch. All looks sensible - 2 comments inline.

> Remove some complier warnings from msvc in compat/mingw.c for value trun=
cation from 64 bit to 32 bit intigers.
small typo: compiler
>
> Signed-off-by: S=F6ren Krecker <soekkle@freenet.de>
> ---
>  compat/compiler.h               |  4 ++--
>  compat/mingw.c                  | 26 ++++++++++++++++----------
>  compat/vcbuild/include/unistd.h |  7 +++++++
>  3 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/compat/compiler.h b/compat/compiler.h
> index e9ad9db84f..e12e426404 100644
> --- a/compat/compiler.h
> +++ b/compat/compiler.h
> @@ -9,7 +9,7 @@
>
>  static inline void get_compiler_info(struct strbuf *info)
>  {
> -	int len =3D info->len;
> +	size_t len =3D info->len;
>  #ifdef __clang__
>  	strbuf_addf(info, "clang: %s\n", __clang_version__);
>  #elif defined(__GNUC__)
> @@ -27,7 +27,7 @@ static inline void get_compiler_info(struct strbuf *in=
fo)
>
>  static inline void get_libc_info(struct strbuf *info)
>  {
> -	int len =3D info->len;
> +	size_t len =3D info->len;
>
>  #ifdef __GLIBC__
>  	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 0e851ecae2..dca0816267 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -782,7 +782,7 @@ static inline void filetime_to_timespec(const FILETI=
ME *ft, struct timespec *ts)
>   */
>  static int has_valid_directory_prefix(wchar_t *wfilename)
>  {
> -	int n =3D wcslen(wfilename);
> +	ssize_t n =3D wcslen(wfilename);
>
>  	while (n > 0) {
>  		wchar_t c =3D wfilename[--n];
> @@ -891,7 +891,7 @@ static int do_lstat(int follow, const char *file_nam=
e, struct stat *buf)
>   */
>  static int do_stat_internal(int follow, const char *file_name, struct s=
tat *buf)
>  {
> -	int namelen;
> +	ssize_t namelen;
>  	char alt_name[PATH_MAX];
>
>  	if (!do_lstat(follow, file_name, buf))
> @@ -1274,7 +1274,8 @@ static const char *parse_interpreter(const char *c=
md)
>  {
>  	static char buf[100];
>  	char *p, *opt;
> -	int n, fd;
> +	ssize_t n;
> +	int fd;
>
>  	/* don't even try a .exe */
>  	n =3D strlen(cmd);
> @@ -1339,7 +1340,7 @@ static char *path_lookup(const char *cmd, int exe_=
only)
>  {
>  	const char *path;
>  	char *prog =3D NULL;
> -	int len =3D strlen(cmd);
> +	size_t len =3D strlen(cmd);
>  	int isexe =3D len >=3D 4 && !strcasecmp(cmd+len-4, ".exe");
>
>  	if (strpbrk(cmd, "/\\"))
> @@ -1956,7 +1957,7 @@ char *mingw_getenv(const char *name)
>  #define GETENV_MAX_RETAIN 64
>  	static char *values[GETENV_MAX_RETAIN];
>  	static int value_counter;
> -	int len_key, len_value;
> +	size_t len_key, len_value;
>  	wchar_t *w_key;
>  	char *value;
>  	wchar_t w_value[32768];
> @@ -1968,7 +1969,9 @@ char *mingw_getenv(const char *name)
>  	/* We cannot use xcalloc() here because that uses getenv() itself */
>  	w_key =3D calloc(len_key, sizeof(wchar_t));
>  	if (!w_key)
> -		die("Out of memory, (tried to allocate %u wchar_t's)", len_key);
> +		die("Out of memory, (tried to allocate %"

Is there a reason to split the line like this ?

> +			    PRIuMAX" wchar_t's)",
> +		    (uintmax_t)len_key);
>  	xutftowcs(w_key, name, len_key);
>  	/* GetEnvironmentVariableW() only sets the last error upon failure */
>  	SetLastError(ERROR_SUCCESS);
> @@ -1983,7 +1986,8 @@ char *mingw_getenv(const char *name)
>  	/* We cannot use xcalloc() here because that uses getenv() itself */
>  	value =3D calloc(len_value, sizeof(char));
>  	if (!value)
> -		die("Out of memory, (tried to allocate %u bytes)", len_value);
> +	    die("Out of memory, (tried to allocate %" PRIuMAX " bytes)",
> +	    (uintmax_t)len_value);

Indentation should be a TAB, not 4 spaces. And why this line-split ?

>  	xwcstoutf(value, w_value, len_value);
>
>  	/*
> @@ -2001,7 +2005,7 @@ char *mingw_getenv(const char *name)
>
>  int mingw_putenv(const char *namevalue)
>  {
> -	int size;
> +	size_t size;
>  	wchar_t *wide, *equal;
>  	BOOL result;
>
> @@ -2011,7 +2015,8 @@ int mingw_putenv(const char *namevalue)
>  	size =3D strlen(namevalue) * 2 + 1;
>  	wide =3D calloc(size, sizeof(wchar_t));
>  	if (!wide)
> -		die("Out of memory, (tried to allocate %u wchar_t's)", size);
> +		die("Out of memory, (tried to allocate %" PRIuMAX " wchar_t's)",
> +		    (uintmax_t)size);
>  	xutftowcs(wide, namevalue, size);
>  	equal =3D wcschr(wide, L'=3D');
>  	if (!equal)
> @@ -3085,7 +3090,8 @@ static void maybe_redirect_std_handles(void)
>   */
>  int wmain(int argc, const wchar_t **wargv)
>  {
> -	int i, maxlen, exit_status;
> +	int exit_status;
> +	size_t i, maxlen;
>  	char *buffer, **save;
>  	const char **argv;
>
> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/un=
istd.h
> index 3a959d124c..ab3dc06709 100644
> --- a/compat/vcbuild/include/unistd.h
> +++ b/compat/vcbuild/include/unistd.h
> @@ -13,8 +13,15 @@ typedef _mode_t	mode_t;
>  #endif	/* Not _MODE_T_ */


>
>  #ifndef _SSIZE_T_
> +#ifdef _WIN64
>  #define _SSIZE_T_
> +typedef __int64 _ssize_t;
> +#pragma message("Compiling on Win64")
> +#else
>  typedef long _ssize_t;
> +#endif // _AMD64

Is this needed, or is it a rest from a trial to use _ssize_t instead of ss=
ize_t ?

> +
> +
>
>  #ifndef	_OFF_T_
>  #define	_OFF_T_
>
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> --
> 2.39.5
>
>
