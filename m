Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1741F453
	for <e@80x24.org>; Sun, 27 Jan 2019 01:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfA0BwZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 20:52:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33412 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbfA0BwY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Jan 2019 20:52:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A0611605AA;
        Sun, 27 Jan 2019 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548553943;
        bh=ODbnY1ZyOLUBIERZ4CMyHEp6QXeoPMMzY3/FYw4W16o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UDMD6WVmALaZi/Hcre7gG7IsuikKN/WTPJ2nW5zVtl5/l0+0ctQwjOflmo32WKLrK
         v5oAXnkWWKMBlGMjETsm3lUBBBRf/SjSsbPi07rDIR4FGnS76ygTy3tp+8ifBFGAVP
         KYw5Z7Vv7tgzXgGa/IYgM0oXYf0tHySofJXBGOcfc8Q7pumarXzAx/HlK7hL62e/dl
         ZKFbGQC6ldZPYgd5hD+124yaQMgcpdmN+zmmD2lv7WaXJl3435PGH6758lD+2N46YT
         VU90YIB1EmXYWD64HvWhWg9KPNTXSvXqDALRO/RHB8n6hRs0dV1lekaQtH0j5wvS+X
         VC95ivaJ5hAJpqLwLJPyKjkHjLKKwGdcombt5WmEmpK3fRrzXHksVL/ZLxwakL3Jb1
         uv6kwatx4mSi4r5jZS6gEFpe8xoV6mUO6XFrPyBAhD0/GNwUovmIxv79ij/I70WG1P
         7uvTwdaBaCIyp/sNmvau6bREfCxTF2csDwxMYUdSRMUbOiaW7nm
Date:   Sun, 27 Jan 2019 01:52:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] log,diff-tree: add --combined-with-paths options for
 merges with renames
Message-ID: <20190127015216.GX423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <20190124164654.1923-1-newren@gmail.com>
 <20190125165416.17473-1-newren@gmail.com>
 <2f785c2d-161c-b6a3-7743-b071969d60d7@gmail.com>
 <CABPp-BHTsZBO11ykfTaZ_dzpvrww5D3A57qBM05EgP_wK-iM9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ywUhQCikZ2Y3PNw"
Content-Disposition: inline
In-Reply-To: <CABPp-BHTsZBO11ykfTaZ_dzpvrww5D3A57qBM05EgP_wK-iM9g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0ywUhQCikZ2Y3PNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 09:52:07AM -0800, Elijah Newren wrote:
> On Fri, Jan 25, 2019 at 9:41 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 1/25/2019 11:54 AM, Elijah Newren wrote:
> > > +test_expect_success '--combined-with-paths works with -z as well' '
> > > +     printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 1006=
44 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e=
4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\tt=
abs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
> >
> > I'm guessing that you use printf here because the
> > 'cat <<-\EOF' approach doesn't work with the special
> > tabs? Kudos for putting in the extra effort here for
> > the special formatting!
>=20
> Yeah, I didn't know how to easily get NUL bytes in the stream without
> printf, and once I was using printf the EOF HEREDOC no longer had a
> useful purpose.  In the first testcase, since there were only
> printable characters in the expected output, a HEREDOC worked well.  I
> guess I could have just used printf for both testcases, but having the
> literal output shown where it's possible for a human to read it seemed
> like an advantage worth capitalizing on.  If anyone feels strongly
> that I should use printf for both tests, I can switch them though.

I'm fine with the patch as it stands, but just for future reference (for
you and anyone else), we have functions in the test library called
nul_to_q and q_to_nul that convert NUL back and forth to the letter "Q".
They can make it a bit easier to write tests where we expect some format
to have NULs in it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0ywUhQCikZ2Y3PNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxNDtAACgkQv1NdgR9S
9ot74g//dPYMO9a3ldUSgLrIk/VJBNGTLYkfk3pkWwkFuu3W3DfHaMD6L5ycJUM9
hbTHmCmHQek0cyVmrP15Jfttim+P2GGhcYcM/WcyZIUwhaG7GmRLg38cF/ARgyf/
tQB+p6LPeRYzAGqJ/yF3a0W0gvqVALokHhlMAz5SnU5xugXG3d4WKVgP8b+7tIuW
yGie2qbqvPq0QpNSZNIT5GDJIsMADG749es1t3gayDmPvh+fjBGTGo0w3m39g9sh
rKWSVJu83Ju2ARIo0FTzOMvoAHPnKFaVCNQdgBNqJNQISbdwBvzPHtX3dAlxt/4w
BB68J4tCFhNMptNxw7gnGwM0icwLVmj865F2as1iS5Qscd6U8wP2liKTrMZfGDXt
Zy0JOxvMcZLvWctrGAkNCqzXMi9Q0DckDOGJOgidrze1Nnty6tgLh+dhhHHw6UdO
uOd8KsnICVEMlKE0EzYUiti12mXcwXkhWIOptyg1mn2teSbxBuhcQa4eFKPiJRMC
gWLSWlhSzmQ7uHXqiD0ndu3yscTTkymP5cwbh/MSs289Ucx3FDh4u7Rx01l+CEuV
oAemWdntM9c9cqoXvxk7ViAYPaWzJNY+clGWia0kK8f6u3wSK1WOoHYXxygf7xLU
o5PHZ9u1NK+SZbUno7/ziOqOvf/Z8jvKZlWq80rLwKWAvbSEAGw=
=FUSi
-----END PGP SIGNATURE-----

--0ywUhQCikZ2Y3PNw--
