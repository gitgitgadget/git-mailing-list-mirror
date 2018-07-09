Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023011F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 23:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeGIXlz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 19:41:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55046 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932828AbeGIXly (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 19:41:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 88AFB6047B;
        Mon,  9 Jul 2018 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531179713;
        bh=ZuvCptSy5Cp/xTEg/NBLD9LDS5PPeTg98pDKMx+V9RA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zWblXRTkocD/aUN1SlPIv9nhIHxZbfOnHBx/py9ictcD2qiwMEOp3wopo4fNnEiWf
         2Ive29UR7e+VaNBJdAriu4so1TPIe5iDxf0bC4aG/rtN597J0IrsMbL4WUE5AcTn9N
         WNvucRBA23oCmrAR46mPkQJ4D8aNThC6pU7a74TKJ3tGYWrpidZOOBgj0x+Akg3C9T
         hgBRs5tIxlx3OZLsIL8XUSlDHh9dKXDLN/3Wy76PUfgiRrxIfvyeThTpcUpyXWLCIE
         L+2ZZTYz3uOAvqcDmGyBkpqFnBPncMtq0mmSZGSB8ecCatvd5qvN8kgY7wk/GKssFO
         wzSbOiI/E8CxLXi6Qsl19vdnQ2/mIAT+h+7+ocd4IIskoOvuwhpgxIc+iFsLZS4TCM
         FRTeJtprjlFBAMb5Ot6TJECNr2blqL++wtS9Eky1Mo+auqVFZP9YcBZHKU2rhUEDCe
         Y4WKT5CSLUQA/2i6oKJqSdFK7oUQChsq3LMK8ER7byWgD6dnC+j
Date:   Mon, 9 Jul 2018 23:41:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Daniel Harding <dharding@living180.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
Message-ID: <20180709234149.GC535220@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Harding <dharding@living180.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180708184110.14792-1-dharding@living180.net>
 <20180708184110.14792-3-dharding@living180.net>
 <20180708210200.GA4573@genre.crustytoothpaste.net>
 <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 09:48:55PM +0300, Daniel Harding wrote:
> Hello brian,
>=20
> On Mon, 09 Jul 2018 at 00:02:00 +0300, brian m. carlson wrote:
> > Should this affect the "# Merge the topic branch" line (and the "# C",
> > "# E", and "# H" lines in the next test) that appears below this?  It
> > would seem those would qualify as comments as well.
>=20
> I intentionally did not change that behavior for two reasons:
>=20
> a) from a Git perspective, comment characters are only effectual for
> comments if they are the first character in a line
>=20
> and
>=20
> b) there are places where a '#' character from the todo list is actually
> parsed and used e.g. [0] and [1].  I have not yet gotten to the point of
> grokking what is going on there, so I didn't want to risk breaking someth=
ing
> I didn't understand.  Perhaps Johannes could shed some light on whether t=
he
> cases you mentioned should be changed to use the configured commentChar or
> not.

Fair enough.  Thanks for the explanation.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltD8r0ACgkQv1NdgR9S
9ouBXhAAv9MLbvzcQwHuJkLCdd1KxcnKbd5L3xaZ9+QkPfZu9GJei6EbxWF2F9M9
SkJsd2YxiZ0o+POaA+4o/GqHNjSLYJwksGFM4IDvA+v8TDjOmp9xTWg6gw0ybUVo
LGpXTt9+24DNVc5i0N8REAyxTUE8lGG1aN0NVHlTfaMW/8XJsLM9kBgdLuo+by94
b3E8fVqZGChzQ+DChCDKEiKQo7cO6uTSaSQUaoTpom9x4y+Dh7YJRpVpJn68grQt
V19iO9iNJmKiuX73XtOdg8vEQa7T3gTE9M+9HWoyVFn1Kab1Ep2l+knqq6ILVXSH
MqWV137ww7KqVIv0D7IckQ2F4LQkrj86QK+tbzoiWSi18ODDnPBFzur/dd/omQ9z
zG1JW6WYlejLz9JNerI6MhEbYVcXvTkTed5aT+kw/pzvFzNJjuL+zBpr0IwjoPtb
vlwrl8WE3A2uycXI9Dq5gUDYWnStgUGaCxX3E1g7Zkln73wZUZBhx7+vIbJD61pm
V7xDIyKWNlfsk9+G1+Mlqgl/ymXXi+hdTbGzLepV0sItHF0/iRLfGeBnDzv297kP
RUuA1jyhK9RO/k3VtmpUDzY1aaTOPceNRkhvBCBbyWuMRFlNpBT6rUMe3onLgDSX
rYizFY9hw+vPm8GE88RsSG9a72rl6VOqm81vo3vFzVBNpuGpmr4=
=OENS
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
