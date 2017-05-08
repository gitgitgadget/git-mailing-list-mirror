Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FED71FC44
	for <e@80x24.org>; Mon,  8 May 2017 23:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdEHXcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 19:32:32 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38518 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751087AbdEHXcb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 May 2017 19:32:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6F156280AD;
        Mon,  8 May 2017 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494286350;
        bh=xiI7Aa0KgSzrMPQ9crmkeOC7fULRuz3FLD7xcGfCepo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKGP80Ehs7w+6mRo0rDBrD4/sOV47v53G7lSfUlEYm7OM3swVI5UPw3VCJx59fors
         ko1WRZnr2YQT1ag4UJ0IWaavCUBO7JShVX5vLB/9cYek1H5m6d9fI6707HGu7om08n
         KBtUNkGzrSDMCLuA7SwGVxflRCC+6fhUtvHM51sdj/n1AQrKgJr9S/qWeDiFgG4SBF
         05MOnE7dXnIRYJFPQi0vBvKv6E0Gc7eyUZUNN/wArazvxSQulgKzTwC7300smS2qua
         1rVv6nZhQygKrCVy55SFt/xeXHV6XMKy+ytIcaJcusQkaswA6GOpXCdc/jQZftalhN
         o2uYYVTJ1U0bft8gXkpwQ38SISztY0qUYAs3tMJqjgwdxCmxVUSVK/Q02qn/7T1mxs
         MFwUYOPnYgBBTwH3qj3/7H15XTJgj997COdsyWr73F1zoOMS83h+qUpJLo+7oWZo8s
         ViAwsLMPvZEnbPuIpeby+X7fpPJnLyRfiLz1IEpMMHNeHaPy4sD
Date:   Mon, 8 May 2017 23:32:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
Message-ID: <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox>
 <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox>
 <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
 <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
 <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
 <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j4lo4xizveilugtw"
Content-Disposition: inline
In-Reply-To: <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--j4lo4xizveilugtw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 04:10:41PM +0900, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > This won't be in my next PCRE submission, but I have a path locally to
> > simply import PCRE into git.git as compat/pcre2, so it can be compiled
> > with NO_PCRE=3DY similar to how NO_REGEX=3DY works.
> >
> > This will hopefully address your concerns partially, i.e. when you do
> > want to try it out it'll be easier.
>=20
> Eek, please don't.
>=20
> Until pcre2 becomes _so_ stable that all reasonable distros give
> choice to the end-users to install it easily in a packaged form,
> such a "not a fork, but a copy" will be a moving target that I'd
> rather not to have in compat/.  IOW, our compat/$pkg should be a
> last resort to help those on distros that are so hard to convince to
> carry the version/variant of $pkg we would like to use.

PCRE and PCRE2 also tend to have a lot of security updates, so I would
prefer if we didn't import them into the tree.  It is far better for
users to use their distro's packages for PCRE, as it means they get
automatic security updates even if they're using an old Git.

We shouldn't consider shipping anything with a remotely frequent history
of security updates in our tree, since people very frequently run old or
ancient versions of Git.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--j4lo4xizveilugtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkRAAcACgkQv1NdgR9S
9osG+Q/8Dzt+XcxuG531NINTfV0NlRBaDvmNIJQS6tMFe92n3esACosBvfmDxqzB
jl4KKjEmpYs0RvXVaVjiCYP+8zkzpYzpHhZtyWv+x33dCutjdmvkLJ8rtBlwsAzj
kxlhrZ6DOqClpURLMGdYlbn1I5qUfsAeQFKa+OLvY71OrFQVn2vjaYRovdyIQq2W
9+NyxF5zKPB+JzHEfcqMmSWZ+t2tyhGT5lubdTmerrfcifZUhGbXsqo1FSk+0yJy
OpJGwO19nwyyeXk7kSxWQcb64jui73y4lyG/S6MzMST8r7yElJtmDyhfU3mpK83t
rIGl0uyHOCd3VEQsb81+Hyzv0OcZ2xSAPNWIYdZRkDsK8L6l6E0/QTBtKRYqzdra
66jojoSmoDNpi021zAwPEB874dTTXep7n2PEtW8aoz6RGVTGny/X6XID3dBRj2u4
ZtrLEI61w3kh/nrQK6+8gLNaGEmMLxAv88HaEJbro+6/QeMJcCDEMlFN1LzBXvjz
KUOXtSbBVypwVKGLOpdVAqp1WiUT92hppnXLEKwPzCUeXX8IHalXZNym/GqEVi/6
fBIoXcQIrmhQeyfsstiebNVK5q1v8zBNyVhtKgD2yqqCmI4x0ZnOTPD35l+tInqF
iQO9TnxQNGZJ3Ou8Cm/fkRiNzgn7otA5uQKJCHl4VM5VZWLZr7U=
=d2Qn
-----END PGP SIGNATURE-----

--j4lo4xizveilugtw--
