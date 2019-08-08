Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4A31F731
	for <e@80x24.org>; Thu,  8 Aug 2019 11:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfHHLZy (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 07:25:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728289AbfHHLZy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Aug 2019 07:25:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c831:5a62:6d5c:8da3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 11F2C6081D;
        Thu,  8 Aug 2019 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565263552;
        bh=p/aNSYN4YmlC2m01NZJWSHN9c7CN4aB9FeVZTf6fRtM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EeSK1vzYQdMXaRBP6iGa/yWAyMED/pD2cl+uDi9J5gD2A/U1zAl9spHPYUq1ZWq46
         sXeOf6nnef5MBlAsVQWkASYkmSvYBaq1K/dsE6hjNtI/3R5JymAULC8Qa1YuNTc9RX
         EnsWCYyDtxSNtYQLov+5z1oNnLwEVIRpqnov0nhJ7efhRM7+1nMCJQlBqLib+9fSTS
         WeJoB5G0iV5JPw7pqgFq0Bvm7Z0YyItFI+lvE3UtLCBYyjmRflTeqDUL3o7j3q4wRp
         9Xd3ruJzFcBIDlDpc6efa7lhbazkS0KFo9vjvhYErXv9TcAkRa2MqrCQ3p/irK4SQ4
         Xgem4yGFlNStnWpC9nii49XdOe5Ke8DDhHrH3gkbQczp7gmyBnCE7aMTXxIKwkJt2i
         9XStpvcKHHoaK3ITXQs0MzC6M7cKTMP4qxdrBl+qel3h8SL67H0BEWJxYQ8Kux24Gj
         wfbuC2D/y5HkcydfGYLeq1fz2w3/oMT0gJnT3b0PbSghF+aGmTX
Date:   Thu, 8 Aug 2019 11:25:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bc/hash-independent-tests-part-4] t: decrease nesting in
 test_oid_to_path
Message-ID: <20190808112545.GJ118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
 <20190628225928.622372-2-sandals@crustytoothpaste.net>
 <20190808065614.GA209195@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline
In-Reply-To: <20190808065614.GA209195@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-08 at 06:56:14, Jonathan Nieder wrote:
> t1410.3 ("corrupt and checks") fails when run using dash versions
> before 0.5.8, with a cryptic message:
>=20
> 	mv: cannot stat '.git/objects//e84adb2704cbd49549e52169b4043871e13432': =
No such file or directory
>=20
> The function generating that path:
>=20
> 	test_oid_to_path () {
> 		echo "${1%${1#??}}/${1#??}"
> 	}
>=20
> which is supposed to produce a result like
>=20
> 	12/3456789....
>=20
> But a dash bug[*] causes it to instead expand to
>=20
> 	/3456789...
>=20
> The stream of symbols that makes up this function is hard for humans
> to follow, too.  The complexity mostly comes from the repeated use of
> the expression ${1#??} for the basename of the loose object.  Use a
> variable instead --- nowadays, the dialect of shell used by Git
> permits local variables, so this is cheap.
>=20
> An alternative way to work around [*] is to remove the double-quotes
> around test_oid_to_path's return value.  That makes the expression
> easier for dash to read, but harder for humans.  Let's prefer the
> rephrasing that's helpful for humans, too.
>=20
> Noticed by building on Ubuntu trusty, which uses dash 0.5.7.

This seems like a sane, well-reasoned fix. I don't know if we care about
building on Ubuntu trusty (since it is EOL), but if we do, then we
should definitely take this patch.

I agree it makes things easier to follow as well, which is also nice,
and it preserves the shell-only nature that's so desirable on Windows.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1MBrkACgkQv1NdgR9S
9osG4w//XNKayIZJdN34dhJkxwp3mMKg3nHRpZPdkix+BA2EbVbcGjNrYblGfiWP
H59/EruTPXm4ou5XDzr779zK0uLv7Fk/s0yGFNYzJKODcvK1Gryb0V5sO/2Buhts
Tt8UH97pkbDmp7YkZMDIWjNyNv/w4uibfzw4ZtsnF3FGYr2VAe8RpPDUSmpOBngb
nmZYrM0uJzuEmZgSDLZPLloxu8W3XE32mmBonMdYKxSBBoVmtUXkMFMI8KUf7Eey
z2VuC0EStcLNY2oBQKLH0wTTWF42VnMOOcDEuxao5rvivleSC/+7JjxkSCsVcKaS
8/neDYzwXB6YyrBMn7/Piu2SEXs1jp9VKxoeb8qy1SH7Y4juTZ8Etw2tfR8O4Am9
q0rU4gblIPcjcPSAIXu4HZ/rhwy+Fm1g8MtlympZQ6SvA/u+5vqATYE30xjMUodV
rnwwnTRkTJkx6Bci3WBHJyKA6XDp64F1nPa774fcc0C7YlQ3A6bQZGbsnMHANrQn
1JPp9LwI4T6Y+wqBbPq2bfWpR3NfU2JZGhSkmFZ6nq4+WyjAYihpPEUY5PHQspJ8
tQa4e9WtL5B1P0VBuvvRvt1RE0PoRQU452zf/nP60bkcaXduaSbwopgU9zEVRtfY
dy6gSHNRFIYFbqquvvxEm3AUGXCbNbzdlylAHrs3nntKtnS5Cq4=
=CIcN
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
