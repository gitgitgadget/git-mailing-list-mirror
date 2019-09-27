Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8AE1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfI0XHy (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 19:07:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58918 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfI0XHy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Sep 2019 19:07:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B7C7F61C2A;
        Fri, 27 Sep 2019 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1569625673;
        bh=Xqga4eHwH7fPHVeku1c1q2Q+aqlXJuaKLG8tV3aKwS4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gcGclRMsfFjRlv+BYHxUZljxKDTpRHQ/xGJIdyFqdhX5vdXEjQFkGxhBvzR4ZEprM
         78/LgmaBNwDhYA432h9PZRn2YstaZki+o8Stns400T63fVWAnaaVahJdcQhxItWDYy
         6zjI/RKRxpYKJETfM3rJCYpNrlmAao1f8aFK76fbDNumqzSMHOF8yQVmMoG33u+/CO
         X12xirZfMYxIkuyFA39Yi+eYud3j5oOSehHWh9h/AXpiWZpEEwwt7VpjLdhqJWkFd6
         lOPxs7jt0IHpDfhb/Lz5YUM86eEUp6F9A316FSCB27DMTOZFw7ceD45KTctkIQZ7LZ
         KqTHqWOgbR8WQVOSyVcaqsoU6KMkuxvRpCSD9vgFTIOrDlhxKLP+j7wTKK27bsiQbW
         2s5svUX17SLY9Zng9l3a4liFhilCLfpmupvCd8LHEl4pFkaBDrBB96QPuJeJrLjzcn
         pMYr7q7HFbsPCwA7QiUJhx/ybq6C+DVCxS58sgomQDwYcFvVgUA
Date:   Fri, 27 Sep 2019 23:07:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ian Kemp <ian.kemp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: different exit codes for git stash depending on
 whether stash was created or not
Message-ID: <20190927230747.yjdeaen34nnpcchy@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ian Kemp <ian.kemp@gmail.com>, git@vger.kernel.org
References: <CADZUK1cjvifbFYk9w6+vE95jgEBuwjoOi_1QfZHoPFBXuXHCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fjbfzvtwulsamq7b"
Content-Disposition: inline
In-Reply-To: <CADZUK1cjvifbFYk9w6+vE95jgEBuwjoOi_1QfZHoPFBXuXHCCg@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-rc5-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fjbfzvtwulsamq7b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-27 at 12:55:27, Ian Kemp wrote:
> Hi,
>=20
> Currently, git stash's exit code is 0 regardless of whether it
> performed a stash operation or not. Third parties invoking git stash
> are therefore unable to determine whether a stash was actually made or
> not.
>=20
> It would be helpful if there were different exit codes for the case
> when a stash was created (working directory dirty) vs when a stash was
> not (working dir clean). git stash create suffers from the same issue.
>=20
> There are various workarounds for this e.g.
> https://stackoverflow.com/a/34116244/70345 but they aren't
> particularly pretty or reliable, hence this request.

Folks have already given you a link to previous discussion, but if you
want to know if there's anything to stash couldn't you use something
like this:

  #!/bin/sh

  if [ -z "$(git status --porcelain)" ]
  then
    CLEAN=3D1
  fi

  [ -n "$CLEAN" ] || git stash

  # your operation here

  [ -n "$CLEAN" ] || git stash pop

An empty output from git status --porcelain is the definitive way to
know if the working tree is clean, which is what you care about in this
case.  If you want to ignore untracked files, a suitable grep invocation
can do that for you as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--fjbfzvtwulsamq7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2OlkMACgkQv1NdgR9S
9otIag/+OEQyuEqqwPMZLVfKQTuYRLdOLh4zFTrviFzEKiizKIBXZx1khyFxLouN
d+MDTUmVbm//RJR+eHR163zEMMC+1httf4Um6OvbOBtDoxG7es+n5bcZzvy+385h
owv2dD2GszM9O4NTcJWHmonelPL7dhPw9SkrfMNRmNqKDg6z8PvcFxaylICJOeu1
pf4W7ELZXW5lpeYdOCnO0xreb0e2Xkrsdqg+2q8MDZLN0Aub8y+lTQB9nltafW84
2IbSGlH2LofadT/IYGSeu4X6OpcmZwoF0KA6YhcANoqfI53SPU90pvfVa+faax1/
fMMsMEZa3Yw27diAP1xLjdlocvi5j9keyg+v3PFSvH72X5juBcKoUX2pUSsT62ek
55WHr093N730cU+7i8gNwe8AVHk6bVmqNp5Ji+S6swjrRazimYm5Wxibn3QQzl3t
Xqgo39Jn6OfmSuDUtwumff3jjLOJE1zxQjYRtSVV9RLvux45ymlAen7TXcHCRf6z
MU/+5vc0fJDD4+LdYw2yDd7IR3TdvJ36/E/7eghST48Pj5Q0FQSmdB8z8qz8UMNL
CxHw7mKuJ9oSD3AV/gP9vSZ9z+vAnWzL2QpCXtQtXsd48hGDFrwMmDehEepwR/lg
WxkEarqtZS0gyCDTVsUw5vY47CT4lx25ARrtnFza3o/vg8q4dcQ=
=x3DE
-----END PGP SIGNATURE-----

--fjbfzvtwulsamq7b--
