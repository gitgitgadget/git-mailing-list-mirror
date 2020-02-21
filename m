Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F4C35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1E920679
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hE3k9tIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgBUPWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:22:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:40349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgBUPWs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 10:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582298566;
        bh=QzkmebHhrM1RO2lXR0uDrY9XZPC/DglXtu0T0j2Ral8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hE3k9tIxWYRVWFt0isW/+k+JNxC5fcqoytekwQ9TvJoNEeYzhsUXiafV3I0aDBOEj
         eFRK37gkY5UW6BGGB8rvmZwn2c27yuW7lhpD6OWKHyMbB2xALsNXWsnbJ7Fonrd/q2
         q/CB/FcGY4lrSV+wldK5BfbqqfkvaoHOvNFoaxBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1iwWUb1oiN-00Z3FX; Fri, 21
 Feb 2020 16:22:46 +0100
Date:   Fri, 21 Feb 2020 16:22:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 06/15] bugreport: add compiler info
In-Reply-To: <20200220233323.GI2447@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002211621470.46@tvgsbejvaqbjf.bet>
References: <20200214015343.201946-1-emilyshaffer@google.com> <20200214015343.201946-7-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet> <20200219224547.GC26221@google.com> <nycvar.QRO.7.76.6.2002202306390.46@tvgsbejvaqbjf.bet>
 <20200220233323.GI2447@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mXe2YkvCQ9q3xl69yrp5Fajk89V5yoWqxyiew/sxdmd2K3p7evi
 Fr3qLs3+JBRcqK9xuMj0r4CJ1tN2TJxocOpwFzXvWQA06/L4pVL33Fo18H3h/eJGdzXqiLU
 OIAIHSxRsKN0dHptxmVeudZHDjE9MgPI7I3jn3WTuCTGBoGO+NSNI8uzTZc7I2yR25nXrka
 CUjsSISwGe4YwzfHMp6zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u5kDSsWV0So=:DTp7PTJ1IUvylyov6HjZ7o
 L4sgJDPCTiY2VeJ8uxxuwR2tNCqqupNRVZQ9OsxOXubGkMrSQIlMwOugm5USahu9zG9EkuCvH
 2XXatSrQsqkIqVk7Gi7/nWrHpIQ7t7MD6AOhw7WWp99puwtJgVA09pWxbxwfNEJBWB2uHlSfn
 JTno8xyut24ekrf7KeS8E3hwTTV3gZBbzWKxLIR7Wzsje1fvmFhDs63IbEziZ2w03sCV5Y4Wz
 7mX8yHgRCnTj9Fae4juC2FcWnIbawmw3RBuZSUW0Qk5ar/KxuMnFdcyDdIYOt1IaKrKn+hMr0
 W+MC1K4+tmp6L45LMUtB2JHMLKO73VGjIljod+HWeC9eb+vm09hScMqWKNpyKSx/i47qmr7EA
 3BvWn4Jhu5NU4dvsP0qyo6dRut8RupRU0MDL7AER4/e/5q+udMjCoAUsA/QwPFECWEFCAoyC8
 6HzMEDANiA2nsYk6dFC3BzD2V4p5xAPa7Q6h5yIGBrkhM5blo9Y5Y/iMj3K2+k2eT2NTaoyfq
 e2SAn/wTvoZFOkTtrwsT2Ck1xEPIFTCXG/7nF1auEgGUbADdkV9oRUcypf8hWWjwGirLf5ax2
 sMLloQHfjnYMYicY298PMemwOihu3q+nO/uJdIHQFpKbIOHds1Mth2yPdWjhEYYboRP1vhell
 htlcpckib67fQdI1JvVBxSSyYJ2/oUm7/BDS47kxa9RvaoA8cfFk1AT3rihb4+9z+iUuCUdbA
 MK3QeTiGa+6CmB8gxxEao2sltO19PA2ROk75ZI7jX2YJeLKfN44ue76sU+Wd8J7Ldo401OMPq
 FebB2RvdRrJGv4GyGDhasZNAbSk4lMBWzF3DeaGw0T5WLVI8nem/29SYRiam/YBcI3Vy6mcPB
 OWm/9727osjK0lpMu8sxvGs5DmpiYiexfSfSZEWY/ZOOH0yjwauOsnyvRl1xMvDwnwylMaLga
 3RfP02ha4BZKza6LcnMm2pMYoASSQiyHJd+z6pNbhZvopRZbazFMHx7mdCxJMRWHRVdFnpkTQ
 evWqJwIFkTYgcDPWvoQUPDflY5F20/2A7Ni2by7xNszp4dgE36yfPSVnbcxQ+dq11y7g77Ne8
 nzF+MO+JSYRiU4xAST4xTUoi8o+fHfjBs9XcCaAbpnIwwi2g/OJubWivTs8Q1QIAH/UdMO9ya
 MAdw6HTAXQZJou9/tAX7AwvPie97mBvAl2RYW4yBW5QMsTmXFAlzQu2v2dTzRKNOl7lxKzvQC
 f8euNjO6TibCZseLL
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 20 Feb 2020, Emily Shaffer wrote:

> On Thu, Feb 20, 2020 at 11:33:05PM +0100, Johannes Schindelin wrote:
> > Hi Emily,
> >
> > On Wed, 19 Feb 2020, Emily Shaffer wrote:
> >
> > >   #ifdef __GLIBC__
> > >   #include <gnu/libc-version.h>
> > >   #endif
> > >
> > >   static inline void get_compiler_info(struct strbuf *info)
> > >   {
> > >   	#ifdef __GLIBC__
> > > 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> > > 	#endif
> > >
> > > 	#ifdef __GNUC__
> > > 	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> > > 	#endif
> > >
> > > 	#ifdef _MSC_VER
> > > 	strbuf_addf(info, "msc runtime: %s\n", some_msc_info());
> >
> > You could do it this way right away:
> >
> > 	strbuf_addf(info, "MSVC version: %d.%d\n",
> > 		    _MSC_VER / 100, _MSC_VER % 100);
> >
> > Note: this is _not_ the MSVC _runtime_ version, but really the compile=
r
> > version.
> >
> > You could also use _MSC_FULL_VER, which is a bit more complete.
>
> Sorry, but I'm not comfortable sending code I can't check for myself
> (and already muscle-memoried into my format-patch/send-email workflow).
> If you send a scissors I can roll it into the series with your SOB.

But you can check it yourself! I worked _really_ hard on that Azure
Pipeline backing the PR builds at https://github.com/git/git. _REALLY_
hard. You might just as well reap the benefits so that I did not spend all
of that time and sweat and stress in vain...

Ciao,
Dscho
