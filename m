Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B8C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 14:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BAF2176D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 14:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VtK04vHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBSOXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:23:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:45145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgBSOXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 09:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582122216;
        bh=+B0u+HByXbQv+AFnT/qYhsnu6Nc4faBvHF/mIN0KuCE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VtK04vHL9qWiLtAqduKaDNhmzuHBrFtANedJuWuRf757AUd+dQ1YHsEUEIDfVarMH
         rQtMu39GEUt44DOEpGH6cFH2kIpGqAc9KinhHh+2Ede3k+uzQf86OK5pEmrVP0Rj9E
         R7h7vEnJ7k7hz/qJ4fN0XVC77ZR6burT19bbvVRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1jKAzk3yOZ-00u2jA; Wed, 19
 Feb 2020 15:23:36 +0100
Date:   Wed, 19 Feb 2020 15:23:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 06/15] bugreport: add compiler info
In-Reply-To: <20200214015343.201946-7-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet>
References: <20200214015343.201946-1-emilyshaffer@google.com> <20200214015343.201946-7-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lXLVbvmTB32gkfroto7IY0DJiYmxIuP5ryIG8vw3A+fqefIzC6K
 Eo5zgbvNZlRB6HtV4vB2XVXvsnMOGH4QWmGMdC8zVgirP8QzleDBWY0vTkXuEYPEz1nIU/E
 kZwFfHbPD8XTejeAvTVqs8zTBkRAn/MTVw5dF8SK7NPopqXvjC47itU8F4T3UxZ0V/2QmdT
 /e4ZQvyAQ08sbMcSXBDKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FRzG3Pr9Veg=:apg6OteUNdRnZmtgjp1czN
 xZWfS0OvzOG2WVcD+5JUxY9IHv/9B5mqWCpwBCKhDoea3Od+nQNVlEByYTC4mtmWe7+8cYS9o
 6Jsnf3FjhQHFtpP+PsobMxOHCVHEX1vsDVycVkV203pnqo+AjNAcFsE4dy5cRWvMJOKi8JqY5
 I24fi7FihKqGD8MdHmfAYcmYBwmINvWUmQBnxaqNj1qOpUtVp4EvNVqCVfocBx7aBs8NORizf
 lB5QhMKgeFPk30JGOkVF02CIZwa0RyhRE9GczZMN+yzdxKrgtYGHP5RHk+j99EdZm/EDgyrNx
 1hq0qBDKXhlQRJeBTNgi2fyoaLIAQiZIyXx+6RtEBPvTIHbhrCzpY8FaMk5veKTZQKt6IyjAC
 cgDsg6rX3ZHO4RdHPAN+aWBsKmUHRTavEfwQ8WeCP6e7KDpkiYCPrOmlWuzXil0Mbta7wCBFi
 CL9OWGsnl9d7CFQSwf0ZXV2+ArSAWhuykHzzIcJU5U/Kprragbso27Y4/zX0bZ0TPcA9OO3LE
 9T+pKsE4x6F2gxGFyvSQKsx3XhFsnkR3+GT/GGh2+lw35HB31oUmVoxzwYKhqUDxNVVEhxUPy
 lr//Qm0+rWUTdjhimjmk6OfiQYxgJtt2vbAmQuJemHus0Abr6RtScDj81Hu9eu5/UFlnLClWi
 23vO9eWh+47iNNunE+5ulfBD/8skNFVmLcIF1e2yUDeEHMOrRiTz+gM+IsOGGxUCrc/iJ23Bh
 jufpritFo0We6c1mpBoD4Msnz2KeVZQKf+7DoAbycfACBbr4UFDAaF/REq43vNBUVfC/qJdov
 fyvnh2YYy3hQ6FYgoFWV9+Spa/cXu+bzVHil3Zs60Tcd5SkOqoRRiRd7L1AuEZewAKqHoQ7t7
 nvfonYm4AB/MiWjG//+67unuXu2M11308cZPKJ+iV46CFnh/U3oPrcEHkm9utiYzAjhwBbw5u
 OCvrn1m9OpN/+N+xPu0Vs5ACb54jAGI/Vco9S8d6Vk6BQqob7tBOPR/sSMIgMv0Ky2mctM7wi
 6k6v4mxSQtyLcmpzl5XdS+cfX1xNsDJmYl1bP26gkoVmaU32X1VEX73QVFRVvIraPLg0Y4Bxr
 vb0EtYelX9gIOQXjZXpwKQ0onm1BXA5OAM9IJ0wUK9gH7o5Rvgx+MmxzuSgFsjOhuW8SUsYVG
 54pIpyz/2cQ5E8lg5lJEuHdhxT4ypFHzrrdfuqE8s9jtVTsBYZ/g5eH1TNuF389dte2BWbM/s
 ucSgMShrke5YC0QsM
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 13 Feb 2020, Emily Shaffer wrote:

> To help pinpoint the source of a regression, it is useful to know some
> info about the compiler which the user's Git client was built with. By
> adding a generic get_compiler_info() in 'compat/' we can choose which
> relevant information to share per compiler; to get started, let's
> demonstrate the version of glibc if the user built with 'gcc'.

I agree with the need for the compiler information, but in the patch I
only see information about glibc being printed out. Shouldn't we use
`__GNUC__` and `__GNUC_MINOR__` here?

Don't get me wrong, the glibc version is good and all, but the compiler
information might be even more crucial. Git for Windows had to hold back
compiling with GCC v8.x for a while, for example, because the stacksmasher
was broken. Similar issues are not unheard of, and could help pinpoint
compiler-related problems a lot quicker.

Thanks,
Dscho

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-bugreport.txt |  1 +
>  bugreport.c                     |  5 +++++
>  compat/compiler.h               | 24 ++++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
>  create mode 100644 compat/compiler.h
>
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugrepo=
rt.txt
> index 4dd72c60f5..8bbc4c960c 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -27,6 +27,7 @@ The following information is captured automatically:
>
>   - 'git version --build-options'
>   - uname sysname, release, version, and machine strings
> + - Compiler-specific info string
>
>  OPTIONS
>  -------
> diff --git a/bugreport.c b/bugreport.c
> index b76a1dfb2a..4f9101caeb 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -4,6 +4,7 @@
>  #include "strbuf.h"
>  #include "time.h"
>  #include "help.h"
> +#include "compat/compiler.h"
>
>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -24,6 +25,10 @@ static void get_system_info(struct strbuf *sys_info)
>  			    uname_info.release,
>  			    uname_info.version,
>  			    uname_info.machine);
> +
> +	strbuf_addstr(sys_info, "compiler info: ");
> +	get_compiler_info(sys_info);
> +	strbuf_complete_line(sys_info);
>  }
>
>  static const char * const bugreport_usage[] =3D {
> diff --git a/compat/compiler.h b/compat/compiler.h
> new file mode 100644
> index 0000000000..bda5098e1b
> --- /dev/null
> +++ b/compat/compiler.h
> @@ -0,0 +1,24 @@
> +#ifndef COMPILER_H
> +#define COMPILER_H
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +#ifdef __GLIBC__
> +#include <gnu/libc-version.h>
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	strbuf_addf(info, "glibc: %s", gnu_get_libc_version());
> +}
> +
> +#else
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	strbuf_addstr(info, "get_compiler_info() not implemented");
> +}
> +
> +#endif
> +
> +#endif /* COMPILER_H */
> --
> 2.25.0.265.gbab2e86ba0-goog
>
>
