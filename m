Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755781F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 01:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfJ2Bj0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 21:39:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55212 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727931AbfJ2Bj0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Oct 2019 21:39:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2F09F60443;
        Tue, 29 Oct 2019 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572313164;
        bh=qRCnarv/GrUj9V5mn/zem3l2zNaFb+cQ8glvsO2hfaM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lmWI4XYYFyKDHk+qnren3O8TfE4jJSQBTJwyUhI6m3Bwh7Q0juWqISnwBRJRnnK/i
         f25lZoATGpbqqeEEDxZo1zEzgfvw6nwNy6/GFTBO4kmNrVVkpe6+DLl/XOv5uABpMl
         dJnvU2JFh0YcZf3r9rkmrPL+7REM44/wBS1gSXvvYeRzYDO/BIovP0j5GvfXDP8wL7
         s14CP37VH7CTs+enFayiugAXUhewi/nJhGx/iFU13eJpH8HvInzd0k06ZdGzXr6NyL
         RT/fBiEDHzRRr6ktJpjXbAv8tw17yJTTglYJMtl8edeZvotMtS7eNjN/fU+HNaWXVa
         mdqZ0k2qafxDBKc+alhyLvKrJAiYWBVjpe9bD2W2QXufjx5mKlwLhQGKQ0RDfVpIak
         XRq5jrFey1VutPNS5NgdYg1ITDV/zH6AvgVXpg2jI8+UggHJQUsKCzQFF5dn4yDIoo
         Ymx72uZ99HtWOFrrMQlkLZ6jgy651kfgUCc/df4QU67u6fawrvX
Date:   Tue, 29 Oct 2019 01:39:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 2/3] mailinfo: collect commit metadata from mail
Message-ID: <20191029013917.4uow3iuvrzwfxges@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20191022114518.32055-1-vegard.nossum@oracle.com>
 <20191022114518.32055-3-vegard.nossum@oracle.com>
 <20191027184449.55pk5ga4cjxaxpej@camp.crustytoothpaste.net>
 <dd71ec21-5e41-1781-5d5c-f37f7f019fa7@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rhrba2mlg5q7n2hl"
Content-Disposition: inline
In-Reply-To: <dd71ec21-5e41-1781-5d5c-f37f7f019fa7@oracle.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rhrba2mlg5q7n2hl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-28 at 11:48:14, Vegard Nossum wrote:
> Hi!
>=20
> Thanks for the feedback.
>=20
> I rebased on your branch and ran the tests without any problems.
>=20
> t5100 is fine for me -- the file above is only used for testing the mail
> splitting algorithm, so the choice of hashing algorithm should be
> irrelevant for the test. That's also why I chose to use a personal key
> for the signature, the other tests also use pregenerated emails to avoid
> testing the email generation in those tests. (It could be useful to
> include those "historical" test cases, which should still work in case
> the format ever changes again in the future.)

Okay, great.  Thanks for checking, since it looked like we might use the
commit data in the buffer, but if this is only for mail splitting, then
I agree there's no problem.

> The other tests generate the commits/emails within the test. Are you
> sure you resolved the conflict in t4150 correctly (i.e. leaving out the
> gitattributes test at the end)?

I may have misresolved it, but I've just rebased on master and the two
versions of t4150 (master and my branch) are now identical, so hopefully
I haven't regressed anything in my new version.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rhrba2mlg5q7n2hl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl23mEUACgkQv1NdgR9S
9ovKjg/+MMRhsCjBqQe21GPMmbEWUiZ1kWgV/MKLqBxekHV0oQxSR/sdg4mXLbgA
y9Wrq4sWy7LvlFZ+i9tuHjhZu4iM86d79fUYxsfB9/4qsK9PtSGCLdgKj/A2wcGE
+eIxMZonsN7DtInolprGJvY/YaHMtZE974Sh5Pj/mnyrnOM5DzSujO+yIz4Muyha
Guj1gMjRCem4bsqRdCPevbJw15tjD44HNtawiToU2H+cgyyccsiYBGZtRuyGrewc
OfUt2DUQFUOOGlhciFiiMSlcz4rWBlyXOuTkIgv3rQOh7vDONLY8RfQ3L89PbTlv
keAXRfBJIcOBPXilNRp6uqUAFgtAMahaokdY/R5N8T46SmFGCkGB+hhfKJSBwDT6
BQE39f2ngNXBT/0x42g6IYx9oIKNub1z7oQTwVyu+SOM31Hf9vuY4xZHna1KdcEk
AdY5k4H7mowcKxJ5ZGRjJG+EwR4ZDJ3BSJEVQJLeHW77Npz5CyJC6vYC/Se+LMkx
aE/0wzTRepsoTbFArTMO07dPueWUTBBF7po2P1IBxratf45x7HHhh3QhUTUqTgDZ
xxkIWvODeDi7cigDb+sIgNbRxDOhnxOzS1fmQQ01LLkukTKqq4DuJah1+kd8I8eZ
iO8bUgA42T/u3W6bWZoEydeKmKGAWRttR7VLc/H6vATQyu2esys=
=Zy0z
-----END PGP SIGNATURE-----

--rhrba2mlg5q7n2hl--
