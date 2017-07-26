Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2922047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdGZX2o (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:28:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40270 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbdGZX2n (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jul 2017 19:28:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7C592280AD;
        Wed, 26 Jul 2017 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1501111721;
        bh=naIQvoaN7O/HPBcFGhfOeaeME92apujyEZbL3SvUwBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5QW+XqM9KmRF1CNGWAociizcUPJKpPlFNG+DSw8c7Jhm2Z3chUyHtF/8gLzG93VA
         YsHvUfhrQBKUsPe9gQbBMTMAPc9Pq8NDp97nvvGUj/Kvyl8onUhxdEpCD2tKPoO5aO
         9XYDhTIzFPeN6oUl9G3W8PDLF2eXg0nqT/Cxrbs4lZheE42eSNKeaiU21EGpn7Hsj8
         qPMPEv/gpHMvZzIWlrgkbiAmv+Ejo31f3FDOpkr4KMgn2/2bHbcUr5OXJpbYlAZtT4
         31ZgF3ObiDERTq36LEl/Q/hQCFKZQspyHel02Ld6kxU1w/Dpcjx25o/sTOR4+xucQ3
         JuDgjfL+dS2BnHMPZylG7H1TyllR8ZRgwqH5mLlqxZX5TG+5vsl0dftELAY9OlAnmP
         Xv0Ne7Drw1nbBQDRbx9/W4C6pMo7tC8AeO9fOGmrwdrDbYIxud2T0xCBd9zhLJaAwV
         /bGIfs4pZoDoI8EYyaQCIkOwuVgU7tdzCQIw7Nwmjk5baSBRhel
Date:   Wed, 26 Jul 2017 23:28:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.14.0-rc1
Message-ID: <20170726232836.75arz2glmhnzwlc3@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmv7tbgl4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opihrpwu7d6ke667"
Content-Disposition: inline
In-Reply-To: <xmqqmv7tbgl4.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--opihrpwu7d6ke667
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 03:44:23PM -0700, Junio C Hamano wrote:
> A release candidate Git v2.14.0-rc1 is now available for testing
> at the usual places.  It is comprised of 708 non-merge commits
> since v2.13.0, contributed by 61 people, 14 of which are new faces.
>=20
> The tarballs are found at:
>=20
>     https://www.kernel.org/pub/software/scm/git/testing/

I noticed these tarballs are signed with SHA-1.  Since we're working on
adding additional hash support for SHA-256, I was wondering if you might
consider using SHA-256 instead.

This works all the way back to the GnuPG shipped with CentOS 4, so there
should be no compatibility issues.  If you're using a reasonably
up-to-date version of GnuPG 1.4 or 2, you should be able to simply drop
the following line in ~/.gnupg/gpg.conf and have things work:

personal-digest-preferences SHA256 SHA384 SHA512

You can also change the order to suit your liking; SHA-384 and SHA-512
support still goes back to at least 2007 (CentOS 5).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--opihrpwu7d6ke667
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAll5JaMACgkQv1NdgR9S
9osELhAAp8tYx17TIL/gLAZuxEEoIlO6cqvJ0PQBWaANnHd32M125vLVLoRfq2cF
jtSKqDt99D3thJtzjOQJAh6Fu8THRKblG5Z02iH/SLfl54KtNPnBT+z6SI9L1k7Q
RDaOaAsg72SxS+ELF+r9BXlvuXJvFjM+koaPfzWT6lQUh+8zLG3fpW6QCrddtYZ1
MfscmRDy6xoA7NhdvMYNL2/2u2BkI1zIfFOd1LS5Bt1/NMeeulgQjR5MDif35wck
3x5LIn396UtMGoM9qguSK+ayYBfg+nsDdP5cg2yR/d8YgFnH8smvccz33piJjH0t
FuPgDM8Ca6NJWbAWNPG9s2vStC232F4odOxynWF2rNlvZfpyIEHTkv+6Dlp+uTqX
UBg/4nDPJoK8ASlfW30cxWwlmxxpDGhav48M0UBta3pWIOYiaY/1EsYQWJGTope6
rDBIwP2GUJBiMxvha8if5udd2X9EEPj8OQgmnUSO0u/m+mR3lk+lUetGnfD13nrR
0tb6vJsT4WFA1mH9B0qW/vZ/baT8W5cCo8SbwXCTqyChYX7hxuQ0v8aKeWiNokEU
hnDUzWne68LyQy7gE47RL/JNBD87S9don2Uze3o7AJT8SteD6uuONb/XhbDs8aSm
Na6RKixnVgPpFx/IqUWvmFQmzohOFpQjVWWD3jSt6DtyN2t1+F8=
=O0kb
-----END PGP SIGNATURE-----

--opihrpwu7d6ke667--
