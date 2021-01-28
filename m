Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB7EC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034C961477
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhA1Ppr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:45:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:57481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhA1Ppp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 10:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611848650;
        bh=iU0IfFQih+z4ggdYyo/+oLUTrMc9T9Wq9aFPcPuACaM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=D5yTuFiC2MK/3CioW0ICSNL5bl9GAnRa539WTr/SZisAhqhE/7MeZRv+hhdJhdwRy
         48kP2oMXQREDfmBLSkAAYfAsx2WFhZ3Tb0GGs6QLkiNla+0/vYZcvcukXVoEmOsazr
         1+Abb4rklXFRLoEmZXgCBepiYi65eqb5qLBDK8iA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.213.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1lcGA71iKP-00gHxn; Thu, 28
 Jan 2021 16:44:10 +0100
Date:   Thu, 28 Jan 2021 16:44:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH 1/2] config.mak.uname: remove redundant NO_LIBPCRE1_JIT
 flag
In-Reply-To: <20210124015833.2753-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101281641510.54@tvgsbejvaqbjf.bet>
References: <20210124015833.2753-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-787344588-1611848651=:54"
X-Provags-ID: V03:K1:MGo+QmhY0pUS8zYnRipeW19TPyjkuDuTyhB+LWci4w6teLPFW8G
 CLUR9xTksocm4Y/FN0ZEqOCSTGGDL7k3ZE6PkB4vKlmkLERvRza3uXvnfZdi4buqyouHjow
 FfW+IYuXK31f7aijxJlxxSDCNDcRfltyoFXEB12RLwVFpuu8D47HnZ+A+eqLkSxzHWBnIZr
 arH0+H7cccBxaYV/DZIlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OWQyYpbHrh8=:M6uUJnHGrhoDYYsEqHNSRG
 RC2PJxnoj8Xhf10ol2qzW8om/ZUgimsJFp57N19zgKWg+O7uooyKvEEwDzfZhZwsxny9e2YTC
 GbrCo2JM44hD57SgkAoF6/GZkKAt5cemIQUiJE4w8x83GAzllrWWIaLZIYd9caI65Y0TKPWFF
 ZllHZ4OCA5aM0uBMMllgyD1falMK3xPY9EDC3M2IW7roZq8edwSgyVhgfsQIY1AfD1Oy1ZT1w
 NTkJVppMS8lMMnpITiPTK9ifacmUuRqmfEDsLIm16heTz4KOOZuOgmbKAbo/mqRmne9ncWWre
 ZtRNbDYH/HWNp/a0OK+qcFDnYJarWWzW1XXohCsJfzOzm47a0MO+AVAEQwQ1WbfEqefPQfDZx
 OhWkfhnmHMVUC3dfYN0IIi+pErBS4CKwg/xEjohIRVdBMCfqiDgo/JBk7jNyGiwmcknpGOOBO
 NJmK2vOYirbJstpRkhtbG7fCL7ATe/O6k/Qpjxv1b21oH8uwROoq+wBl46+6yuFxVY6S+fDOK
 tJ2lLGuSd82xEXeV070mAlfaljRmbKmZ4/KWaybD1ODsWxf46BCtD48BptC0jt/wPFfKwQAdv
 Ss+MqSnPf+klHFtPkd9y3qqcTF7zb+3pSn1h5vVBwN4l6mom3FL/6WbjMwVLb2KRGwYYMuh1N
 AxkUFfp8e8bmNCfZcPPIU2usZCLTb8+XxXh2VL+GpZmqnJTtO0F3AyU1dnLSF3b5j6LkUnd82
 oIvRAjd710En8DdcHsIOpZGulicEGQaAUu/KbEZvrLpEzDURPIHFYqYmv2oo4GxMhtRtL6e2a
 vXqGmhfS6/sxP4kIBCHi5OWxePMgu4Gam5TENFgMgRRJrvHp64DwU60CdyTwtbGbq2OMISZga
 jMWHrm3VygsKIHOOGcHjOFaSU8JaA961M+bWjJAOI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-787344588-1611848651=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sun, 24 Jan 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Remove a flag added in my fb95e2e38d (grep: un-break building with
> PCRE >=3D 8.32 without --enable-jit, 2017-06-01). It's set just below
> USE_LIBPCRE=3DYesPlease, so it's been redundant since
> e6c531b808 (Makefile: make USE_LIBPCRE=3DYesPlease mean v2, not v1,
> 2018-03-11).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 198ab1e58f..e22d4b6d67 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -664,7 +664,6 @@ else
>  		NO_GETTEXT =3D
>  		USE_GETTEXT_SCHEME =3D fallthrough
>  		USE_LIBPCRE=3D YesPlease
> -		NO_LIBPCRE1_JIT =3D UnfortunatelyYes

FWIW this is almost precisely what we carry in Git for Windows for a while
(to battle-test it), as
https://github.com/git-for-windows/git/commit/735a58a38d43659cb985d717ec7e=
da1f26e121e5

The only thing that commit does in addition is to insert the forgotten
space in the line above, between `USE_LIBPCRE` and `=3D`.

Thanks,
Dscho

>  		NO_CURL =3D
>  		USE_NED_ALLOCATOR =3D YesPlease
>  	else
> --
> 2.29.2.222.g5d2a92d10f8
>
>

--8323328-787344588-1611848651=:54--
