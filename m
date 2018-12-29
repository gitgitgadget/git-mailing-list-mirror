Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100F91FAE6
	for <e@80x24.org>; Sat, 29 Dec 2018 23:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbeL2XRt (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 18:17:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58084 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbeL2XRt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Dec 2018 18:17:49 -0500
Received: from genre.crustytoothpaste.net (S0106ac1f6b61f856.vc.shawcable.net [50.64.113.123])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5730C6042C;
        Sat, 29 Dec 2018 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1546125467;
        bh=WxwosXLZaboeFYPO38O5Z9fKAB2WyaR8RpfUL2EmsNs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZOkHB3L+mj4PuEkaIa9BFOUoKLy9pqg5WwSEpY+xkbTJafyDISuwlEq0hDMktMTra
         Tr3zJMntClNq23OO7dEAsVxLbKUTOPMmJLlrdoMoVTr/xwURIa1ZCxRxj0mV8QNCR+
         XgVjJFEsFo5NXcFaQzLkGEwMmh/z9WE1UbK43O46vrvqnblCbqJRdncM/WRMHaVepY
         pxNlccWSTe59kQumE/TeRJJhFSlDKhsNQwpqKQ3Td1omT5pnIG2uNbkM++J6e/qkLe
         q1QPbBgr93Q5+zuhaz+jIUlwDpUgkQnEq2iWsjlz6mpEOFcFc1/q/dw8ANJCYCivX0
         KKh7c6DkEN1JPeceizgfkKdwqY0B2ChSQE+7AXsnxI6xDyGwCP0QA818ZEoxX0oq75
         feghYDIe/ZTsPNrSnvZnTMzaEX9LTSdf3ayfXsHCoP3qUn6yde/6c+fxoHBAbL1DFr
         UHnzoBJMi2LuQq0LDIFwJWJR4BP+IEGQYZWEBDfYezYxzklCuGh
Date:   Sat, 29 Dec 2018 23:17:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
Message-ID: <20181229231739.GE423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
 <87lg4adoo5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <87lg4adoo5.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 28, 2018 at 09:46:18AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> On Thu, Dec 27 2018, brian m. carlson wrote:
>=20
> > We've recently fielded several reports from unhappy Windows users about
> > our handling of UTF-16, UTF-16LE, and UTF-16BE, none of which seem to be
> > suitable for certain Windows programs.
>=20
> Just for context, is "we" here $DAYJOB or a reference to some previous
> ML thread(s) on this list, or something else?

"We" in this case is the Git list. I think the list has seen at least
three threads in recent months.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwoAJMACgkQv1NdgR9S
9ov5UA//Yh1cTKXYcnn7/uXdEfFgweZ0dy8mQBbKaGpfp2YlNWj9+omsVM0R2SWk
JJPNITAEcd0tgfZ8BtHq0p4vclpXBGgvKJ3PmZdpdnlL2wI8hMCNny5xHL1swYw6
plq86/jWeEQm43PLqZAYif6PEf+hHGUjVMEdv3h27udLiAC71U5wneugpTEL3oCF
9YSKdphWMa8DSW2ahQMWU3btYmEuNGOGH3hbrr+RdfIrM0AUiwNLW5yCMO5nMnOr
cQ0FeliVAVHBVgF2uuh/tuHpP06zmu1KeeF7ZAm/7v5g1qmDS9iKmx2ZZvgNopso
rv0w+ny/hipIEQWe8wkH0dM1DkPN9+nGMn1uHTvnM/+mWzqOTXwoD1QMLnNwqDMl
0WLmyQg4Jrjw7ZQuCJQp2/KvjCg+yX2Dad02nipOXZuBQWgT1Himwd9Ckaq85z6b
/Fr5+t+CMkkDt+Zwo3xt/cUo6zl8nlQNXzH24z/aP2wBCWHssAjuD6+9GDi9cfJ2
fZvzgOdi4duAbFvS43A/2u2qxvU/XGBuSSzYcD4t9hrbnE/JSHep+4/cdEuQEcs6
x5Lq3LHq8+ZhMQrPU+RgJ7hkQPQekW7chVyH1VngQKC9qPVnDiUkjPWfgrvfQcL/
tE3gBxTmUqz5WaMyttU/xuB2S3wM8E2/xm0+zNxrWt8F0HGR86A=
=ydt3
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
