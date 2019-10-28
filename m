Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68571F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 13:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbfJ1Ntt (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 09:49:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:50799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfJ1Ntt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572270585;
        bh=vYnZB3rrMzDXaltj1c5BRtPe1F4wyG+OE3TSiaQty9s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lCIYgNpfKNYZoXZ4UPoPsjHFGBRGtkFFFUMc2G3/M4Uh3hXTOaH6PcNCZK0tfZ2nQ
         6Eq4LDCBoydmrV6UITJ5eNAihsmAypd/XuOnvktuGBsGoMlNZXH1MsXSEKGTKyxxLR
         yoLqhMrNy9Fd/ocn85TJB6OHmLAqZ2QYbwsokifc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1igcFl12wq-00Hebp; Mon, 28
 Oct 2019 14:49:45 +0100
Date:   Mon, 28 Oct 2019 14:49:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/9] bugreport: add version and system information
In-Reply-To: <20191025025129.250049-4-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281432180.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-4-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BWpSZyhVZ37J+h5EeI5nHMturAJItUXLj85xohteiuqB3M9Pn1+
 syVV9OUQs41rfrfPrlJOv4hDcYDaW9kUb3oR9Pdy1Hg0T8bEYFkjdC08LT7TKrbntkEeKkF
 Xu0EtnJlhMmo+L+VtYtOtjIEHQCMKC1oAY023xu+jAefmuXsn15TlNujYPp+JbfEAi1e7bX
 Q1TRWBKIQb8AGtTn70bSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C9rqNL31rw8=:K+Fmxe+eCw55xChKW61lrQ
 0EghVSUR+sVKkFr1m7/qXWW9geG04Ed25W1ArZLxjZY/Qxn0HcarWnWgnczNFCMdAV2QJq9cv
 y5eIE9ym2V2FuNI6z9/fB4FhI07jeTgZgjp/uTY6+HIN6kiNxLf+u60ahvK+VMK+brts9IDRp
 +t9z/rtYu6raIp5BkOgZj7/1dgeZEEDmmW0vM5dXSxFn8bgS75OwId3p2iUOOO1TR8Tn04+bF
 J5oCMo09Q5KSXtFneyFtvpJ7nmggrp1bt4xZ7Ghw4Wl0gaTmQJwrrQW03GHGEWod33E8pCXZu
 w9NLQWy8WeCn2vq0j/cousjVQnk7b9+yK0LDazoBzxao7VJyfUOjyEkTc05ZFLoDlKTBLwxmQ
 L65aB3PcBnR8q1Lb9nSD4k/UpU89yjy6A80BaSyO1Tt0W9M5lGRfl/HMjsEYFfgNlsOcVz5fk
 WiE+Z+jJOzvoIcu5ikWmlHlNCMA76PPVImJERl/zinlmaU+Eh8EDqvfBZ/Ty6DwoahEQnELiA
 MLmpfTri6Hq1TN0ERjLubv5p4LPeqQPbqBjbuosl0tOqK7hNKSdNLMsD0P/4LP840he658ihn
 tMlu3sdkXnCCyvUrKCrc/B2vE51XHJXa7ZWQLqPn+KTvntE+J6vZu0Aab3DOCtYky4BSjP9K/
 4VXLMwVrmGHSnAsXLuJPY9+mUyZLBsdcAFA4w1RGAfUAowAQNSsFWPSjM0lrewHN3Z9ga4s7f
 KnGENv/RLhXx3nIWgbHPh8isRSP7ZFxhHoMHfX5MecbJMrl5S/uu6LjXJfNNu8Z0JEd2A+UKS
 ghH4bYvpxL+/Hxx+oCr7EuaXXcmWIxKO0AGSqinAV5CTgXScIKJOEDXw8FEoouJXCP571sQnW
 9Jb5Xxvj7VhmpEQHrd8+0DJdyOFP+fImGFRn2uF10jR20mRcpWYfshRoj4cuoPCMyqhF8Ngtk
 gN37sztcfhuaVEBh9XS5GwnkgoUbnRZITjCBbe+FJ8sSr1tZ8FF8VJCJ2Mp5w3PMi/cpxzy66
 TU16Ke7xq2BPo1zG4smQgY7JnTZaGQyqXoB7tT975h8quC0pArmBXfCYiwG6/u+sbqkGG8iri
 FR5M9y+dm91yE1FSPsOsNpPdWW9SyyDON+ZrG4EaoRmZCnpZqPzQmdG6/7aNbz3Sjx50zOtfT
 kQGXPcdUZs0+3KoeutgSv2cVKqydBdLJIv0FqZMeUF8f1YHEOCVGde42PhmBMEABS4xhOLE5M
 nzyadn7dUYoVmVcwTDPpBsj9pJtRc2lwmiGtwkgFTYdKQo+mhgdcATvY9t0Q=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> diff --git a/bugreport.c b/bugreport.c
> new file mode 100644
> index 0000000000..ada54fe583
> --- /dev/null
> +++ b/bugreport.c
> @@ -0,0 +1,55 @@
> +#include "cache.h"
> +
> +#include "bugreport.h"
> +#include "help.h"
> +#include "run-command.h"
> +#include "version.h"
> +
> +void get_system_info(struct strbuf *sys_info)
> +{
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	struct strbuf std_out =3D STRBUF_INIT;
> +
> +	strbuf_reset(sys_info);
> +
> +	// get git version from native cmd

Please use C-style comments instead of C++ ones.

> +	strbuf_addstr(sys_info, "git version: ");
> +	strbuf_addstr(sys_info, git_version_string);
> +	strbuf_complete_line(sys_info);
> +
> +	// system call for other version info
> +	argv_array_push(&cp.args, "uname");
> +	argv_array_push(&cp.args, "-a");
> +	capture_command(&cp, &std_out, 0);

Mmmkay. I am not too much of a fan of relying on the `uname` executable,
as it can very well be a 32-bit `uname.exe` on Windows, which obviously
would _not_ report the architecture of the machine, but something
misleading.

Why not use the `uname()` function (that we even define in
`compat/mingw.c`)?

Also, why not include the same information as `git version
=2D-build-options`, most importantly `GIT_HOST_CPU`?

In any case, if you are capturing the output of `uname -a`, you
definitely will want to pass the `RUN_COMMAND_STDOUT_TO_STDERR` flag (in
case, say, the MSYS2 `uname.exe` fails with those dreaded Cygwin error
messages like "*** fatal error - add_item
("\??\D:\git\installation\Git", "/", ...) failed, errno 1").

> +
> +	strbuf_addstr(sys_info, "uname -a: ");
> +	strbuf_addbuf(sys_info, &std_out);
> +	strbuf_complete_line(sys_info);
> +
> +	argv_array_clear(&cp.args);
> +	strbuf_reset(&std_out);
> +
> +
> +	argv_array_push(&cp.args, "curl-config");
> +	argv_array_push(&cp.args, "--version");
> +	capture_command(&cp, &std_out, 0);

This will be almost certainly be incorrect, as most _regular_ users
won't have `curl-config`. I know, it is easy to forget that most Git
users are no hard-core C developers ;-)

A better alternative would be to use `curl_version()`, guarded, of
course, by `#ifndef NO_CURL`...

> +
> +	strbuf_addstr(sys_info, "curl-config --version: ");
> +	strbuf_addbuf(sys_info, &std_out);
> +	strbuf_complete_line(sys_info);
> +
> +	argv_array_clear(&cp.args);
> +	strbuf_reset(&std_out);
> +
> +
> +	argv_array_push(&cp.args, "ldd");
> +	argv_array_push(&cp.args, "--version");
> +	capture_command(&cp, &std_out, 0);

Again, this command will only be present in few setups. I am not
actually sure that the output of this is interesting to begin with.

What I _do_ think is that a much more interesting piece of information
would be the exact GLIBC version, the OS name and the OS version.

> +
> +	strbuf_addstr(sys_info, "ldd --version: ");
> +	strbuf_addbuf(sys_info, &std_out);
> +	strbuf_complete_line(sys_info);
> +
> +	argv_array_clear(&cp.args);
> +	strbuf_reset(&std_out);
> +}
> diff --git a/bugreport.h b/bugreport.h
> new file mode 100644
> index 0000000000..ba216acf3f
> --- /dev/null
> +++ b/bugreport.h
> @@ -0,0 +1,7 @@
> +#include "strbuf.h"
> +
> +/**
> + * Adds the Git version, `uname -a`, and `curl-config --version` to sys=
_info.
> + * The previous contents of sys_info will be discarded.
> + */
> +void get_system_info(struct strbuf *sys_info);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 2ef16440a0..7232d31be7 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -1,4 +1,5 @@
>  #include "builtin.h"
> +#include "bugreport.h"
>  #include "stdio.h"
>  #include "strbuf.h"
>  #include "time.h"
> @@ -27,6 +28,13 @@ int get_bug_template(struct strbuf *template)
>  	return 0;
>  }
>
> +void add_header(FILE *report, const char *title)
> +{
> +	struct strbuf buffer =3D STRBUF_INIT;
> +	strbuf_addf(&buffer, "\n\n[%s]\n", title);
> +	strbuf_write(&buffer, report);

This leaks `buffer`. Why not write into `report` via `fprintf()`
directly?

Ciao,
Dscho

> +}
> +
>  int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buffer =3D STRBUF_INIT;
> @@ -43,6 +51,11 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
>  	get_bug_template(&buffer);
>  	strbuf_write(&buffer, report);
>
> +	// add other contents
> +	add_header(report, "System Info");
> +	get_system_info(&buffer);
> +	strbuf_write(&buffer, report);
> +
>  	fclose(report);
>
>  	launch_editor(report_path.buf, NULL, NULL);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
