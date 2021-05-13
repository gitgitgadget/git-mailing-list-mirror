Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C3C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F161421
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhEMX0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 19:26:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhEMX0F (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 19:26:05 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 87F7B6043F;
        Thu, 13 May 2021 23:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620948294;
        bh=D0v2CUk07CiwnHJ3VyOl2qtiac7xIq7ytEXcTy5pXzk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LbqDxZgIka0jzW8NAfTEttFC71650CwFfPPKMbqcUh1Q3eq+aZscSKe1Mhc3nQwQz
         eEexrA6DFvMjzBrAA3tUSU8AFF2y3L1+JvKelHiQ68sOAHQ8/tLP/xzwszV/z0UIQ4
         eeLY1ufgNNnLlqOKULlFT7DB4pzPiJ1EhcZFwefChDTu4K33sc/O3VzESfYm6T/8kc
         d1NsOrKg+Z+ip4rp+GnlG3IJaOgOopqQWx5HyA/XWVuPv7kkyGIEUp556w5ADEKVS2
         tiUZKhVbaOit5dXicvuvwxVR7dTmkHSormXovHZ6mjdxPJaCnWJbz7ISPuYF3DInOj
         0qDY2i1Ffj/1BMToM14xw2fZS4PeXAUl90g4ZPk+GB59+dmz8am0GJbB3u3vx1WpdO
         nzHtihaXnEw5ho2pe/q6s2uKhesckWVNvrDWQq9W6zwXUAW1+BdXjGXS/GvpexFUAp
         /4J3c8Hesso7Nbkz+D1tZmWOUPtXvmct33+vruD0Cpw7pjoGItM
Date:   Thu, 13 May 2021 23:24:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJ21Qfnk0tpPgPqu@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <6d56412a-cc67-22fc-717f-9fa218264b40@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m3q6OHd339oZyJlK"
Content-Disposition: inline
In-Reply-To: <6d56412a-cc67-22fc-717f-9fa218264b40@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--m3q6OHd339oZyJlK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-12 at 02:48:59, Bagas Sanjaya wrote:
> On 12/05/21 09.11, brian m. carlson wrote:
> > From: Felipe Contreras <felipe.contreras@gmail.com>
> >=20
> > Asciidoctor contains a converter to generate man pages.  In some
> > environments, where building only the manual pages and not the other
> > documentation is desired, installing a toolchain for building
> > DocBook-based manual pages may be burdensome, and using Asciidoctor
> > directly may be easier, so let's add an option to build manual pages
> > using Asciidoctor without the DocBook toolchain.
>=20
> I have concern: I currently generate manpages with Asciidoctor+xmlto. Does
> this change affects people using xmlto?

This change adds an option to allow not using xmlto at all but instead
using just Asciidoctor to generate manual pages.  If you do nothing,
you'll continue to use xmlto as before.

> > We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> > contain proper handling of the apostrophe, which is controlled normally
> > by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> > as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> > instead of a Unicode apostrophe in text, so as to make copy and pasting
> > commands easier.  These newer versions of Asciidoctor detect groff and
> > do the right thing in all cases, so the GNU_ROFF option is obsolete in
> > this case.
>=20
> At what version of Asciidoctor the apostrophe handling is corrected?

The first released version is 1.5.3.

> > We also need to update the code that tells Asciidoctor how to format our
> > linkgit macros so that it can output proper code for man pages.  Be
> > careful to reset the font to the previous after the change.  In order to
> > do so, we must reset to the previous after each font change so the
> > previous state at the end is the state before our inserted text, since
> > troff only remembers one previous font.
> >=20
> > Because Asciidoctor versions before 2.0 had a few problems with man page
> > output, let's default this to off for now, since some common distros are
> > still on 1.5.  If users are using a more modern toolchain or don't care
> > about the rendering issues, they can enable the option.
>=20
> Maybe when distros upgraded shipped Asciidoctor version to 2.0, we can
> bump the version requirement.

My general policy, which need not be Git's policy (but I think is
reasonable), is that I will support the previous version of Debian and
Ubuntu LTS for a year after the new one comes out.  Under that policy,
we'd wait until a year after Debian 11 (bullseye) is released.

> > diff --git a/Makefile b/Makefile
> > index 93664d6714..cb75dec314 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -285,6 +285,9 @@ all::
> >   # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to bu=
ild the
> >   # documentation.
> >   #
> > +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page back=
end
> > +# instead of building manual pages from DocBook.
> > +#
> The wording should be "...instead of building manual pages from DocBook w=
ith
> xmlto".

I can make that change.  We're not using DocBook either way, with xmlto
or other tooling (e.g., a plain xsltproc), so what we have here is
accurate.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--m3q6OHd339oZyJlK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ21QQAKCRB8DEliiIei
gf3SAP0UIZWCRfDunh/5WeSVF5Mpytr0hah+I/CTk56pLUDLHwEAt+myCfF67upb
gXnkxhvXQJHYlv1ye5xyIz9k3yIrxQM=
=FNQF
-----END PGP SIGNATURE-----

--m3q6OHd339oZyJlK--
