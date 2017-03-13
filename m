Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA8D20373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbdCMULL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:11 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35957 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbdCMULJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:09 -0400
Received: by mail-wr0-f172.google.com with SMTP id u108so110971361wrb.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eLTcRa+dKM27BdTD+qL5j9cCH+O+CdjmDAcrWCPqyME=;
        b=XtTaei2E4dDKDsb8tKpWaaqz//vY5otxu+gbfxkHKp5SSLTkULdW9AAQeXfm1TCn1Q
         P4qckTSwzjs7A4FK+C1FbMZN+zi0E8mxVVogGKYRVfPhv9l65I8Hf7FaX1aqooczr4y6
         rZKTdUcA5iLZToxvntw/MHBXugxLpbZ/zNG500k93MR/nMArvdJVVqx571ATz7KZKTSW
         HqsIkUVMFAKURppDCCnfIs9Nn55a7UKFwyyj0GBNRQtRVO1NkMy5+4LHNwsWNWxxboEk
         VeIJaeh1QGMjywDfVqEI5kcKyynzjp7yk6ZfiLFcaMuL5q8mZSj8jY75xuMwVt3MGd9c
         DClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eLTcRa+dKM27BdTD+qL5j9cCH+O+CdjmDAcrWCPqyME=;
        b=CgRHV573LhO7qYGLdD/mGBvR0VA0TZx4szXVteARrJ04wGt0rgqehcJ6gX/8OwdWDa
         8AaB82g4OibFh8M0/K3Mv2+hIwTFpestxVPV1Ovxoxuf7kERbTfGeIAZi/suoC+rocYE
         9TT0gnAcBOyTgM/2ewwH/RkC3nfNltgz0PMbCqO/1bSb+rGg10O85POvie4zOeq8TsDQ
         lMZPp5xmPK0fJiBZG2hGBcLXA/pl3dlEjOyjMgbLm9+FjTamhtO9bqxa50Rfyprf+y9O
         SQ4dHyPvmQRtCbs5lhSJsU67vwEM8PV/3dcUgLYUxpJCDFCuDkO6hdGHQXOYiPZ44v1Z
         H9IA==
X-Gm-Message-State: AMke39loLaHhKgKsZhussan2K16WiEjfFnu+Q/t0lteBF/V/6pAuiUiDNQeR0Ss/6KrKsg==
X-Received: by 10.223.143.14 with SMTP id p14mr27678692wrb.120.1489435867274;
        Mon, 13 Mar 2017 13:11:07 -0700 (PDT)
Received: from workstation ([213.149.51.172])
        by smtp.gmail.com with ESMTPSA id v1sm26188284wra.65.2017.03.13.13.11.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 13:11:06 -0700 (PDT)
Date:   Mon, 13 Mar 2017 21:11:04 +0100
From:   Domagoj Stolfa <domagoj.stolfa@gmail.com>
To:     git@vger.kernel.org
Subject: Possible git blame bug?
Message-ID: <20170313201104.GA32821@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

yesterday I came across sort of a weird behaviour with git-blame. It would
appear when one queries the git blame on a specific file, such as:

$ git blame <file> --since=3D<year>

it will blame the entire file on some commit of that year, regardless of the
fact whether the commit has actually touched that file or not.

This seems consistent across all the tested systems: FreeBSD, macOS, Ubuntu=
 and
Fedora.

An example of the blame can be seen:

$ git blame tcp_output.c
cd0bc69e2fdd (wollman  1995-09-22 20:05:58 +0000   29)  *       @(#)tcp_out=
put.c        8.4 (Berkeley) 5/24/95

compared to:

$ git blame tcp_output.c --since=3D2017
^e19f2a27ed8 (Domagoj Stolfa 2017-03-12 20:43:01 +0100   29)  * @(#)tcp_out=
put.c        8.4 (Berkeley) 5/24/95

$ git blame tcp_output.c --since=3D2016
^e4bdb83e76c (jceel    2016-03-13 19:50:17 +0000   29)  *       @(#)tcp_out=
put.c        8.4 (Berkeley) 5/24/95

$ git blame tcp_output.c --since=3D2015
^d749a6e6c70 (pfg      2015-03-13 18:42:43 +0000   29)  *       @(#)tcp_out=
put.c        8.4 (Berkeley) 5/24/95

Of course, specifiying

$ git blame --since=3D1.1.2017

gives correct results, as expected.

The question is whether this is a bug or not, as --since=3D<year> might not=
 be a
valid filter. However, this might surprise a lot of users and mislead
development. I would personally like to see this behaviour changed to eithe=
r a
blank report, a report of that year(making it a valid filter), but certainl=
y not
blaming it on commits that have never touched that file.

--=20
Best regards,
Domagoj Stolfa

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHQB+y96lmmv+IXofwxT+ikb0YU4FAljG/NcACgkQwxT+ikb0
YU7qGgf6Ar7IAIzLgEONy1uaW4O44J8UUAnp8D6FpcRs+CByO8Y9RQlIazN3o9nW
sk2P5O2H76syjolj+fIADPmfm65KEZFc5wUiwBtAwM4vXqeTntb3vbiKsobxzBaT
ijUtcTsdJ7jZIsCefbzOyc3jIpRtJiCIG3fs30GLOxueQpGKtOfew3m1KDk1iuqD
pSlL6miQLzIACbw+J/cSR5VdRXlW5YjkdwgswIkVjA5LGVbQYOX3DMXr/z8Mt0Cg
b3unbbgnd/hLX4G7AmOxUAHeHPbMCcdDUA6zZ8hWJJ52LYUGfJcsQhdg058PTPk1
QpfQCl+pB3KK3RpbwXpFrs2D5jStlw==
=ZQEB
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
