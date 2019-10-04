Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637E31F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 09:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfJDJMm (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 05:12:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:50805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbfJDJMm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 05:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570180355;
        bh=7f6FDlBtLzExXkP5f+EoV8HfNJbesQAenV2euaXEy9M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jgW9n8fE/pIKXtXawqaFRvfugoBR6CpE5x8put3od+CHBJ+HvaLoeDTa2vHhRSlI5
         uSXCJSqR1xKkhRYd+Lc7Fv3Ef2w3Nif7Irwkc2X/uo9+Q4V3Mg5d7Qu/PxyRMIRwiz
         5jQR4TzT7+TSdnDC0T0T7WGg+GfqsFAV+cz2D8UE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.189]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1idWRC3OPc-00YDc0; Fri, 04
 Oct 2019 11:12:34 +0200
Date:   Fri, 4 Oct 2019 11:12:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Josh Steadmon <steadmon@google.com>
cc:     git@vger.kernel.org, git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH v4 3/4] trace2: don't overload target directories
In-Reply-To: <98a8440d3f0ef3cd3cdd0291051d976d4a659cc4.1570144820.git.steadmon@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910041105290.46@tvgsbejvaqbjf.bet>
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com> <cover.1570144820.git.steadmon@google.com> <98a8440d3f0ef3cd3cdd0291051d976d4a659cc4.1570144820.git.steadmon@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ENL2DIhFkF2zmyqLNHXfLL1OegJGiUoZbbxIq68RTkEXuZ0la7w
 d34unrscxz2zgNxUeX53HRS9iKjLtqnS4GNibkrF5J9ErNq70h8Yv1armFiH2LuphQBCyHj
 ZDofbtRwoaEgLHsHyNRpt/fk57UhieR8ysu6Xwtfb4wD+kmPo4nRJUz78Qcd8xtbm990TOc
 Bc3HTKQUUzih2rY8Y+2ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9BqOyNya/kw=:XEZoEXuxo6Lw06Eo8lzFrR
 1oCXNk940rYiI0/NN5t2rck1u+pwRPZ01z2IMUgZ+42OAtkyFkiJNEWC10Cgx+LDfH0iF3gf6
 Y6xW1anuUm5phcAHJJoRlqVHxRMB1tcJV/yb+SoUFtymk00j5CkdYMHOE1ebx4P8usgxoMCbV
 0f7M6n77v3jMe72q1tRD9Y8ytGwukOj3BQ1G8tAQBHE95i97fEdmCkJVR75BMwtOwcFAwxKrX
 URITiDFBLsrqqFnn03N3F5EsyRoX5fPWtLFE97LCW7gCStt4xSMiQa1hwre8wbe5f4l3ItRNR
 EUcam3tBdk0zB9MqFRuEdrY1P1KG9gcDKtl5EQuturtnmnl75Uwo2HxduJeMjbrXInMR4XsPD
 Baeuthz/gP69RX8fWkg2QZ6g0e6fGCIoR5zYan4RPfSadXhrwvJ9IEsXFonpp9Xi64WY2zQ+f
 Xz970AyC4OUkeJs6blm+MZEGXXBSW9MJZSvAf4GtrE9SPJbdL+RBR4jyizptOq4Ejvg4dG09x
 AjEHVp6WzNn1LCf7lheyeM16AWTqFAZNI9A4g810qrCoWGzD5dKSYpj6JpOtXfNoryeuZEQ60
 3qopcxmcOWJ1rKnluxj+idoAUiEqboSCnJWGaFSN0z7HJlhMq3Bs9fPkAy1JoTGPmLkFwN/Eh
 irb8xZ59aouwjK2SQnJIF3WDMqM/raXQE+f/GEHRSZUcDJ0GTnjm25gxOM2oPhr6CjIo8FClS
 O1P7IX+yFit0JUrPbSrcKgUNrNdUZsKk4xMqXdrqDbPZaqnCHQgKgJkyqDu/bfb6DLkvLLzAo
 wI0Auv8FTIoVlIICqwqfahDGbJvZKMlX6LmtfQ7PpWkhGNW6Qt0NVXvGpT+y4huy2BNMTYB1B
 6CaL9DzwoD+uvpkK9XR92h1m3zsKj9s57txY+hoopyjvsiMfiT+aP1xPrS9k8qX3CBlEKtSYs
 /K7hM/8T2+Tthg1gdSJy0kb371o8b+Qczb8AAqi8IXbolPlPmrzs+J45DI63Qdq7YLnOGqv2E
 /Co/EUJy1i+KoYrif0PVnxEseMm9+Y/4VZwNGZG+g0jAsRR9WNKdwuB/+iTwPwBkT9q+GjMuX
 4wce8MDdDJpMw0u8Q7tAWahGaOj5IL7mPsavCAU+5lPTss/uSu7y3bwql9+Vn4J1kOsLe/DS2
 BQKbEwfTaB6siOrc7gB1uTYNicTVhZ7aukETg6CPcWyhw8mL9p85ak/D3hoVi+NUmI5/c63fh
 nrZ1LaeFrOipZ337OMj1/XBmbMNDmOSL7bRolPoziahDXwQ9VlUVYtKAaA2g=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

On Thu, 3 Oct 2019, Josh Steadmon wrote:

> [...]
> diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> index 5dda0ca1cd..af3405f179 100644
> --- a/trace2/tr2_dst.c
> +++ b/trace2/tr2_dst.c
> @@ -1,3 +1,5 @@
> +#include <dirent.h>
> +

This completely breaks the Windows build:

	In file included from trace2/tr2_dst.c:1:
	compat/win32/dirent.h:13:14: error: 'MAX_PATH' undeclared here (not in a
	function)
	   13 |  char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8 conversio=
n) */
	      |              ^~~~~~~~

See the full build log in all its glory here:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D17409&view=
=3Dlogs&jobId=3Dfd490c07-0b22-5182-fac9-6d67fe1e939b&taskId=3Dce91d5d6-0c5=
5-50f5-8ab9-6695c03ab102&lineStart=3D252&lineEnd=3D255&colStart=3D1&colEnd=
=3D30

The fix is as easy as probably surprising: simply delete that
`#include`. It is redundant anyway:
https://github.com/git/git/blob/v2.23.0/git-compat-util.h#L184

Deleting that `#include` line from your patch not only lets the file
compile cleanly on Windows, it also conforms to our coding style where
`cache.h` or `git-compat-util.h` need to be the first `#include`. That
rule's purpose is precisely to prevent platform-specific compile errors
like the one shown above.

Ciao,
Johannes

>  #include "cache.h"
>  #include "trace2/tr2_dst.h"
>  #include "trace2/tr2_sid.h"
> @@ -8,6 +10,19 @@
>   */
>  #define MAX_AUTO_ATTEMPTS 10
>
> +/*
> + * Sentinel file used to detect when we're overloading a directory with=
 too many
> + * trace files.
> + */
> +#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
> +
> +/*
> + * When set to zero, disables directory overload checking. Otherwise, c=
ontrols
> + * how many files we can write to a directory before entering overload =
mode.
> + * This can be overridden via the TR2_SYSENV_MAX_FILES setting.
> + */
> +static int tr2env_max_files =3D 0;
> +
>  static int tr2_dst_want_warning(void)
>  {
>  	static int tr2env_dst_debug =3D -1;
> @@ -32,6 +47,67 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
>  	dst->need_close =3D 0;
>  }
>
> +/*
> + * Check to make sure we're not overloading the target directory with t=
oo many
> + * files. First get the threshold (if present) from the config or envva=
r. If
> + * it's zero or unset, disable this check.  Next check for the presence=
 of a
> + * sentinel file, then check file count. If we are overloaded, create t=
he
> + * sentinel file if it doesn't already exist.
> + *
> + * We expect that some trace processing system is gradually collecting =
files
> + * from the target directory; after it removes the sentinel file we'll =
start
> + * writing traces again.
> + */
> +static int tr2_dst_overloaded(const char *tgt_prefix)
> +{
> +	int file_count =3D 0, max_files =3D 0, ret =3D 0;
> +	const char *max_files_var;
> +	DIR *dirp;
> +	struct strbuf path =3D STRBUF_INIT, sentinel_path =3D STRBUF_INIT;
> +	struct stat statbuf;
> +
> +	/* Get the config or envvar and decide if we should continue this chec=
k */
> +	max_files_var =3D tr2_sysenv_get(TR2_SYSENV_MAX_FILES);
> +	if (max_files_var && *max_files_var && ((max_files =3D atoi(max_files_=
var)) >=3D 0))
> +		tr2env_max_files =3D max_files;
> +
> +	if (!tr2env_max_files) {
> +		ret =3D 0;
> +		goto cleanup;
> +	}
> +
> +	strbuf_addstr(&path, tgt_prefix);
> +	if (!is_dir_sep(path.buf[path.len - 1])) {
> +		strbuf_addch(&path, '/');
> +	}
> +
> +	/* check sentinel */
> +	strbuf_addbuf(&sentinel_path, &path);
> +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
> +	if (!stat(sentinel_path.buf, &statbuf)) {
> +		ret =3D 1;
> +		goto cleanup;
> +	}
> +
> +	/* check file count */
> +	dirp =3D opendir(path.buf);
> +	while (file_count < tr2env_max_files && dirp && readdir(dirp))
> +		file_count++;
> +	if (dirp)
> +		closedir(dirp);
> +
> +	if (file_count >=3D tr2env_max_files) {
> +		creat(sentinel_path.buf, 0666);
> +		ret =3D 1;
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	strbuf_release(&path);
> +	strbuf_release(&sentinel_path);
> +	return ret;
> +}
> +
>  static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_p=
refix)
>  {
>  	int fd;
> @@ -50,6 +126,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst=
, const char *tgt_prefix)
>  	strbuf_addstr(&path, sid);
>  	base_path_len =3D path.len;
>
> +	if (tr2_dst_overloaded(tgt_prefix)) {
> +		strbuf_release(&path);
> +		if (tr2_dst_want_warning())
> +			warning("trace2: not opening %s trace file due to too "
> +				"many files in target directory %s",
> +				tr2_sysenv_display_name(dst->sysenv_var),
> +				tgt_prefix);
> +		return 0;
> +	}
> +
>  	for (attempt_count =3D 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_c=
ount++) {
>  		if (attempt_count > 0) {
>  			strbuf_setlen(&path, base_path_len);
> diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
> index 5958cfc424..3c3792eca2 100644
> --- a/trace2/tr2_sysenv.c
> +++ b/trace2/tr2_sysenv.c
> @@ -49,6 +49,9 @@ static struct tr2_sysenv_entry tr2_sysenv_settings[] =
=3D {
>  				       "trace2.perftarget" },
>  	[TR2_SYSENV_PERF_BRIEF]    =3D { "GIT_TRACE2_PERF_BRIEF",
>  				       "trace2.perfbrief" },
> +
> +	[TR2_SYSENV_MAX_FILES]     =3D { "GIT_TRACE2_MAX_FILES",
> +				       "trace2.maxfiles" },
>  };
>  /* clang-format on */
>
> diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
> index 8dd82a7a56..d4364a7b85 100644
> --- a/trace2/tr2_sysenv.h
> +++ b/trace2/tr2_sysenv.h
> @@ -24,6 +24,8 @@ enum tr2_sysenv_variable {
>  	TR2_SYSENV_PERF,
>  	TR2_SYSENV_PERF_BRIEF,
>
> +	TR2_SYSENV_MAX_FILES,
> +
>  	TR2_SYSENV_MUST_BE_LAST
>  };
>
> --
> 2.23.0.581.g78d2f28ef7-goog
>
>
