Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F8A207F8
	for <e@80x24.org>; Wed,  3 May 2017 15:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdECPWO (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:22:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:51768 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdECPWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:22:14 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaIsi-1dLH7u2u1w-00JvoP; Wed, 03
 May 2017 17:22:06 +0200
Date:   Wed, 3 May 2017 17:22:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/21] remote.c: report error on failure to fopen()
In-Reply-To: <20170503101706.9223-14-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031720000.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-14-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-70922210-1493824926=:3480"
X-Provags-ID: V03:K0:duUg0J/aE+HqdmsYUyv+E4Gk7L9LIGuD6QQmFpT7ykDTIJQmC+Q
 0BFKJy/4aaLbRWXgz5bpsf6H9XsA6FhDFmBxIULr21Dd0xSTDGsjK0TtNpEfyQkAzOp5V+y
 6Pdi2wFHF3+kVt7Y3OmUlMN/LfXaUv8G7JWNvLs5mJIa4y1jMoIBrPBsATiCgSZpy1hFNwT
 YXknOHdkQGwjzk93J9H0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMPNWaEd9tc=:ziSuXmRS6wDeLY+SL6f9e9
 B7SKk/epKqOIxrfFXC6i47ShViE0Nho0vIdv6eZh3QFq8CneffW9JL13vj7RkwOWscxv/IscK
 tCZg4oU7ikjUK5J5rsuYfMg2Ei0+hnD2U+SLXha2aP7CMtU0wdhG3JieAPZ7l//8Fj5gJklqD
 DAk2I67ShpyuZI2f7aYmK/+cXmzGbJr9XPgaleZFNXQowcstYpouqZ/H6krGBsEEN+3Dmai7m
 MelMYWZ6RAnz/MRVqUYJ3JQQ2f3ZNwPU1KtbjvWTqA1UckmpF6BOcPozNg1OhVcsdvW6kqrQt
 nNE3ENGZJLxOunFNVQgvoLOJW9lO17hrF6yciH4kZ9CjnXobxFZ26T13emCfz1P48y5uTtSjg
 J0Q3y9CosaYDWBp12PBnsKDlNHqoyml4DoBtcbhO0zn+iVo2bdIdfWUC1+8HQpNUjNhbmlNdo
 82G55B2efjQto43Zo2IFWKQZjIuTlXzUeB8w4fGlGRrRF60j0yFJhyK14/6Nqpli8aDFbKuvp
 EjYwBuvkaoSYgvp4f9FP+mIGSwgx4aFwKfgHml9VevLbdcb3LWy24hgAFnHh3iQZ2Axj0NHR9
 wlAebHRZbxD3oyNDimuc/xNXRqUfLX+H42JHLtd5rWzZpy9CbHXoHJaATFAH+WDSw26cJK/NR
 W82VDuUQCjPE6qTcvF3AgjG/svZSD3pmvP5m9OgsXNRjNBRrOluYiWAcuVNnrstg8VtpX62Tj
 xScV+3qTK4d9MYS8S2FySMrM0a32j3fIiEvlavkGKpcpd7YULOQnK6zWrLIQTThEAk5AoFgQu
 rwvENrK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-70922210-1493824926=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,


On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> There's plenty of error() in this code to safely assume --quiet is not a
> concern.
>=20
> t5512 needs update because if we check the path 'refs*master' (i.e. the
> asterisk is part of the path) then we'll get an EINVAL error.

So the first change in this patch unmasks a bug that is fixed by the
second patch?

> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 94fc9be9ce..02106c9226 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -85,8 +85,15 @@ test_expect_success 'use branch.<name>.remote if possi=
ble' '
>  '
> =20
>  test_expect_success 'confuses pattern as remote when no remote specified=
' '
> -=09cat >exp <<-\EOF &&
> -=09fatal: '\''refs*master'\'' does not appear to be a git repository
> +=09if test_have_prereq MINGW
> +=09then
> +=09=09# Windows does not like asterisks in pathname
> +=09=09does_not_exist=3Dmaster
> +=09else
> +=09=09does_not_exist=3D"refs*master"
> +=09fi &&
> +=09cat >exp <<-EOF &&
> +=09fatal: '\''$does_not_exist'\'' does not appear to be a git repository
>  =09fatal: Could not read from remote repository.
> =20
>  =09Please make sure you have the correct access rights
> @@ -98,7 +105,7 @@ test_expect_success 'confuses pattern as remote when n=
o remote specified' '
>  =09# fetch <branch>.
>  =09# We could just as easily have used "master"; the "*" emphasizes its
>  =09# role as a pattern.
> -=09test_must_fail git ls-remote refs*master >actual 2>&1 &&
> +=09test_must_fail git ls-remote "$does_not_exist" >actual 2>&1 &&
>  =09test_i18ncmp exp actual
>  '

Sure enough. This totally looks like it needs to be a preparatory bug fix.
Please separate it out and make sure that it comes before the
fopen_or_warn() change in the patch series.

Ciao,
Dscho
--8323329-70922210-1493824926=:3480--
