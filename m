Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1565AC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C38C2075A
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Dpl46CMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgHCXuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:50:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41322 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbgHCXup (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Aug 2020 19:50:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 350FE60799;
        Mon,  3 Aug 2020 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596498614;
        bh=kv1UFuZO8XoV4i3w24iWXTmdWMnfEmekUv3rNQQ9Wrs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Dpl46CMnLrx/t/CkUpJoyPQ/8y4+kJfSXsgt4msJtNngq6FrwFfNpWpd1XWDKCF3z
         IsfSOrnAMGgcKVsA1c6Ub5ytYxo3a0IU4fIsPO7KkNfFbbhhSQhAs83LW3QG3N7D7c
         6gC9OYXh9/TQRCZFbEZ97LrpiqnYe9MdYhs2/SKvul2Fg1mWT+jXCjE10EeX2oASu4
         BaVyebWfJB1SBKI5FnSEb3cDne8QywFE7SD3eRW08Ov7/g5UXgKE00sISxfYHa+JQv
         SVJaIy8PT8/M60ChT3nffCNHTLbxhJOoxLSwuCgFeNPy9xNaVh56h5NjjAlrbVnGQF
         efutlDD41Bjakw7IOcj+VRLO63G8xSEO5nCcSbW6pC0LvQWkjOuAB+Tt/9DX6D+rF1
         dUKUjRMChALUl2nOYNUoJk0whINUN61uqEILD1/KDrY4xb8Y1SU2GmBeXtZp2CVn7U
         b71qdE2bQseFBOwghPwU9Hw9HAPkoaJu56S7EOfW6AU0KoQbzdB
Date:   Mon, 3 Aug 2020 23:50:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] git-cvsexportcommit: port to SHA-256
Message-ID: <20200803235007.GN6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas Schwab <schwab@linux-m68k.org>, <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-15-sandals@crustytoothpaste.net>
 <87zh7bo9so.fsf@igel.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Content-Disposition: inline
In-Reply-To: <87zh7bo9so.fsf@igel.home>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-03 at 18:37:27, Andreas Schwab wrote:
> On Jun 22 2020, brian m. carlson wrote:
>=20
> > diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> > index fc00d5946a..6483d792d3 100755
> > --- a/git-cvsexportcommit.perl
> > +++ b/git-cvsexportcommit.perl
> > @@ -22,6 +22,10 @@
> >  my $repo =3D Git->repository();
> >  $opt_w =3D $repo->config('cvsexportcommit.cvsdir') unless defined $opt=
_w;
> > =20
> > +my $tmpdir =3D File::Temp->newdir;
>=20
> File::Temp in perl 5.10 doesn't have the newdir method.

That method was added in File::Temp 0.19, which was added in 2007.  Does

  my $tmpdir =3D File::Temp::tempdir(CLEANUP =3D> 1);

do the right thing on your Perl 5.10?  I no longer use CentOS 6 at work
and it won't run in Docker on modern Debian, so I can't test.  If so,
I'll send a patch.

For the record, I plan to propose that we drop support for Perl versions
earlier than 5.14 on December 2, since CentOS 6 will be dead at that
point.  I think a ten-year lifespan for an OS is quite generous and
we're still considering Perl 5.8.8, which nobody is publicly supporting
anymore.
--=20
brian m. carlson: Houston, Texas, US

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyiirgAKCRB8DEliiIei
gUS9AQCx1Tjq1DfclApUhYJav2q/21J6nCYS1MWW4eqrRCngBQEAqCp7YP1CwOsn
+0AUd2X5Ehe0LkZ7BFVMorzMQ1lamA0=
=pndE
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--
