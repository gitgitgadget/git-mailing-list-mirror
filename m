Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E2020437
	for <e@80x24.org>; Thu, 12 Oct 2017 08:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755204AbdJLIqT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 04:46:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54922 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755110AbdJLIqS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 04:46:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A6BC6042F;
        Thu, 12 Oct 2017 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507797975;
        bh=v5XOF+rRxHw+AtJqyvTAbn5l6Zi2UHuLJ9XMqI5ZdQU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HkiXp2oGTLV+fNpvI9GVsv8mqj/Ql3zmbLgH4eQLc59Es+dGBYulgMrIKCrFzSYk/
         v25+/dz/dfDwmx7fnY7ZQ9PdjpYaFF+H/pYULCIA/kx7VW51M6QBm11sGbg6FEkoS8
         kyjWIYY5UIY3TBD+9tcTZfqHP3XrAKrtYgkZGavF1wZKFkdIUXUi89LJCbeNN34Hlf
         xVzyTjzySa+knV7d0mAhkZ5xT6SJN7Hp3iFunSWGcBRHF9I5qc2A9t88gGQ5Ia7unA
         XxyTL1ky/658ECqklUCrbPSGt43lEsdwIndI9H9CAUgUIUWH59nYQhTD3jaCbgoVBe
         NN+QEuaL7uQDrPrMZrO33ik7Z+SXSVFEg8pdITRMbRQy+j4c7MNlZ7Pk6glp9A21Li
         aL92KWvj0soeb1jq3cuXV1afVd3/8R/lDLKeOiSOMOiull7QmSrL2lBx6TgGJAVROq
         izXCJ51/yjAEu3cuvciTKnKf7VQNxNJSxjd8My7Q4VGv3OakeMp
Date:   Thu, 12 Oct 2017 08:46:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/24] object_id part 10
Message-ID: <20171012084610.slrweolcgwnfgvu6@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <9e44abcf-abcb-4868-d1cd-2326ea8df3ed@alum.mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4wfglgdl2knm3o4s"
Content-Disposition: inline
In-Reply-To: <9e44abcf-abcb-4868-d1cd-2326ea8df3ed@alum.mit.edu>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4wfglgdl2knm3o4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 12:05:50PM +0200, Michael Haggerty wrote:
> On 10/09/2017 03:11 AM, brian m. carlson wrote:
> > This is the tenth in a series of patches to convert from unsigned char
> > [20] to struct object_id.  This series mostly involves changes to the
> > refs code.  After these changes, there are almost no references to
> > unsigned char in the main refs code.
> >=20
> > The series has not been rebased on master since the last submission, but
> > I can do so if that's more convenient.
> >=20
> > This series is available from the following URL:
> > https://github.com/bk2204/git.git object-id-part10
>=20
> I read through the whole series medium-thoroughly and left a few
> comments, but overall it looks very good and clear. Thanks so much for
> working on this!

Thanks for pointing out the places where I forgot to update the
docstrings.  I'll plan another reroll with those changes and the other
issues mentioned about the accidental deletion.

In the course of that, I'll rebase on top of master so that Junio can
avoid as much conflict resolution as possible.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4wfglgdl2knm3o4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnfK9IACgkQv1NdgR9S
9ot+7w/9EKNUBfC92rguB85Yv5NHr4umWcCHYQfFGTe3D7Zg2K5yofufnym6w/RR
i24tg2aSsrh7+UyvD4gyzjiG2fAiilnsmWcP4aatKKNNzVq8b9z303Xj7w+H02rj
ZESXfLRYiTKLhY8wSqwRAT4yrKtfJCSr4ZNDMBoD99Ekmsf4Ty3xPrTri+E9T0vk
2h9sCyMWZMxizQfv6TrMNIij1wZPAoQhoJk3IGOv39EKYjUmR/2m6TY7cf88PP/F
WmCcOmbNMMrnI5qiYjMx9Bv5nLS7WDlNviPjZnzxNBHIRg3izjGasdebFZGSK/kp
FUaVTeAaHNpRjYfXQb7yvmLEn+nn4/fg7PSH7hl0rPhApPMO+I0uUk84R5FY81Ti
icCqHsBb1Mk7na+BMyqBgSv4Y85ljtLaqGM0OueeJ0GLP7VYgmM5bYaNYOL6ht7O
AMKLru775Kmur2py7Djd89ThyLLxfA9Piov7hAZyoA3XSMm9YJ643DQAP6BhDnXH
e9AT0mc8ZGtbgPoidr2agP01dZ16wzwmVEPIbS0rrxdSv3O8ejiTUfrQ3tZGvBHn
IE0zhN3RJkt+G9JsmTkk+3evCKgbTcTnjcC1wpflHRgq3HCS2P75v4fry/tJ4Gvj
0ackn1zNdWZ3vfyHUSEPwjyFuPJ9+hr2KUQnmQdQitgaF3MU+C4=
=6foY
-----END PGP SIGNATURE-----

--4wfglgdl2knm3o4s--
