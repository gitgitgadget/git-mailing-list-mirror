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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0B61F4C0
	for <e@80x24.org>; Mon, 11 Nov 2019 13:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKKNsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 08:48:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:58279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKKNsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 08:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573480112;
        bh=irFwpe4KrvqW1JjFC66Pa3ERBDkrFx2BUyrUeZMaD64=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fZEyCTBhYSub8L2cIAOxYOI5H1S4xNmTBvswmYMdLNOUnDJRlw++jLGSIqiOhlJKL
         JxfZVsr2WUfUiWAoT5pAeK1fSx1ru6nsS5TKLYxBLhGajPiQrgdj5dYipP/G2US1H6
         JiKNzbyFkSV3bMyswYoTu3EiQjzfBDmKnUVcXrts=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1iUi1K11CU-000fs4; Mon, 11
 Nov 2019 14:48:32 +0100
Date:   Mon, 11 Nov 2019 14:48:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/9] bugreport: add version and system information
In-Reply-To: <20191108214757.GB22855@google.com>
Message-ID: <nycvar.QRO.7.76.6.1911111439510.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-4-emilyshaffer@google.com> <nycvar.QRO.7.76.6.1910281432180.46@tvgsbejvaqbjf.bet> <20191108214757.GB22855@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pd+AzYq/QV5WEzqCYscHnLkbxJlEgupsxLBAf6a0NPzP3zctlnp
 dv7ItZP7r8Nkp1QIcdsXALi5zytUtcxWhtcjIyWMkcW/bMEArNg/Uu4q+ZdX/HECRtnUz+/
 f44byaUvhhQZl49QeKZwXh/TSltlqYimezA6Axqtv9PrK//bJlevNrps6WcXm0xlNSl6Ufn
 OKCVG7srXJpRiBfBXc1Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CLEnz10iK9g=:8JjDl+O4KHjzeFkbJYVJNw
 8KNTf6N6cdh1hPbf4bBhuCLT0jr3n0dVkcitSq+e38rThKPaA/2hts6OTKalFAnuhSs0y0zQe
 rfqvNRQdKsZeySPI750krwKs598lpA6bb7GlTwHdwjFZcyPiWkLfUO7fn9i3XE3DuzWMiwXzM
 3rC91ljZYF+fAXLgvKmU+udKZKEE6ImroAVs7G9D5eU3k6A5/R3oFUcmLW8yf9oRqKN2DJDeY
 JA/yRblbkXM23eGkE/hi9KBkikDwq4fvpYO8IhtdMwOmSdHF9FQWL8vxwPzKok34nDpFYGx5m
 UGPy1O7eVqrJ6aTzke/2YBRRenQV8BBvPSMqvJKwpcmG1IbvwS2afNqVfh/x+niNqEVB3t9XY
 C9XSRn49gfVRXEJ2Db8mnZZDKe+wNt4PO0jgM//xQ8cnH/Oi2o7CN/e7mQHBf+di9ReU/hgJi
 bzCoICjP7QfWYaxrLtcmWE71EA13o1S/q5kBOQH6FvFM4b8XSTj/5mqVBnopqcS37bstIGEte
 0z+y1ZRxqbLZkWfHbrsfEE1pjEhxe3EZz8zamenyiqJ39zt7pwicNDzV4eihgOyqqDVLGFqf+
 jteVEM0HHmQfntCGSDfUIdYLKiciDpi7x5Qjs3OEsAI4IDL61UMwnRvpcnVDzvZoa2traLAxO
 z1EpF/+U/CgAaQ4RF0BWLf+uMD4qT2+5VoZexEJIpH7kyygfk8IVLqG3MGcRBISZj+Trp4tdI
 a0/v2ugIQdTlfNkna0USEHaLEym0vMdRoLTfFJZIG902zeHIDh1YsM0K8xib51v1z90EoEJF/
 QgkraAGX0uL0XKTmPYdrKjSOZ/Yg/bcuk2rCwLGE9HNlEv+GkZFpRmE6fVEaEetxYLTYxRU9t
 7YDMWJgbRJaNVGMMFPVq1AE/kr1pZoK95x42+DC+mJtY81HhNpOOALr7PFh/kkvgYtCvQOkAs
 NSF7gYSatthmHfwNJ8qnxpP0FSMZRd4hoS+ibgXzQj7+CX9VJ3fYk22mzEqmKx+L33vl7iNdT
 7Vlk3mcP5dRqNJRg0fJrbQbi/FoT28g5ASuDsPR+4ypPb8HfKYFhq9HftELLUnmQqQ15+pn7K
 +1ZcFdADnU8yarVVvFY5A3s9lY0oq2RfRfbUiVARUoSS8Wkz6glhIwVzCLyp4t5aAaQxeZ2TU
 V7UeWy9jizYgAaT8q0yPkJl3FX9l2BcJDfkxzf7MXaIRLmOAolq2Sq2YJKKJI0DkSI3/NUj5R
 sp7r0Hqb/Rkl+MGja9unfIq4aqpPH0AVpLNnNbb1uQTOpGkFdOS59eGl6jzc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Fri, 8 Nov 2019, Emily Shaffer wrote:

> On Mon, Oct 28, 2019 at 02:49:29PM +0100, Johannes Schindelin wrote:
>
> > On Thu, 24 Oct 2019, Emily Shaffer wrote:
> >
> > > diff --git a/bugreport.c b/bugreport.c
> > > new file mode 100644
> > > index 0000000000..ada54fe583
> > > --- /dev/null
> > > +++ b/bugreport.c
> > > [...]
> > > +	strbuf_addstr(sys_info, "curl-config --version: ");
> > > +	strbuf_addbuf(sys_info, &std_out);
> > > +	strbuf_complete_line(sys_info);
> > > +
> > > +	argv_array_clear(&cp.args);
> > > +	strbuf_reset(&std_out);
> > > +
> > > +
> > > +	argv_array_push(&cp.args, "ldd");
> > > +	argv_array_push(&cp.args, "--version");
> > > +	capture_command(&cp, &std_out, 0);
> >
> > Again, this command will only be present in few setups. I am not
> > actually sure that the output of this is interesting to begin with.
>
> It was a suggestion, I believe, from Jonathan Nieder.

Yes, I guess Jonathan builds their Git locally, too.

It _is_ easy to forget that most users find this too involved to even
try.

Nothing like reading through a bug tracker quite frequently to learn
about the actual troubles actual users have :-)

> > What I _do_ think is that a much more interesting piece of information
> > would be the exact GLIBC version, the OS name and the OS version.
>
> The glibc version is easy; I've done that. It certainly looks nicer than
> the ldd call.
>
> I guess I may be missing something, because as I start to look into how
> to the OS info, I fall down a hole of many, many preprocessor defines to
> check. If that's the approach you want me to take, just say the word,
> but it will be ugly :) I suppose I had hoped the uname info would give u=
s
> a close enough idea that full OS info isn't necessary.

We could go down the pre-processor route, but that would give us the OS
name and version at build time, not at run time. I think we will be
mostly interested in the latter, though.

We might need to enhance our `uname()` emulation in `compat/mingw.c`,
but I think we already have enough information there.

When it comes to glibc, I think `gnu_get_libc_version()` would get us
what we want. A trickier thing might be to determine whether we're
actually linking against glibc; I do not want to break musl builds
again, I already did that inadvertently when requiring `REG_STARTEND`
back in the days.

> > > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > > index 2ef16440a0..7232d31be7 100644
> > > --- a/builtin/bugreport.c
> > > +++ b/builtin/bugreport.c
> > > @@ -1,4 +1,5 @@
> > >  #include "builtin.h"
> > > +#include "bugreport.h"
> > >  #include "stdio.h"
> > >  #include "strbuf.h"
> > >  #include "time.h"
> > > @@ -27,6 +28,13 @@ int get_bug_template(struct strbuf *template)
> > >  	return 0;
> > >  }
> > >
> > > +void add_header(FILE *report, const char *title)
> > > +{
> > > +	struct strbuf buffer =3D STRBUF_INIT;
> > > +	strbuf_addf(&buffer, "\n\n[%s]\n", title);
> > > +	strbuf_write(&buffer, report);
> >
> > This leaks `buffer`. Why not write into `report` via `fprintf()`
> > directly?
>
> Rather, to match the style of the rest of the builtin, modified
> get_header to add the header to a passed-in strbuf instead of
> modifying the file directly.

Hmm. It makes the code less elegant in my opinion. I would rather either
render the entire bug report into a single `strbuf` and then write it
via `write_in_full()`, or use `fprintf()` directly.

Ciao,
Dscho
