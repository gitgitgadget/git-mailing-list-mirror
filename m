Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B1C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F68761205
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhJVOcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:32:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:39655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhJVOcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634913010;
        bh=Oc3cw39AvMJc+NbuSEd4F2KRDiIvCekhTkn2gCe1pmo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W6c7ctXz0OkjHvGl4R0/ksg7WDLrvAzFY8YG6EFr2HwO0xn2J4Aa5hwoURFPiCnmO
         SguG9RzzGpc2hrsNZI67G0EVfHWP0/CBdSNvs3GekAQoaVnlRdkFiogUG0ZeRk8/4Z
         RjcKE0lZoCV40gx7NFh84lNnbZCZLEaOhKlX7dn4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lcJ-1mdeRW3Xlr-000q4q; Fri, 22
 Oct 2021 16:30:09 +0200
Date:   Fri, 22 Oct 2021 16:30:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: remove redundant GIT-CFLAGS dependency from
 "sparse"
In-Reply-To: <patch-1.1-207f1019e70-20211021T195940Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110221628190.62@tvgsbejvaqbjf.bet>
References: <patch-1.1-207f1019e70-20211021T195940Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-274185619-1634913010=:62"
X-Provags-ID: V03:K1:DZI+5el24NjCqGhqqDxujB1+Gj6/MaxQSIqdW810sS8zcTDJ2Z+
 SUk/KZjdDwTgDxVD9SbxGJkAbtyJXGDurAEZlCg8utRQ2ocR47dkbUYmblghXQhCkVi7oFw
 6Qo8bSb2xY2jF7/0cVFiVfiJbAZsWb1zkw10W7OQEYZeVCeLVeV+Lt2Mj5jR0C8lcUtDWhk
 88RX+T0Mhz2jA7pCEBmww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DEouSkGts2k=:Obc6nKcpywD7D3Q+DxQUzY
 BDb/auGRIDSxY3H7bzCG+OFJU5LYtcl1i4pyGuqADDtSQxtFOqU9NEs2h+8vFKKIc6mDwbNrr
 iLAvJDHiGXaZvce2PdMiC/5TonFtDY1iJi8Z8wWCyQArLrGS3OHL6SDs2UxSrpKp/muUpuZwH
 VXHh9jhYzlzsTg6OMmRj8NOBLDJRQGBhsG9rWq+RQk3JiForAmbKCiaLKsnQUhjZa6vqPRv/P
 M5DVnTXOOtXAOutaFI0ToUT5Aivmbwt8vRsJATU95iQQ2KG7xUFyHnAtO29lvNdhQ6lIddcL2
 Q7o4Qau2ATjuOEiqdrGw4LsEkhiHodIa28LODiFugE+EEJK2P6kZwLRLVnQFmOhKQE0Yw5CR/
 Rb3vI3Hez7RCzH8NrY7pJL8Tz5nb23lROfCP2b6SHMqPtCQW3vhIhVh/fogzP1NAaslhX2yrZ
 dSLzWeTt3Yx5SUVlaDHZ2pGqLE5HSQIObdWc25JqDCO5rt2IBMTCG+0rmrX8ukeOx6EN/CzZT
 fV0FLnpT43Rw5eFj9Kax/rkPN/FNXPfQLIRRzQdicVoeePIAa6DYhJJHDE57IA5xYozbShSdd
 DayXUCoKs+4EgmbFOYIJ1VpstQ22S5Euxya3yustPNhOnH8/RBRVHUmovDGH7mKp8Cyf+UBYN
 kD++vfJLxWzIGH6YG1g+czO2WymnJqZdUuaZSekhxnztBlpsBR752+mBIILt+VhqAKmCycC73
 M3nCTZa/qOFO2sWdH01rwHle5B5uOYm518J3ecm6H/m5qZzmAv/coQLrnqqS6l6IlbA61en54
 RguPe/hNaShGvIlbQOjQqasPZ0GaEGr8dZcEqjDzJnY1YYzXUsysbdGS5T5dGuXIzdV4EXG6+
 uYcNzzbUI3/xScBO4NESf6QZ417n2JZdupmlh9XurkvcUeFLugw83JtcNoVonr00rC9XrLkao
 pidth4YoHDnAH56zGOqCwL6X6xMWLGJ30sIXeRiT4+Ses48Fxeq8xxzHiNCP1Bt/9m1Vg/lnl
 mECOvjt+o5DkPSh4utNihxj9fL8XBben1qoW9u8rIxwobgQKiiFJultNzVJmpNZwXpcCMmOUm
 vQrI2RofVp4CBQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-274185619-1634913010=:62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 21 Oct 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The "sparse" target needed the GIT-CFLAGS dependency before my
> c234e8a0ecf (Makefile: make the "sparse" target non-.PHONY,
> 2021-09-23), but since then it depends on the corresponding *.o files,
> which in turn depend on the correct header files, as well as on
> GIT-CFLAGS. There's no need to re-state this dependency here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> A tiny redundancy fix for an already-in-master topic.
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 381bed2c1d2..12be39ac497 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2901,7 +2901,7 @@ check-sha1:: t/helper/test-tool$X
>
>  SP_OBJ =3D $(patsubst %.o,%.sp,$(C_OBJ))
>
> -$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
> +$(SP_OBJ): %.sp: %.c %.o

I _guess_ you could say that the `GIT-CFLAGS` dependency is redundant by
virtue of the `*.o` targets already depending on it.

But then, how much does it hurt? This late in the v2.34 cycle, aren't
there any issues that might be worthier of our attention and care?

Ciao,
Dscho

>  	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
>  		-Wsparse-error \
>  		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
> --
> 2.33.1.1494.g88b39a443e1
>
>

--8323328-274185619-1634913010=:62--
