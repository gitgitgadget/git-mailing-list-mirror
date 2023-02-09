Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C4C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 22:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBIWbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjBIWbT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 17:31:19 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52856ADD1
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 14:31:16 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E8A8E5A1E1;
        Thu,  9 Feb 2023 22:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675981875;
        bh=QPbEVMj5tDbgLq/e8xccMSEOBZSoCIavApmphyjZVik=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GFVFFb28O/3b404KAbwcYyPdaEFfnmyMWYhSPuA3fd96v9jSrlLHNdhS2KJPUZCO/
         arI+MrYbhqCQ2P3HUH/ypNezJJTu7OV7MJNV5LcR3+3r6udznzILkYuraxbhCW3Jtz
         FAV9eWT354as744QmoY9wJp8PwWGvphMg4kYD4Pa7Ns2mGuvlfxzU2EE+LPiF3qEuV
         002QQc+UU+psuSMr064wrRyMBI6qVD6QEW9lGywxRTUE8jdrJ7FVcFXa7rEgTJ6SZC
         BGZYss3q7kqLufVhGCx8C0Dvr+3/I/akqJZFV9vZcp487K6Y7SInmk2I8wiGvwYjmM
         aaXy9WxOzPrRPl2/CpAKJgdz02F6PMkmFVMLjNwsR9emFzx+Vhn6Mfjl1+NSudOq/1
         HK47GC/9GR/Ie42bGZHu+PE1r6L10c+BaTRFKgbPxHH+HaDYcHFxT0I9JOe3Vg1a4M
         sGdMR/g5V9o+3hfS4k/k8loTRx/9wM7upclk+OzbbqkIVD03lnq
Date:   Thu, 9 Feb 2023 22:31:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Rienstra <mrienstra@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Markdown release notes
Message-ID: <Y+V0Mu/v/FO5318/@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Rienstra <mrienstra@gmail.com>, git@vger.kernel.org
References: <CABBAUF+acoMScQfHFQGooPx9eng2FBeb-Z2619DsnCt5QmhQPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0U3Gv/gKZONf3BJk"
Content-Disposition: inline
In-Reply-To: <CABBAUF+acoMScQfHFQGooPx9eng2FBeb-Z2619DsnCt5QmhQPQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0U3Gv/gKZONf3BJk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-09 at 22:15:59, Michael Rienstra wrote:
> Release notes are currently plain text files -- and that option should
> surely remain for backwards compatibility -- but it would be nice to
> have them in a format that facilitates cross-linking.

Despite the .txt extension, these files are actually in AsciiDoc, which
is our preferred text format, just like the documentation.  AsciiDoc
tends to work much better than Markdown for things like manual pages and
other non-HTML forms of documentation, of which we distribute several.

> For example, https://git-scm.com/ currently shows:
>=20
> > Latest source Release
> > 2.39.1
> > Release Notes (2022-12-13)
>=20
>=20
> Which links to:
>=20
> > Git v2.39.1 Release Notes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> >
> > This release merges the security fix that appears in v2.30.7; see
> >
> > the release notes for that version for details.
>=20
> -- https://raw.github.com/git/git/master/Documentation/RelNotes/2.39.1.txt
>=20
> Navigating to the release notes for v2.30.7 is not convenient. Some
> users will simply modify the URL, which will do the trick. Others may
> find their way to
> https://github.com/git/git/tree/master/Documentation/RelNotes & search
> for "2.39.1", which also works, but isn't particularly friendly.

This is tricky because we'd want to link to them on git-scm.com, since
we don't distribute solely on GitHub, and I don't know if those are
available there.

If you asked (or submitted a pull request) at
https://github.com/git/git-scm.com to make sure they're distributed as
part of the site, then perhaps Junio would be willing to insert a link
or two when we have another security release.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0U3Gv/gKZONf3BJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY+V0MgAKCRB8DEliiIei
gcZaAP0fwT7wsMXIREuOY2+B2Ua/uI8LOO9VLx0i9z+rhQ9rBwEA5fiX2Lm1R7bx
7m1D9e9vUowKEsaPcUNG7zywbkIIjQs=
=/0HM
-----END PGP SIGNATURE-----

--0U3Gv/gKZONf3BJk--
