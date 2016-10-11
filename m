Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EED1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbcJKRzg (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:55:36 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33592 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbcJKRz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:55:28 -0400
Received: by mail-qk0-f193.google.com with SMTP id f128so1427525qkb.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pEYd1beR7GLkXf22CNgGJucqhpKbZi7Fgd6t3Rpt2BU=;
        b=eGS2zbY2g9WPZqe2hqBbyGc1gXu0FtWY/ZtoTfztffLg3F4FSXBb8H3OhAL9rmetAv
         Q9IqSVrsqdjry7Uu2D3uoX7jBDuk46kK26RnEsdj7YITzyg+IgyVA9JF3UapLP67jrCA
         2600hhJPZXUCu9908Q8NZdMIiIFXN0kHIW2VVtaqs4psdA9vctAljS/+Muv4NRkLAYXN
         GZsKuswPxJBKQRfpG4d9cumRVm4rPt4k0uHt4Mssolf/ieurIM9DRx0c4xe8ThkkeVFw
         WvBCmpg/PQ5zgY4hWVq31QFf31LuOW6jpkhYbEH8+CWny/SA7+h7x2Ic9C/XOSHoYPvJ
         a4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pEYd1beR7GLkXf22CNgGJucqhpKbZi7Fgd6t3Rpt2BU=;
        b=IAmNI/MzSHEjGa2YS7hP5x0j/YvR+8rjYm3yfKgQGn4iYipJQtbRZrjZgsZiMsREWY
         t8vo0Fl1Kd0j8Xl3lBJIm9wfpJu6W1Yb+46CmfiTsMyDNyjunzTUtQnSKs4WEMhW0pLo
         FaU7NSElLLZxCwMTI/935XMjuKYK6Y+oihtMaBFh8d/xy/4Gvjr+JOmXsUuRplAPM+w6
         lmw7wkIpHHMu7OAxB9yPHkf/e+lN5Qnlc/HvhcvdUBekVpJWvhFYf/8FWfKuEJLApcE7
         Mrc0NP+lmI7R5lQsT22lWHOrcYghBSi76qqV1ocqHbeC6VY69FmVdn6mK5F6hB06omsz
         ZNRA==
X-Gm-Message-State: AA6/9RmCLDM5YVykQEzpGwsf7M+OLTapt7ewkpTnuyN1t7ii+DKIOpSVJwsJT0xiMoD++qzq
X-Received: by 10.55.98.75 with SMTP id w72mr5027525qkb.91.1476207831109;
        Tue, 11 Oct 2016 10:43:51 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id g22sm1461945qta.1.2016.10.11.10.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 10:43:50 -0700 (PDT)
Date:   Tue, 11 Oct 2016 13:43:49 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v4 0/7] Add --format to tag verification
Message-ID: <20161011174349.dp44e4ir6tweuzzv@LykOS.localdomain>
References: <20161007210721.20437-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="svclup2bigbn7nfb"
Content-Disposition: inline
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--svclup2bigbn7nfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed there were no replies for this thread. I was curious if it got
buried because I sent it on the Friday evening before a long weekend.

I don't mean to pressure or anything.

Thanks!
-Santiago.


On Fri, Oct 07, 2016 at 05:07:14PM -0400, santiago@nyu.edu wrote:
> From: Santiago Torres <santiago@nyu.edu>
>=20
> This is the fourth iteration of the series in [1][2][3], which comes as a
> result of the discussion in [4]. The main goal of this patch series is to=
 bring
> --format to git tag verification so that upper-layer tools can inspect the
> content of a tag and make decisions based on those contents.
>=20
> In this re-woll we:
>=20
> * Fixed the author fields and signed off by's throughout the patch
>   series
>=20
> * Added two more patches with unit tests to ensure the format specifier
>   behaves as expected
>=20
> * Fixed a missing initialization for the format specifier in verify-tag w=
hich
>   caused a crash.
>=20
> * Fixed an outdated git commit message that had the previous name of a
>   function definition.
>=20
> Thanks,
> -Santiago
>=20
> [1] http://public-inbox.org/git/20160930221806.3398-1-santiago@nyu.edu/
> [2] http://public-inbox.org/git/20160922185317.349-1-santiago@nyu.edu/
> [3] http://public-inbox.org/git/20160926224233.32702-1-santiago@nyu.edu/
> [4] http://public-inbox.org/git/20160607195608.16643-1-santiago@nyu.edu/
>=20
>=20
> Lukas Puehringer (4):
>   tag: add format specifier to gpg_verify_tag
>   gpg-interface, tag: add GPG_VERIFY_QUIET flag
>   ref-filter: add function to print single ref_array_item
>   builtin/tag: add --format argument for tag -v
>=20
> Santiago Torres (3):
>   builtin/verify-tag: add --format to verify-tag
>   t/t7030-verify-tag: Add --format specifier tests
>   t/t7004-tag: Add --format specifier tests
>=20
>  Documentation/git-tag.txt        |  2 +-
>  Documentation/git-verify-tag.txt |  2 +-
>  builtin/tag.c                    | 34 +++++++++++++++++++++++-----------
>  builtin/verify-tag.c             | 13 +++++++++++--
>  gpg-interface.h                  |  1 +
>  ref-filter.c                     | 10 ++++++++++
>  ref-filter.h                     |  3 +++
>  t/t7004-tag.sh                   | 16 ++++++++++++++++
>  t/t7030-verify-tag.sh            | 16 ++++++++++++++++
>  tag.c                            | 22 +++++++++++++++-------
>  tag.h                            |  4 ++--
>  11 files changed, 99 insertions(+), 24 deletions(-)
>=20
> --=20
> 2.10.0
>=20

--svclup2bigbn7nfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX/STSAAoJEEaPEizoFiKV5FgP/1m5ROmLUrD1mZFWFkHFv+zx
Oe2RfEtr/F9An2pW+iivMTOPlz8++ERCg/MXkOzL5BPd2txFTBoi66VCLi2OdT7T
XErpQT4opCTsobPRmB7O1k/tv3VOtCD0O/GRgDcdNR4+V8bCscVW7nVPABjYjbSy
QcQvXP1NjEub6Kd0BaK5eHoY10/lsICnRSUf4kkG/NXyQjRCE3E4dmI3zaKoutfQ
KetA4ihvSlCdQywfDBORgXNjlppzsLrcH8/gpx17hRCBWAsC1FqxzKNb69qZ+67M
9UcPRBC88sYrCUofvqipGW4NXpgHB22Y+QURqZxNYVS3P0FPdaBR3qThrLhx8jHf
DeiBPHZ6924UQ59ONVbaGVDmzFKBvYjOUepbOoScW8yDtJI7tQbIBRWEZc1N2HnZ
L13qOOD6TQt/HVDhlWtGqcZPpIdSRHmkUdFUCfTTndaUzKILVI5PIjxM03YkXvxD
x1wdCtNO3QUdiLCqLMPHHuFvVWnZO9tMftdYzUgho0qvhyoh8u5DiMzyx7OCSChg
8+gu3y2tFz/gShsY0XrAZneY7Af3ahhvKQF7VgrcxeuIdW3XfEg97jFENwB8otB3
Rkx9btonE/hd8WGUScMGL2D5p1dqfjL6rEcUfTcsDJMGXgpzGAWQAgtonDu5qFQg
OYfPydU9tHZIemY/8sqV
=Zr4R
-----END PGP SIGNATURE-----

--svclup2bigbn7nfb--
