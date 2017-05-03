Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE84207F8
	for <e@80x24.org>; Wed,  3 May 2017 15:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbdECPZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:25:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:49228 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752091AbdECPZW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:25:22 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHX4u-1d4qDr0VZM-003LWd; Wed, 03
 May 2017 17:25:11 +0200
Date:   Wed, 3 May 2017 17:24:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 15/21] rerere.c: report correct errno
In-Reply-To: <20170503101706.9223-16-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031722420.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-16-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-237359341-1493825111=:3480"
X-Provags-ID: V03:K0:vgPOq5N8BwbeRo6C+1rHXKkdo8zyZ2ZFmc83eppGhDlT51ZZEW5
 rr3tmK97Pb6Z8sUSTM4FcZmLm0v97XZqviEmzLP36y0DNbiZGJ73PW9mPOStXI8fZFelpV4
 KN3los0dIPqKaq6YBItnkn/FKyVztJ2SOdUxFWrBwMH0PNxECOSRv5BJ1UNmMwDkHSSj7V8
 QEYbRhAWnZXwK3g8l29mQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7mhihIxWMdM=:9w9kudBvF/6Pl9V5zpNinq
 nQ9NzoHPRkcb/iBhUTNLsuvlUXYAr64DxiyVJKUQgmvtAwOnCZ8+UFYYSWlSJ6lUDB4DycAjC
 lIV3ErynNjWnomqM+Vsl1jMKPzHU1YUUrDPKS0KLxh8y9w3qr9I8D6Dn1Hd7lBK5zB8yM6gFM
 eQfk8bx/x+SwxBECAdQsuquv0EX0ActwGxypGYS49sI5foOnxoNNgkYACzGK75UZ2SISZCu+x
 gNNgBxXstOCMQnbpJviOH/LUPuHR44A7TQMdJPQwFxrue/Uxrc24sw+X2wNgz9gzOLgztSge3
 S8mv490PqY30GskjKEuI4g1UI674FbMWM5Ur9HFN0p/Rp6wjn+CeS55WlltJxQ9SydSH3BcHZ
 0TNzUu551g6bh1l7X+dc4EJC4KX2X6jagHgEeL4bocVcEaAOEhrrZiePIO/x1YN/Jmj4Ox51F
 k1oOgSSVatg/cMCnDVCaprflvGoXkLmrIDYd4d5GwdEtfxo9Df5KLmScXqKHdpmgC7RYtrC8w
 DMiO2t1O6lKbOxaFy12KYgKwxB2d5yCO4la+N6p0dLLcdeii0tKCXCcTQKr7E+X2I6S2tj1ZX
 W9+TnH//FIaQ0P6Ew3J1nS+4N3CvUhmaDtQJL5ghog9AsPk8ihUx0SkhwTrRfznUplhfPfDgL
 A6QfCyxZpk7zY2hsb4JwjtlHn0HffEQU4JbwQlDSWgk9lVv+/fllcRD7GQsJ+8QGTXI6WUSSk
 Dzo549eFQtgo4nHlWii/jVcXD21la+dlhzqQGh1YgzFmBLG/dTGYrvi7L321i70qdvZUN48zn
 vUUvFOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-237359341-1493825111=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/rerere.c b/rerere.c
> index 971bfedfb2..c26c29f87a 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -484,13 +484,14 @@ static int handle_file(const char *path, unsigned c=
har *sha1, const char *output
>  =09io.input =3D fopen(path, "r");
>  =09io.io.wrerror =3D 0;
>  =09if (!io.input)
> -=09=09return error("Could not open %s", path);
> +=09=09return error_errno("Could not open %s", path);

IMO the error() -> error_errno() changes should all be part of the same
commit, as they probably share the explanation why fopen_or_warn() is not
appropriate here.

>  =09if (output) {
>  =09=09io.io.output =3D fopen(output, "w");
>  =09=09if (!io.io.output) {
> +=09=09=09error_errno("Could not write %s", output);
>  =09=09=09fclose(io.input);
> -=09=09=09return error("Could not write %s", output);
> +=09=09=09return -1;
>  =09=09}

This one is logically different from the change above, as it not only
cannot be replaced by fopen_or_warn(), but also requires the reordering
due to the different nature of the change.

Ciao,
Dscho
--8323329-237359341-1493825111=:3480--
