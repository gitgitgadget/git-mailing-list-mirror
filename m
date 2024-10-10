Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0315B0F2
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587991; cv=none; b=Jm8zVrI7Iu9JIPSRhNglOVC+Tay/vjjCQxFbYBTnJ2uEX7Jl9KNbzYPyDKCB0G2zDQ8GWU4fkAn87O39ZMmToiToVlno/HWFk+UUxtbYIaKrWbjt1qoSVoK0H9eHpYUEMCBTS0I2iiu8mcRtcrwzCqv3KBAlwHq3ZDscoLJ3ekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587991; c=relaxed/simple;
	bh=+RCkzTZ7qR5lX8COL23ejsVOsPxtttu43zlA/afIfy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpyZQsJCe0x5xje/bVqarxy1xD+sGGCJLwSpMgB7w9QEAgBKyJI9KAb6+tUbEZ0Ka8Ocuv2nUyTTKh1mzs5nBoMtPzT+4KTCgk9hq28BsPhEcnJs4bO5cZWq3uZlJUi3VdrOL7FtPsfsbxu1dNYltuX7kQPAecdA7GS0sH+Q96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=HShG/QKk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="HShG/QKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728587980; x=1729192780; i=tboegi@web.de;
	bh=JmcdfO/JWC4Ysx5S5buMSaEjaI5dTqHc2fNB28olM34=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HShG/QKkPkoIS3eE2bT0Lq9PA/0Q08LMAprtgPnwRleopp9TTYA2scvBUpvc/OS4
	 asvsCtQ7O5XHkvRiua5vqLTRSxlESx0Yq1mV998XZtJxMrdtb/98UHKSovvorL1CG
	 Azm8JO9xfOYcrYWYugI8adFOR2R7YyPiQxv9b2jYlEc8Sm6R8eoNreaArZPeCFfyc
	 B3mQsh3yYJOiOghgz1s8yHR5lm4lvphjMoakKW+Bnm3qDCajW9kiVo9IETkp4+ADf
	 JNpaulCauexcZY2A23Z3v8LJ6D8N7bebOVIRDGMSn/CvGlVXTSue6olHbuRIFFBRZ
	 mC2ctouJZOYA1gd1iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79N8-1u23ea0O6e-014mpt; Thu, 10
 Oct 2024 21:19:40 +0200
Date: Thu, 10 Oct 2024 21:19:39 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: =?iso-8859-1?Q?S=F6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [PATCH] [PATCH] mimgw: Remove Compiler Warnings
Message-ID: <20241010191939.GA17171@tb-raspi4>
References: <e7646092-84e0-4210-88e9-98352e1f60e0@gmail.com>
 <20241010102950.2151-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241010102950.2151-1-soekkle@freenet.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:pzz01ikXHaM5er8ODqu4zyaIxd9hBqudyrODuFADWN5g3Hxsq3F
 NLU18gHz5TxgOe/YvAv3Qvy937cZ/K5HytSeA7jzqwb03PfAR7FYgKM8AWzPOK3gAwVKqr4
 v0oWLS/a0NMJ9xdCznrvF9FUXsEueLk/ygBiHfrivANs4OEgdT1uwh9dCE8eW9x78zzxylX
 oh+BY0Pb20DZqwpaXZjLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n9ydRp3kKzU=;MxXG964rKn4Tc5UtRdrzSlRiQWf
 HtdHhvLCPvx9x0yuwZgKRgEyd8//D62VS1qbYKl7jRfSLdWagzgFcfejZob2DoeUpLII2UbRd
 QqcRYL8acLvge4Q+f+jZHvhVOmju0nELLlno+80/tW41kz50Dku/F4Tew0Cf4UkYOKJFKYPuO
 Ae+vgP6yryKYXzx2kW5NIRDNM/13ILjb+XvdZod1te8Xm6BZG6jf2Wdk102igwdlTiuhiVuZ9
 qiGNmgv122FsC/ZErlxwhXJ08NJiV4LpO2LLZLDE2tTdU2xYOOdw/sR1GWHgdeIyagiKwg1yZ
 wTbwrQncQ8PW3qC6Otq+IQNryx1rcyJNx53eOGfk/SlNeGvL9TNolW6e6ZStWcMKhBZvHcgbo
 uHk3QOOqhKD95cL8U8MhCgWW2LuWLEzVazRE6fvpNDAh2J5GW3bCZ0Ie8MpBKstEyz6Syae1f
 psXLDMzGcj5pvy7JOE0Hw7UxPU0pmh+C4/qBS7Uv8mGvYyjkJwYl3mcArmDmSDscORFEsB5fb
 Di+xT7IOzA9f6qBA5vFYHOClxDYNI7Uv3e+iFEcMODKo7BOb8kS6yEBYU3TV4Dg3D7yc6Ylh5
 uXTT4vQRAyTMmeCS6OtpAkkwjM8aodzTfookMuwUkAAGS8KKq1I/NgdbzWxjS6UbF1Yq239Me
 H8ZXrzt9L5s8l0Sw5c43ByCnOsIGdfBlWkUH71iC2vYmB0poOD6jZQlTDGk0AWvDjqrAkNAEc
 Cr5P9OyTCqA6dMo1swg/rcRhxYgoSvtUdwCNFz+f4614p/1UEhty6RBsUyaKfqmwa5NL1fHly
 fNjhg35r9fvpiP3LPsOk8o/w==

On Thu, Oct 10, 2024 at 12:29:50PM +0200, S=F6ren Krecker wrote:
> Remove some complier warnings from msvc in compat/mingw.c for value trun=
cation from 64 bit to 32 bit integers.
>
> Use size_t instead of int as all of the changed variables hold the resul=
t of strlen() or wcslen() which cannot be negative.
> and set the size of ssize_t to 64 bit on windwos 64 bit.
>
> Signed-off-by: S=F6ren Krecker <soekkle@freenet.de>

I think that commit message can be improved a little bit.
The headline deserves to be shortened,
in order to fit the rest of the commit messages in Git.
The non-headlines should stay below 72 characters or so, and it could make=
 sense
to explain the problem for the readers that are not as familiar with the
problem as you.

Something like this, please treat it as inspiration, I am not a user of ms=
vc.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mingw.c: Fix complier warnings for a 64 bit msvc

Compiling compat/mingw.c under a 64 bit version of msvc produces warnings.
An "int" is 32 bit, and ssize_t or size_t should be 64 bit long.
Prepare compat/vcbuild/include/unistd.h to have a 64 bit type _ssize_t,
when _WIN64 is defined and 32 bit otherwise.

Further down in this include file, as before,
ssize_t is defined as _ssize_t, if needed.

Use size_t instead of int for all variables that hold
the result of strlen() or wcslen() (which cannot be negative).

Use ssize_t to hold the return value of read().
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

However, looking at the current code:

static const char *parse_interpreter(const char *cmd)
{
	static char buf[100];
	char *p, *opt;
	int n, fd;

	/* don't even try a .exe */
	n =3D strlen(cmd);
	if (n >=3D 4 && !strcasecmp(cmd+n-4, ".exe"))
		return NULL;

	fd =3D open(cmd, O_RDONLY);
	if (fd < 0)
		return NULL;
	n =3D read(fd, buf, sizeof(buf)-1);

It looks as if 2 variables are better:
size_t n;
ssize_t i;
[]
n =3D strlen(cmd);
i =3D read();


>
> ---
>  compat/compiler.h               |  4 ++--
>  compat/mingw.c                  | 25 +++++++++++++++----------
>  compat/vcbuild/include/unistd.h |  4 ++++
>  3 files changed, 21 insertions(+), 12 deletions(-)
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
> index 0e851ecae2..0ff550cef3 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -782,7 +782,7 @@ static inline void filetime_to_timespec(const FILETI=
ME *ft, struct timespec *ts)
>   */
>  static int has_valid_directory_prefix(wchar_t *wfilename)
>  {
> -	int n =3D wcslen(wfilename);
> +	size_t n =3D wcslen(wfilename);
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
> +	size_t namelen;
>  	char alt_name[PATH_MAX];
>
>  	if (!do_lstat(follow, file_name, buf))
> @@ -1274,7 +1274,8 @@ static const char *parse_interpreter(const char *c=
md)
>  {
>  	static char buf[100];
>  	char *p, *opt;
> -	int n, fd;
> +	ssize_t n; /* read() can return negative values */
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
> @@ -1968,7 +1969,8 @@ char *mingw_getenv(const char *name)
>  	/* We cannot use xcalloc() here because that uses getenv() itself */
>  	w_key =3D calloc(len_key, sizeof(wchar_t));
>  	if (!w_key)
> -		die("Out of memory, (tried to allocate %u wchar_t's)", len_key);
> +		die("Out of memory, (tried to allocate %"PRIuMAX" wchar_t's)",
> +			(uintmax_t)len_key);
>  	xutftowcs(w_key, name, len_key);
>  	/* GetEnvironmentVariableW() only sets the last error upon failure */
>  	SetLastError(ERROR_SUCCESS);
> @@ -1983,7 +1985,8 @@ char *mingw_getenv(const char *name)
>  	/* We cannot use xcalloc() here because that uses getenv() itself */
>  	value =3D calloc(len_value, sizeof(char));
>  	if (!value)
> -		die("Out of memory, (tried to allocate %u bytes)", len_value);
> +		die("Out of memory, (tried to allocate %"PRIuMAX" bytes)",
> +			(uintmax_t)len_value);
>  	xwcstoutf(value, w_value, len_value);
>
>  	/*
> @@ -2001,7 +2004,7 @@ char *mingw_getenv(const char *name)
>
>  int mingw_putenv(const char *namevalue)
>  {
> -	int size;
> +	size_t size;
>  	wchar_t *wide, *equal;
>  	BOOL result;
>
> @@ -2011,7 +2014,8 @@ int mingw_putenv(const char *namevalue)
>  	size =3D strlen(namevalue) * 2 + 1;
>  	wide =3D calloc(size, sizeof(wchar_t));
>  	if (!wide)
> -		die("Out of memory, (tried to allocate %u wchar_t's)", size);
> +		die("Out of memory, (tried to allocate %" PRIuMAX " wchar_t's)",
> +		    (uintmax_t)size);
>  	xutftowcs(wide, namevalue, size);
>  	equal =3D wcschr(wide, L'=3D');
>  	if (!equal)
> @@ -3085,7 +3089,8 @@ static void maybe_redirect_std_handles(void)
>   */
>  int wmain(int argc, const wchar_t **wargv)
>  {
> -	int i, maxlen, exit_status;
> +	int i, exit_status;
> +	size_t maxlen;
>  	char *buffer, **save;
>  	const char **argv;
>
> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/un=
istd.h
> index 3a959d124c..a261a925b7 100644
> --- a/compat/vcbuild/include/unistd.h
> +++ b/compat/vcbuild/include/unistd.h
> @@ -14,7 +14,11 @@ typedef _mode_t	mode_t;
>
>  #ifndef _SSIZE_T_
>  #define _SSIZE_T_
> +#ifdef _WIN64
> +typedef __int64 _ssize_t;
> +#else
>  typedef long _ssize_t;
> +#endif /* _WIN64 */
>
>  #ifndef	_OFF_T_
>  #define	_OFF_T_
>
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> --
> 2.39.5
>
>
