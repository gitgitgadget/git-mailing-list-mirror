Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09F3C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C8D24655
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V6nfhK3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAUVJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:09:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:49335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgAUVJK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 16:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579640947;
        bh=+dkNUKQ5UMyhoEXtdvFO2920wj+f8GCeqcPJlMcfREk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V6nfhK3whC8+tUzCtTySDT9xq87B1bZ41tp1y3luwskCzaKxFmcFVg1w/rnaNLo8F
         vLP74jtazdL9ky9Xt4zXvBzGClyekt96zv3ETrhSRgw07gXh8rs4zkghBqtXcjD4D3
         4NFk+g5Q0MhUtXbQDOZWprW68xBLkREczRPqV82g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1ji6TR0bpC-0170Ln; Tue, 21
 Jan 2020 22:09:07 +0100
Date:   Tue, 21 Jan 2020 22:09:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Facing error in git-imap-send while compiling Git
In-Reply-To: <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001212144560.46@tvgsbejvaqbjf.bet>
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com> <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com> <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
 <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com> <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet> <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cmzwW6JdMrz3n38OgOZz8pZCNp84jSZa+qQnPJniJtqz+12Oihh
 r7dXc7KGLzsuXAO3cc+F26pTgeFiYLoBSjM3zHuSVyUWJwPrVw6HtiHEJZbK4IKJBLXxvTO
 D5/GsXkFU0CJF9dwvuBSU4P+I5CDsZ5XPHmS4COHPskiXxsAaBFLweSAJSfZKJT4pCJF/a6
 +s1b8MOoexpHPTW3xQwFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQ3oZFff8Qo=:pazitPBWH0oolblUrLoS7F
 yUi1KyXnqFyL4sfcHI9dBk186Z7FcVwDjxUp2bwK1iHbb/dLsslP/44YRv4cLvIEC85D8OEQk
 3dX8Dqcr9h+1jvVPkh2OOOiq/wGRZAElLa3JSXDhI0NYSvtjEWcsBm7MJAH+6YXjFLcdcseKK
 V5oaQYmc2/gmCq1BuCjDRlk+0bySsdLDqW8+N2dWkYqT3iu2sMQzBgQNEoOfkWnzMDjWaZCn/
 BchFQ1o2xqVChZqkkFFRcwFDpmSkSn/QxmZR7t69BMCdhwJ2czy1q+pKlb7be2ASZiLNh9V9U
 Sd5Hu8IYHmG0xnhwCj/tSrM7TQTr7lqukrzSW8lQ4B8lww+a7a6DGyAD/F5rojcKFb08Zt0Wo
 Y7D9+Lo6UrruvZsZUWw9zUcLzwWg6nfQ4JXt10uFr7eJo9LdQzH8hyX0GWs1fyO//GwXzELFr
 zXOTSM90OAHyxKbItvEJSOg0msskvjNwIC4nb/hEiR1Dg/4d343mHyuOZGu/Sq9d9DISmkay3
 QrVBIECcNnjOvfa8wMxu9OJlkbXHNaWSFPvhtB0XaRWadAyuFb0zJhMZW53+Zw8wXosIh/m8d
 UiBBUueH3GOkqywxDeiCspX933DEom7NEhHg6fmz15naLEMpnf3rbtD3cJhqW3v3tqXfbbEYL
 1cvWD1J5rvXqwEtg537hCHXy2I4Jx9A7jaq6lOqUGawhgVLVf0VQqDTkA1hbEbEgZviBSr755
 NvdpTdbTYeVbIYU80sMfF28/qWC/IMqX3xVjCNa/2jdoum0QWeBeSkiBuB6AEWWZJQNPio+fo
 nHuFVa8/JtsuGW09KEnWMV3TcvuRR1CIsFT01Jcx47lhpH7t3blawdyVqxfCezvvxYnfZd/su
 WnDxRyUxAzEMofyTD+ZAeEy74SLT84VTcbyL4NpvTXXcjahrLh+DaK4qkWDJa3lAvhupmr2es
 JHL4lYeCtb8DMKe0LZ031v463G7+ayQS6iP5bRfjbmwLcmMY4PISH6ahpOy173o9R1TSlH1rP
 SMqyI6W/QMveZrT541e4VStccvb6GK0sMkZleF2bIDVPfeBsjHuQHRTmWDjhTt1Vnkj37n1xN
 Si5HflFF7QcWMK/RImlk9+cVDIfNgUKNVNhRi4YQgzII+a9WmuyrCmG6LByouVddDigQ/93Mk
 mCMcf9hbT400BRqPyrhaXH3JriY6y33gzREEu84au0vknhfbsCp3VFhOytFVNbIsQxYznUAnk
 d9iAZqervaObmzOc2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 21 Jan 2020, Nirmal Khedkar wrote:

> On Tue, Jan 21, 2020 at 3:05 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 21 Jan 2020, Nirmal Khedkar wrote:
> >
> > > On Fri, Jan 17, 2020 at 7:05 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Fri, 17 Jan 2020, Nirmal Khedkar wrote:
> > > >
> > > > > On Fri, Jan 17, 2020 at 4:21 AM Junio C Hamano <gitster@pobox.co=
m> wrote:
> > > > > >
> > > > > > Perhaps the thread
> > > > > >
> > > > > >   https://lore.kernel.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.go=
oglers.com
> > > > > >
> > > > > > may help?
> > > > >
> > > > > It did, to the extent that I now know why I'm facing these error=
s out
> > > > > of the blue.
> > > > >
> > > > > I'm  not quite sure as to what am I supposed to do right now, sh=
ould I
> > > > > wait for Liam's patch to be merged,  or should I implement his f=
ixes
> > > > > locally or should I just downgrade my openssl?
> > > > >
> > > > > Liam's PR (#516 on GitGitGadget [1]) haven't yet passed all buil=
d
> > > > > checks and I guess its still a work in progress. Nevertheless I'=
ve
> > > > > tried implementing his fixes to imap-send.c, and the make still =
fails.
> > > > > Am I missing something here?
> > > >
> > > > Speaking for myself, I am still waiting for
> > > > https://public-inbox.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googler=
s.com/
> > > > to be addressed adequately. I think this is the main blocker.
> > > >
> > > > You could be that person who addresses this, as already 10 days we=
nt past
> > > > without even so much as an acknowledgement of Junio's suggestion. =
Maybe
> > > > you can make it work, and submit a fixed patch (You could take aut=
horship
> > > > and add a footer "Original-patch-by: Liam Huang <liamhuang0205@gma=
il.com>"
> > > > because it is most likely a total rewrite of Liam's patch).
> > > >
> > > > Ciao,
> > > > Johannes
> > >
> > > The OpenSSL version on my system is 1.1.1. I've tried implementing
> > > Junio's suggestions, and it just doesn't work.
> >
> > Does the code otherwise compile cleanly with `make DEVELOPER=3D1`?
> >
> > > It gives me the same
> > > error as it gave me earlier.
> > >
> >
> > Those are linker errors, meaning that the symbols were not found in th=
e
> > libraries.
> >
> > If you build with `make V=3D1 DEVELOPER=3D1` you should see that
> > `git-imap-send` links in OpenSSL via -lssl (and/or -lcrypto). Is this =
the
> > case for you?
>
> Doing "echo DEVELOPER=3D1 >config.mak" does not help in any way. I get
> the same errors. Here's my diff, in case I have been making mistakes
> all along.
>
>
> ---
> diff --git a/imap-send.c b/imap-send.c
> index 6c54d8c29d..73ed3bc287 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -42,6 +42,12 @@ typedef void *SSL;
>  #define USE_CURL_DEFAULT 0
>  #endif
>
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L
> +    #define OPENSSL_sk_num(x) sk_GENERAL_NAME_num(x)
> +    #define OPENSSL_sk_value(x,y) sk_GENERAL_NAME_value((x),(y))
> +    #define OPENSSL_sk_pop_free(x,y) sk_GENERAL_NAME_pop_free((x),(y))
> +#endif

That looks sensible.

> +
>  static int verbosity;
>  static int use_curl =3D USE_CURL_DEFAULT;
>
> @@ -59,6 +65,8 @@ static struct option imap_send_options[] =3D {
>  #define DRV_BOX_BAD     -2
>  #define DRV_STORE_BAD   -3
> ---
>
> From my limited knowledge of OpenSSL libraries, I think the error has
> more to do with 'SSL_library_init()' , which appears like a
> constructor to the OpenSSL library. I found these emails regarding
> "if" cases around this function. Please check out these patches:
> 1. Rosen Penev:
> https://lore.kernel.org/git/20181227023548.396-1-rosenp@gmail.com/

I remember that one. And I agreed with Junio that the documentation
suggests that the call is _optional_, while the patch suggests that it
would be _incorrect_ instead.

And looking at
https://www.openssl.org/docs/man1.1.1/man3/SSL_library_init.html suggests
to me that it is still supported.

Having said that, if I look at the headers installed for `libssl-dev`
version `1.1.1-1ubuntu2.1~18.04.5` in my Ubuntu installation, I see that
`/usr/include/openssl/ssl.h` defines that symbol as:

	#  define SSL_library_init() OPENSSL_init_ssl(0, NULL)

but _only_:

	# if OPENSSL_API_COMPAT < 0x10100000L

So maybe that disagrees with the documentation that says that
SSL_library_init() is optional?

The curious thing is that `OPENSSL_API_COMPAT` is not even defined
anywhere. So maybe it _is_ the right thing to also `#define
SSL_library_init() (void)` in the diff you listed above?

_Maybe_ guarded within `#ifndef SSL_library_init ... #endif` guards?

> 2. eroen: https://lore.kernel.org/git/20170112104219.563497-1-git-scm@oc=
cam.eroen.eu/

That sounds like a good suggestion, too.

> Are the fixes made in these patches relevant here. Please let me know
> if I'm going wrong.

Yes, both threads are relevant, and if you can reconcile them into a patch
that makes Git compile with OpenSSL v1.1.1, I will try my best to review
them (Cc: me, just in case).

Ciao,
Johannes
