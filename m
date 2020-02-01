Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4524C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835E52064C
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jvv9bqqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBAVfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:35:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:52917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBAVfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 16:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580592909;
        bh=Lqgkqt/PJXFq9GH85Ebh7PiUicPswEFwzMZh6k1KGwE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jvv9bqqO1t6p2hYnM8Ej3LnuOi/5GDyp1evlUMDG2da2Ga22L4X0r1Y+WRHKasykZ
         g3pRNDjMbzTVPneq0QhxDDwRPaS2V27Ur5gGk8xD2uapvSjKb0oVJ9m7fjb7YrtgYi
         dI15MZyJogdw5G+lFkHnMvh22ohPnC4cg/LmU038=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1isF7w0EFx-005nuN; Sat, 01
 Feb 2020 22:35:09 +0100
Date:   Sat, 1 Feb 2020 22:35:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: Facing error in git-imap-send while compiling Git
In-Reply-To: <CAFFaXsxeyxkPwAYSs=TEzd8fsa5r9KpJ7q8PX0ehNJ1Wpai4fA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002012229480.46@tvgsbejvaqbjf.bet>
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com> <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com> <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
 <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com> <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet> <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com> <nycvar.QRO.7.76.6.2001212144560.46@tvgsbejvaqbjf.bet>
 <xmqqmuaf70xx.fsf@gitster-ct.c.googlers.com> <CAFFaXsxeyxkPwAYSs=TEzd8fsa5r9KpJ7q8PX0ehNJ1Wpai4fA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dQnn6yzG/TLBZKrEXlxzOaiik+Kp+n02wtqwxEZWDTsNGIKb7UL
 MztRnslEldbHO88q5TXp4dAk9VZ9FVIXxSyqewsWhS1v2/NhPn6Hdfa7sDOtSLr0IoiJKJh
 bik1X3UUcyUbCVyOPNWfyxzJwCjG2HnYwdMgYjfJMReorpP753zQwgN2FNJCkOouD27w2pZ
 yOCLjwEvOAAkhm+nWpl6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fHoRxKlC1dM=:5gmGA4E1JbVtEoYQ6Pi/Vc
 +hPj/Bmg+KYZxnvP1NCB97+1sLjSeYkyshbfdnWQD3ymxQOrWUKhma1F/zm+9yw3xel2Ei1ig
 mXVEPzTQzyfz2YL5W9PULe/KYPkIunRHI7xB2qJ4pxGPoh9f+HFiVDdwJheGmPxYuwhCgWqGa
 3xdHEXbeSGdIw5w8xflXTC1dCBpbn0zr9CEaUikTImRWFhkNL4KllPt0w/J7WFl6r7HhyhjmG
 4mbyMfaFVBdyR5uD1dAhlPmmJ9gRrWVsxpy35vysne6wQSB8F9Tfq+PVMdODBIU2V80ZkFVKz
 zSbOCi/HY3iNkNIiC/r83gXoEJE/L0NJizYPohRM/azktgj1P0fPC1cNSUbqOEETJ/aczMFPv
 qK76T65x6wur9xaa9TjXtcxL423iZrAa5UD5pfkLjzOFxabSq6f22UZN6wdcM6hl+AlipPyOy
 jTTIdRlwiBPTd5B1298fEDQHtyR0vR5T6g/RKw0kJ/Z/AmJuz+CGltaFoJPUThl65WamxdENj
 zJEJcm5NpninW7V8gckxV+U4sE5McykvKWfNnjeBquU6pBUcOTP69pIK+MtIGOPb8JXiSiyd2
 gFXVFYsi8RxK7aOAzk7xCw1aZHTKC7dQX5UTj2uLaL1lnpONMk/b2QFp7B9lkQz+aBqRJ+c1d
 5UHa+JT86SbcjTQdT1/UOxiRQ9qbRW4dB65WfgGpCOsuZX+E7yOker6we7gVGbV0CfIICF4Sb
 f9EF6Tb/+tMBb2bq+AW9hCul9LQ8e6Y4h2bO0p55ZLN6arG2q9faURK+fubOcUohZp+dzfzLi
 AtC9uF8g+UzSxXychu8d3QK1o9VOftKgc7CMEtuXrCTirz7uJ/bECRGFlvAYPtqnPCtKC1wcs
 BGUlD4jAYAR4fJk7FU5kjrlpOE6Ow4u86R5uE7eevWXuAnsJVhTKkaZMKlilrAaf79RLvZ2pR
 mJe6HsucsIDiPAwdlbSOw4zLzICqt+eoZyYKKIvuhqDcIpXPI2Ub6fkZVlvRefb2//S7hJ3Cz
 fia0rgrcdrT4f7n+/KjbCU6oB3cNbCz2RxcJ0PJTqVk6R07Bx09ePR0ExZv98YxJAApKQ9/Ww
 VggIFeIuMKVYB6N9JjuL5HNNt+tjFahvl2ASdE+xWN7F9BG79fYrGTKc2lew1U8/K8L/lCUdN
 WxxLBkrekYEO34K2hbhnmWQZwDCx/rzboy8zVq32wJoh9yHW18yXbjDwKtf19OYAga1JlYX8g
 DZ2afYdx17zwhkFFb
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nirmal,

On Fri, 31 Jan 2020, Nirmal Khedkar wrote:

> I'll admit I'm quite perplexed with this OpenSSL problem that I'm
> facing. Here's what I've done along with their results:
> 1. eroen and Jack Bates' suggestions
> (https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@notthe=
oilrig.com/)
> 2. I've also implemented Johannes' suggestions, and I'm still facing
> the same problem.

Could you repeat the symptoms? I forgot the details since you posted your
previous email.

> Here's the final diff:
> ---
> diff --git a/imap-send.c b/imap-send.c
> index 6c54d8c29d..3248bc2123 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -41,7 +41,9 @@ typedef void *SSL;
>  /* We don't have curl, so continue to use the historical implementation=
 */
>  #define USE_CURL_DEFAULT 0
>  #endif
> -
> +#ifndef SSL_library_init
> +       #define SSL_library_init();
> +#endif
>  static int verbosity;
>  static int use_curl =3D USE_CURL_DEFAULT;
>
> @@ -59,6 +61,13 @@ static struct option imap_send_options[] =3D {
>  #define DRV_BOX_BAD     -2
>  #define DRV_STORE_BAD   -3
>
> +
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L
> +       #define OPENSSL_sk_num(x) sk_GENERAL_NAME_num(x)
> +       #define OPENSSL_sk_value(x,y) sk_GENERAL_NAME_value((x),(y))
> +       #define OPENSSL_sk_pop_free(x,y) sk_GENERAL_NAME_pop_free((x),(y=
))
> +#endif
> +
>  __attribute__((format (printf, 1, 2)))
>  static void imap_info(const char *, ...);
>  __attribute__((format (printf, 1, 2)))
> @@ -275,21 +284,30 @@ static int verify_hostname(X509 *cert, const
> char *hostname)
>
>  static int ssl_socket_connect(struct imap_socket *sock, int
> use_tls_only, int verify)
>  {
> -#if (OPENSSL_VERSION_NUMBER >=3D 0x10000000L)
> -       const SSL_METHOD *meth;
> -#else
> -       SSL_METHOD *meth;
> -#endif
> -       SSL_CTX *ctx;
> -       int ret;
> -       X509 *cert;
> -
> -       SSL_library_init();
> -       SSL_load_error_strings();
> +       #if (OPENSSL_VERSION_NUMBER >=3D 0x10000000L)
> +               const SSL_METHOD *meth;
> +       #else
> +               SSL_METHOD *meth;
> +       #endif
> +               SSL_CTX *ctx;
> +               int ret;
> +               X509 *cert;
> +
> +       #if OPENSSL_VERSION_NUMBER >=3D 0x10100000L ||
> defined(LIBRESSL_VERSION_NUMBER)
> +               OPENSSL_init_ssl(0, NULL);
> +               meth =3D TLS_method();
> +       #else
> +               SSL_library_init();
> +               SSL_load_error_strings();
> +               meth =3D SSLv23_method();
> +       #endif
>
> -       meth =3D SSLv23_method();
>         if (!meth) {
> -               ssl_socket_perror("SSLv23_method");
> +       #if (OPENSSL_VERSION_NUMBER >=3D 0x10100000L)
> +                       ssl_socket_perror("TLS_method");
> +       #else
> +                       ssl_socket_perror("SSLv23_method");
> +       #endif
>                 return -1;
>         }
>
>
> ---

That diff looks pretty okay to me.

> Also, on a different note: I'm actually really interested in applying
> to Git for GSoC, and I should be doing Git microprojects right now to
> properly cement my chance of doing GSoC with Git. Many aspiring GSoC
> applicants already been asking, enquiring and maybe even working about
> Git microprojects, as evident from the mailing list.

For the record, I am not even sure whether Git will participate in GSoC
this year; I am not aware of any activity in that direction.

Having said that, the purpose of a Git microproject is to get acquainted
with the development process of Git (at least in my mind). It is not so
much fixing some issue in Git, but more like learning how to interact with
the Git mailing list, in particular how to communicate effectively with
the developers/reviewers on this list.

In that light, if I were a possible mentor (which I am not, at least not
in this year's GSoC) I would not insist on a microproject. Or more like: I
would accept your work on getting this vexing OpenSSL v1.1.1 issue sorted
out as a microproject in its own right.

> So while I'm not saying that I'm in deep trouble and all this OpenSSL
> v1.1.1 issue fixing is completely useless (I'm learning quite a lot
> along the way and able to understand the project structure), but
> saying that I'm not worried about my GSoC prospects of working in this
> organization would honestly be false :) . I love git, I would love
> contributing to Git, but I'd love to do a GSoC Summer with Git much
> more than the rest.
>
> Please let me know where am I going wrong. If there's any other system
> packages that I can download so that I can focus on other Git issues
> and this one simultaneously, please let me know. Here are my system
> specifications (let me know if you need anything more specific):
> ---
> OS: Ubuntu 18.04
> Linux Kernel: 5.3
> OpenSSL Version: 1.1.1d
> ---
>
> Apologies for the long email,

This is not even close to being the longest email sent to this list, so
don't worry!

Ciao,
Johannes

> Thank You,
> Nirmal Khedkar
> (https://nirmalhk7.github.io)
>
>
> On Thu, Jan 23, 2020 at 12:50 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >> From my limited knowledge of OpenSSL libraries, I think the error h=
as
> > >> more to do with 'SSL_library_init()' , which appears like a
> > >> constructor to the OpenSSL library. I found these emails regarding
> > >> "if" cases around this function. Please check out these patches:
> > >> 1. Rosen Penev:
> > >> https://lore.kernel.org/git/20181227023548.396-1-rosenp@gmail.com/
> > >
> > > I remember that one. And I agreed with Junio that the documentation
> > > suggests that the call is _optional_, while the patch suggests that =
it
> > > would be _incorrect_ instead.
> > >
> > > And looking at
> > > https://www.openssl.org/docs/man1.1.1/man3/SSL_library_init.html sug=
gests
> > > to me that it is still supported.
> > >
> > > Having said that, if I look at the headers installed for `libssl-dev=
`
> > > version `1.1.1-1ubuntu2.1~18.04.5` in my Ubuntu installation, I see =
that
> > > `/usr/include/openssl/ssl.h` defines that symbol as:
> > >
> > >       #  define SSL_library_init() OPENSSL_init_ssl(0, NULL)
> > >
> > > but _only_:
> > >
> > >       # if OPENSSL_API_COMPAT < 0x10100000L
> > >
> > > So maybe that disagrees with the documentation that says that
> > > SSL_library_init() is optional?
> > >
> > > The curious thing is that `OPENSSL_API_COMPAT` is not even defined
> > > anywhere. So maybe it _is_ the right thing to also `#define
> > > SSL_library_init() (void)` in the diff you listed above?
> > >
> > > _Maybe_ guarded within `#ifndef SSL_library_init ... #endif` guards?
> > >
> > >> 2. eroen: https://lore.kernel.org/git/20170112104219.563497-1-git-s=
cm@occam.eroen.eu/
> > >
> > > That sounds like a good suggestion, too.
> > >
> > >> Are the fixes made in these patches relevant here. Please let me kn=
ow
> > >> if I'm going wrong.
> > >
> > > Yes, both threads are relevant, and if you can reconcile them into a=
 patch
> > > that makes Git compile with OpenSSL v1.1.1, I will try my best to re=
view
> > > them (Cc: me, just in case).
> >
> > I agree with the above reasoning and the suggestion given by Bates in
> > https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@notth=
eoilrig.com/
> > sounds like a reasonable one.
> >
> > Thanks for digging and double-checking these two previous efforts,
> > and giving another round of thoughts on them.
> >
> >
> >
> >
>
