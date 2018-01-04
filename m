Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1B51F404
	for <e@80x24.org>; Thu,  4 Jan 2018 17:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeADRdX (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 12:33:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:63984 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbeADRdW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 12:33:22 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuxG5-1exrDq3vs1-0100Ww; Thu, 04
 Jan 2018 18:33:12 +0100
Date:   Thu, 4 Jan 2018 18:33:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com
Subject: Re: [PATCH v2 2/2] Windows: stop supplying BLK_SHA1=YesPlease by
 default
In-Reply-To: <20171228140742.26735-3-avarab@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1801041828540.31@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171228140742.26735-1-avarab@gmail.com> <20171228140742.26735-3-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-958618527-1515087193=:31"
X-Provags-ID: V03:K0:icC7jzlfO2l2FWRdCPK0k/4Maw6Sdqw9xZlW3K4tFynJg5qo5/K
 K3wEpLOLuFSx8lF00/CZzKhmzVHYfUSeV2c4BfYL4A5ZEceswsXGtyNN/6xPwxdUnkg06dq
 SDOpBpjq93v2n12ywWH/dKW8pbrC3XAMm5PzyE+5btV39ULNGQkSts+U2742aW15YZU1AVl
 9t8m6JZNoYhewHsyHpp7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yNesow9LF2E=:cEciaLi+/89kGjj47Q/kel
 hFheb+Ysd8yG4lCD3A026Ovw/nhAcJQ4vYOylzun7dgiuwMOd7Od9iZZZeIdLUk02np7/BlYR
 2OEqSaHfLo+aUTbkKwzRk7YrN6fzSWbuhg4Ww8BgUgYNfpDAA5VHpdYxlChjzXG0xzHkayfKk
 uGzJF8VyArZroXxZNTOdOErKCBrAwrf+0TYSQyFBiP0+HKkZbI56OsUQ9fj+Cf1J/QY5e2KZ7
 eZU0fWrrmhPtA2mBjhKyW56NNIk9y17ammCSn+10jm2UXEHDMxrqkgkCXBQShjTmssgw306LV
 81kEVaVsX6/4Oy0yVCGViUiOiP9giLOdciyojZwtYToX2pHPobUsCE2+yOwe9svp2aPPFb3C3
 TcTDnwSuFXfQh7Q98afKmual2gdJ2XZQPZ/ovKQqVZjkcx2eM/Z4NhaUzGwZn8YgSjVCg953S
 zy9uuPEo24ObCyKimSumeemwj4PZD04wZg9Rx3H6pEuUmclZUhQqKejm549fDtZeCJUMWbq41
 iFpPmTw3SEcamq0l3o7qGzvTrjzhVv+DdDqAvzG2ruIyPuSMzpaglZ0pfWMwnfinN6G4N0YgO
 D8ZFrFR47cb51/NeQ95bnrUcwhg9dA+UdM/3Es1fFBJTtV32iYI1zWuH2RJjUjGdOB0lz3SOn
 EcKybMPgz7lYiATsqv24SjfR7mprPLSfmoD3IgUMGkgxkJ29xBJRmz1EyyDOdupmtoP3CkdLQ
 DZed3C4qVYTZnxMu8hbNWebfDfEp3XRVFqu61ZyHH2A9vx+ZN0wsEf1Mf2ExhOBfP3pvFSRrY
 0c6FrdsMt+FeHWCmIBMUVYH9eGKODR23PzpMKssMNoGh8dK6ALmxTYIq0jZ8VrsX8PL4oFX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-958618527-1515087193=:31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 28 Dec 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Using BLK_SHA1 in lieu of the OpenSSL routines was done in
> 9bccfcdbff ("Windows: use BLK_SHA1 again", 2009-10-22), since DC_SHA1
> is now the default for git in general it makes sense for Windows to
> use that too, this looks like something that was missed back in
> e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17).
>=20
> As noted in 2cfc70f0de ("mingw: use OpenSSL's SHA-1 routines",
> 2017-02-09) OpenSSL has a performance benefit compared to BLK_SHA1 on
> MinGW, so perhaps that and the Windows default should be changed
> around again. That's a topic for another series, it seems clear that
> this specific flag is nobody's explicit intention.
>=20
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/config.mak.uname b/config.mak.uname
> index 685a80d138..6a862abd35 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -361,7 +361,6 @@ ifeq ($(uname_S),Windows)
>  =09NO_REGEX =3D YesPlease
>  =09NO_GETTEXT =3D YesPlease
>  =09NO_PYTHON =3D YesPlease
> -=09BLK_SHA1 =3D YesPlease
>  =09ETAGS_TARGET =3D ETAGS
>  =09NO_INET_PTON =3D YesPlease
>  =09NO_INET_NTOP =3D YesPlease

This patch is actually identical to 8756c75cd10 (msvc: use OpenSSL's SHA-1
routines, 2016-10-12) in Git for Windows' master.

I did plan to submit this, but it is part of a bigger effort to get Git to
build in current versions of Visual Studio again.

Before this work, the MSVC build could only use an ancient OpenSSL version
from pre-built binaries hosted on repo.or.cz, and those are unlikely to
get the performance benefits that you seek.

So I would like to ask to skip this patch for now, and take Jeff
Hostetler's patch as part of the MSVC patches later, once they have been
matured in Git for Windows?

Thanks,
Dscho
--8323329-958618527-1515087193=:31--
