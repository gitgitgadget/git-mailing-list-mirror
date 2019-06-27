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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD501F461
	for <e@80x24.org>; Thu, 27 Jun 2019 12:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0Myh (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 08:54:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:33199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0Myh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 08:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561640071;
        bh=u7ucvH8Mst2Ah+MxyMx9p3+xw9l/fuGAK6NtV30oyws=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hsuOckQM4Pry8fr2fAO0FQyAFxTPQGQveS/KsVnCAeMYaH60aJrXEvgqDTi4bWNb3
         kDxFp6EKpVo1SvBetpXRPwNqq5c1qiLsXzKP8ED7w8mym24RmzCjfGrZArarczfLUi
         knkrudsER6dUT/1s3HqZurzVbNeSbNROlKfOWTwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbPza-1iR39g3sWg-00kv8n; Thu, 27
 Jun 2019 14:54:31 +0200
Date:   Thu, 27 Jun 2019 14:54:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] sha1-file.c: remove the_repo from
 read_object_with_reference()
In-Reply-To: <20190624095533.22162-2-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906271448290.44@tvgsbejvaqbjf.bet>
References: <20190624095533.22162-1-pclouds@gmail.com> <20190624095533.22162-2-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1738728013-1561639827=:44"
Content-ID: <nycvar.QRO.7.76.6.1906271450360.44@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:ccKgoftuue6YeFOQXdXG3PkgdhcrnZaGN6Q6iP+YRNX5iU0spED
 DaAhh0s2c/IdZLJ5Cfz0dO0RPqVFu3uh42jh60W7Iz1yVZa13LkdP5WjYj7HfUYGFy/Y7UF
 /A4C2ra0UJv0TlPLTHJcO4F9Y91tsprF3R374CDMcoBUhTeQeDzZgV9EjJsX1Sed7pYeOZ0
 yiMpa1X63q0O9Huo4r7Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a0RStg4TJ/Q=:k5HkfYeon4eUOen+z2W4pp
 Ri07aMVO/38dGrnLbTmG+LkcuuDCzLgMAM5IyE6//6PtIagQz4Glm99Tc8RLIAgxOk6Yabtm6
 NCXD2R+QKBBRx0uB0i7fNuJNg2OaxAq7gGuqbzHs4q9I07AjB1JZcXgADZ35nwSmRk5HtI3nt
 J5Gx+m5ppaVEyYtYEVQ7xZtOCafyd0alWhoHBTBE1nZ+1j1BZOcwb2AsmjORMAB+kNNtDbpuh
 ixNKYPqdsXNyGMhlo3FDdPbYCew9asL86Gk227ZLckVS7di4+P1UZiezlVLS4eudHDIlM+BOe
 ArkC9fkqKM1sJMkEXezAjMk6DwDHVrP0K4oo7EI+DXXu0kPIFzDOHBoJ3m+h13gCmYjSNdJuT
 VoOtKQt8oX8g9AXUzpLJpsxpWKuthLFKXyKxcQAsxgwKzBWsY5wEYpB0BR8uE2j1pGInsIHB9
 GoUaPVkAeiIrkEPHAkpIvIupjv4YRt2DcH5AbJmOttNx+s7E2vmcCOOR+W/gpiqp8YQT4bHiZ
 dbKTesrulzJiiplA5SzDwLn70HiB1cCKo0fwI5WcI49dT2HfXW1TKTF4jYTsE2BCFpUocmAVy
 7RdFkOW7MnZ5/jFbtDHgMzA2N8PfGozXfECEnZNwvrs2XTD0z1IRBll5MYB3q0R1n5L4aWoM+
 lpHksjCnY45gbsFfLNvMG5vebYA2IxZUPr4cnvRl00blsP5/pmeGtg/eq5rk88+xIPE/RIhyZ
 mjIKDDPslWocwyyQmhqBOLrAIUkDaT/1gHCiGI/E3EWeuF5gjtlHBYCMdFNm0NmME2udQtXfA
 28H4ucHLReUnAE4HEsvhR5Up9k5vYmS2hSl5S3doKmUZBVFOVLers5uXsV99C6LOCwmWr74j4
 nhXKEo9LuswmxNq+r2EOX/JqxIspxVPWQf06Ni3VOjfjF5JUJYLsDuCNw0gFVNG5PtgFBGoPs
 HP+FtcgkiXD3SuZK80icqcpeEHS2hMvjy21D9Q22MqS7puA4OuC2I+6Wmjsqob3YxGaDhzVhS
 QJ56WIYOZ7v2aCrLK1w4mEd4FPYWl/xwW8rMQYCc2M9Jv1oEvu5ltcTzA3D0eQucNNWG/y5Sd
 Is7fp5tBdUXaCLR2fEuZ8dv70+A6c0/87ts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1738728013-1561639827=:44
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1906271450361.44@tvgsbejvaqbjf.bet>

Hi Duy,

On Mon, 24 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 580fd38f41..85da7ee542 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -458,7 +458,8 @@ static int grep_submodule(struct grep_opt *opt,
>  		object =3D parse_object_or_die(oid, oid_to_hex(oid));
>
>  		grep_read_lock();
> -		data =3D read_object_with_reference(&object->oid, tree_type,
> +		data =3D read_object_with_reference(opt->repo,
> +						  &object->oid, tree_type,

Junio's hunch was absolutely spot on. This conversion is incorrect. If you
replace this `opt->repo` and...

>  						  &size, NULL);
>  		grep_read_unlock();
>
> @@ -623,7 +624,8 @@ static int grep_object(struct grep_opt *opt, const s=
truct pathspec *pathspec,
>  		int hit, len;
>
>  		grep_read_lock();
> -		data =3D read_object_with_reference(&obj->oid, tree_type,
> +		data =3D read_object_with_reference(opt->repo,

... this one with `the_repository`, t7814 starts passing again.

It makes me very wary of this patch series that this bug has only been
caught by a CI build. You probably did not run the test suite before
sending this patch series.

I also wonder what the rationale was to deviate from the strategy used in
the remainder of the call sites, where no attempt was made to use an
already-available repository pointer that might, or might not, be the
correct one.

It strikes me as a pretty important goal of this patch series to _not_
change any behavior, and this bug makes me dubious that all diligence has
been done to assure that.

Ciao,
Johannes

--8323328-1738728013-1561639827=:44--
