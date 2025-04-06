Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCA2206A3
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743970626; cv=none; b=aQLMQHiA4LJBeGIdbZbvdRlrJYIZV8AD6PpA8lzwMy3Thi/h+z+velslICqc2ZOI8pv/qQ+oRmZQp4e0RNJFyDOklZ3y8bsYXiRldwdQoBrYHG1DrEo5k2djBKME/kKOklUTtvPLpz+VdZm1XKEhH/oR+bALk49MfUmcVeQ0Rjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743970626; c=relaxed/simple;
	bh=UHyA4EGzMfuylmvwoiSCtbJdVWibolUOKvWgkgkPxcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO8Yf1f1o6cTReA1uQqqNmY0DyS3R9MtTIEXpukuhbBFSLLP55WxkBBGtDeIAZTdHAQY4G+CkO13IHk1gajqMJqZ1rtoqphoyeGG8UHICMfbLmoiZbaGbuaTrh86hi/MmBDEKUjHucy1RhRsvf9vVmgMCGRNAsMQ65Wex9EzHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=PALOde2d; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="PALOde2d"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1WQMuYtQrbpaN1WQOupkgU; Sun, 06 Apr 2025 21:17:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743970620; bh=jsjtfHhur7FTimbg8EtRhj5rmSi7QGGGwkNSIL7fvh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PALOde2dK/XlOXhU3pQi9oYXROetiNF/A9FtOX74rpFg2Ld1rA9PZUrIhzNr4Akt3
	 +9JKzv4P5fHrsyiFi2e1c+Tgqb72F4Lo5PkZMWWlZPzhz05D3ZB2iE4AiuUCT39BW7
	 xbYQXCA2o3FW0pU07uzuOEs6Cb0dB+PmvKX7eYHvr4H+APXMa5x1XomW7dDzFfltd2
	 I6QkPLwaepJ7ny7lzd07xltalw8pBnIArio2LlOuKgQ4NU5fHnL/hYCswrp+WJN/Ux
	 LUDsQRfbWwUNQrtacuic6FYf6SyxI52V9/2/nk9T2mMGFdN8Cohyhy5LXqXQvVAYrl
	 teSX0581FwioQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2e13c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=L6d2GSYNYUtRv62hmvYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <94a3083c-fcc5-4489-8612-c15fa781c0f9@ramsayjones.plus.com>
Date: Sun, 6 Apr 2025 21:16:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] meson.build: set default help format to html on
 windows
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <34349bf98c5b01dd1b73065448b616517bb784a3.1743859985.git.ramsay@ramsayjones.plus.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <34349bf98c5b01dd1b73065448b616517bb784a3.1743859985.git.ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfE/Qg9+BFbYIzNN6LdNB5qhxE/Ytb+PE9edK1Z7aLJITimCb0Ug+q/fwO8nxoNcm0c2aeDAPe0Pp79dL7aZGmb3wUhUzHhhXZA7+4oV+l+fz0qaIPrnH
 Ayf8AUfqQ8ZS2CI9HbhVc8dgZ3Ac/ZdfD56TDFDTBg8O+98BwtdEnX14ZYv30dSlkR4BPm44VsP3iAAkI7eFmg0l+Lo2slEBfCk=



On 06/04/2025 20:38, Ramsay Jones wrote:
> The build variable DEFAULT_HELP_FORMAT has an appropriate default
> ('man') set in the code, so there is no need to pass the -Define on
> the compiler command-line, unless the build requires a non-standard
> value.
> 
> In addition, on windows the make build overrides the default help
> format to 'html', rather than 'man', in the 'config.mak.uname' file.
> 
> In order to suppress the -Define on the C compiler command-line, only
> add the -Define to the 'libgit_c_args' variable when the requested
> value is not the standard 'man'. In order to override the default value
> on windows, add a 'platform' value to the 'default_help_format' combo
> option and set it as the default choice. When this option is set to
> 'platform', use the 'host_machine.system()' method call to determine the
> appropriate default value for the host system.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  meson.build       | 13 ++++++++++++-
>  meson_options.txt |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index efd0bd3319..8f8a258064 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -694,7 +694,6 @@ endif
>  libgit_c_args = [
>    '-DBINDIR="' + get_option('bindir') + '"',
>    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
> -  '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
>    '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
>    '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
> @@ -717,6 +716,18 @@ if pager_opt != '' and pager_opt != 'less'
>    libgit_c_args += '-DDEFAULT_PAGER="' + pager_opt + '"'
>  endif
>  
> +help_format_opt = get_option('default_help_format')
> +if help_format_opt == 'platform'
> +  if host_machine.system() == 'windows'
> +    help_format_opt = 'html'
> +  else
> +    help_format_opt = 'man'
> +  endif
> +endif
> +if help_format_opt != 'man'
> +    libgit_c_args += '-DDEFAULT_HELP_FORMAT="' + help_format_opt + '"'
> +endif
> +

Note that host_machine.system() classifies 'cygwin' to include cygwin and
MSYS2 and 'windows' as windows but not cygwin or MSYS2! ;) The make build
overrides the help format to 'html' for windows and MINGW{32,64}, so it is
not clear to me if the test above includes MINGW.

Also, in general cygwin != MSYS2 != MINGW{32,6} != Gfw flavour MSYS2, but
it appears meson does not allow you to obtain such specific system info
(for example, by executing uname directly).

[Just a note that the make build includes 'info' as a choice, but Patrick
made the decision earlier to drop that for the meson build. Also, there is
a 'pdf' make target (I think that made it once, years ago ...)]

Thanks.

ATB,
Ramsay Jones


