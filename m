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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C50C1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 11:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfJNLzD (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 07:55:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:33117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730593AbfJNLzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 07:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571054096;
        bh=REfpDgz7+T8Uc2IUQ+cGnsSCUZuV5QUj2N0ZMJC+NRI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LIMw/QzA95dPs79gjx6aUCpKG6HyFYgAeuQAqJhsy5V3XN1HhlQ94+8rALiyEqXPI
         y6PGPaXhIPKU39c/54VAxsb00lzP+LY8i8WpxTeS+jxf+OtHRaOIpYXlS860/f9JrB
         Rc522Q5GJTu88qarcxEMmYLsRYjkyaxHRFbeHOow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1iVi8p12Yl-00TVvZ; Mon, 14
 Oct 2019 13:54:56 +0200
Date:   Mon, 14 Oct 2019 13:54:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] mingw: bump the minimum Windows version to Vista
In-Reply-To: <87zhvlevxt.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910141351580.46@tvgsbejvaqbjf.bet>
References: <pull.44.git.gitgitgadget@gmail.com> <2b127d9669aa7b73ced7611b6e77044f5efed11d.1538595818.git.gitgitgadget@gmail.com> <87zhvlevxt.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1714174309-1571054096=:46"
X-Provags-ID: V03:K1:ma+faRfB37CNmiPVnQ1cHeVG3MNZuv9o6S/CmSKSw5/dKYVzcTt
 Tw7koCApuGSo2oNYw2lAhUnK5rOvsdmcLXXIknEDaLuoWpRl61ZLz0TSyyZu8KyynnkPRX2
 3WG6slo1+sqbNmXyWv25u4pRbDnLtVMt+iw/XVlJoiVrPB8P59w9Pz4EKOVVgCLqeB4PRNN
 z1jabrFHf7s1zDkU7LuTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9w2aT9qNvFo=:11oveRVK25dycdIg6IL7Uk
 otzRRO0LjY0huTPjWGsvhoF8ldbaBIzb3+Mtu4egtmhdzjxT/I/ahG6JsBHFluZVa+wdn74lc
 HqW0ZQ4A7ThQ0m/MOpY0v7rPQxvlEYquXVZzhXEfoLveD2u8BXMWbSsVKh1BEbDOwpYMcyDjj
 0x9XLGFiW+iC6T+bCzRmGz66oORajzI7vdEpUngQLtS92M+viOt5IwuOP91oyo2N4HJrQl4wA
 oXYWIG+B7U2cfmL9ySR92AWa8j/9j3soLaKrU7eQozHmyw004Ol5dt5P8xwIb39ieFqB01Nx7
 nU/waWeJy3Tjsbgj5CJC13TVC1wcRaHcrHkXCd24TOKca2AFksSFvdDI+SQL++zrgdcEHyUuO
 lNneqtw79FZ9K5TEMAKgZU27cTWteEt9gTdwhIw14gWfw4Nnpx4340tyYEPSEhlbjJM84rrYM
 xqB+goIi8Y/TQAypeGNxY9fpxbE1SBBerSx61eU10WUQQOy671iY/2MZC3w+55aAeeNZq/hI9
 ZwkupDpVA7PPS6tCHdT1bLHMwgdD3tjY2n96rg1X5KZN/PTchkzKym+4aCpARjk4O/WwnZSbv
 BCZSXACJ70L4VnDUDfiVW1PW4SVtUgPhZ+PLxoWnVdQ2zNXPDSkXhmjBVjJU5E9ot81faVB3C
 //Fl5V7Cj3j7uu0QSUR9WpxXErDEFjYFbpKuJqO+Q1/r5apzuqRhzwddhuqfHVQLAWowkz2KZ
 eUqbD0CdTOyGsZUq+Mn0b67InxRjWmQbGURiAO8qGvzpeUF8/iNBaj8JCkpJ2nhdrf7Q/SH1+
 KpjHdUYkYPNX468BGdT7ED0tWWt0vpICPwvt+NrbcMiD/120FiE90u3tHuMXgUcCUbdMViXRv
 vuu+Z09bcykgTI3c4wELG22/szEV9R3/lRy8yVdftZFkKVlh5oZlLD3tQM732GTj7AiC27mYs
 JrP8eV8ymxawxSTjN0EbPtM0Yc1px64isczgSQyRAMY7KCNajsLMislYhv31t84hJ4Ttpna29
 KZj5c3qEDVl5U1N1V50lKJUS1KvHPY30RpoQPnU0YgnHxwN0V9VRnPyW4ThfyGsw6/L7TTHT9
 rHf9hS9/J5bBPCJTYF4lQFzCGRP+hhAmCi3DoGCUqCPcqcLaDFtQgKJRfFMZ31N2TYywXnqgg
 G1rnMTVH+ciSb32xIXZadRcn58nMjCm3qhFWDpdl+Ga6HxGcixutSYRZULR7rJrlyi4iNm+Gt
 rLpau77Hkj5OhkMQopRMLgyydvbOG9qfTb0F72K/y5Q7WEEBCCFphyC8S3Os=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1714174309-1571054096=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

[sorry about the blast from the past, I forgot to answer back then.]

On Wed, 10 Oct 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Oct 03 2018, Johannes Schindelin via GitGitGadget wrote:
>
> > diff --git a/config.mak.uname b/config.mak.uname
> > index e47af72e01..8acdeb71fd 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -381,8 +381,6 @@ ifeq ($(uname_S),Windows)
> >  	NO_PYTHON =3D YesPlease
> >  	BLK_SHA1 =3D YesPlease
> >  	ETAGS_TARGET =3D ETAGS
> > -	NO_INET_PTON =3D YesPlease
> > -	NO_INET_NTOP =3D YesPlease
> >  	NO_POSIX_GOODIES =3D UnfortunatelyYes
> >  	NATIVE_CRLF =3D YesPlease
> >  	DEFAULT_HELP_FORMAT =3D html
> > @@ -529,8 +527,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> >  	NO_REGEX =3D YesPlease
> >  	NO_PYTHON =3D YesPlease
> >  	ETAGS_TARGET =3D ETAGS
> > -	NO_INET_PTON =3D YesPlease
> > -	NO_INET_NTOP =3D YesPlease
> >  	NO_POSIX_GOODIES =3D UnfortunatelyYes
> >  	DEFAULT_HELP_FORMAT =3D html
> >  	COMPAT_CFLAGS +=3D -DNOGDI -Icompat -Icompat/win32
>
> So before we were defining NO_INET_{PTON,NTOP} because XP needed it, but
> doing so on all Windows versions, is there other compat stuff there
> that's just catering to the lowest common denominator, and if so
> shouldn't that be version checked against the NT version?

I meant to reply much earlier: When I worked on this, I essentially went
through all of the functions that we load dynamically on Windows, and
I don't think I found any other pre-Vista support code to get rid of.

Thanks,
Dscho

--8323328-1714174309-1571054096=:46--
