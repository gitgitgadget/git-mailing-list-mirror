Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C151EC32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 22:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DB6222C4
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 22:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dtud1m2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgADWsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 17:48:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58984 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgADWsh (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Jan 2020 17:48:37 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C69060436;
        Sat,  4 Jan 2020 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578178115;
        bh=kst1BTGORUo97FT2MM4YpZ0OeJ9NXfqxBD5gQXSzGlY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dtud1m2M8B7b4AA09oV+tYD8wpXNTAvv46T+HKzzSx/7kwBDc9sVfaQJnHOmLa7Ch
         a/d5RfzwTuzHjUFADHneRxEteuvEz4wqmhn62ibEZn/zq8G3BU6bdyEzTxtoVdmN1m
         cylXNH9kAfIKE5SW1Qgm9sdRXsNqc/IZAxLQSGY3onXE+/hps21udvzKsavEuZwMGe
         UvY/YAIXLDO1y+powWE1JU5nsptFBOjDHTZlEV+loHa+jDGR9PLHXzB6anFPKEul5N
         H5w7iYl6cKQO5WCSEyXv3vNeD3DuZnW/sKkgm4zl5hh7VpwFkBj9GDqO6Hv3gPhKkh
         j4RXySQsqwqYnltuEA5ZDpducGBIMyxWpT4yzWaquwzsXUPupGcGPprLVtdTgzB2ve
         tX6dYF7+YLxAV72VkRS1Pvge8gzjHfu830LAu9TJZgMCImW+x61fhMLr+4hOFny+JR
         hQyp1fbhGRPubF29sGEi2/N35ztYcE6U+gFFCVSASeAzV/uj0EF
Date:   Sat, 4 Jan 2020 22:48:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: Testsuite failures on ppc64, sparc64 and s390x (64-bit BE)
Message-ID: <20200104224830.GF6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        git@vger.kernel.org
References: <34ed7497-643e-5a38-d68c-7c075b647bcd@physik.fu-berlin.de>
 <b7565f06-55a2-7087-d46e-94f9e7ada988@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline
In-Reply-To: <b7565f06-55a2-7087-d46e-94f9e7ada988@physik.fu-berlin.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-04 at 22:14:21, John Paul Adrian Glaubitz wrote:
> Hi!
>=20
> On 1/4/20 9:14 PM, John Paul Adrian Glaubitz wrote:
> > It seems that git is failing its testsuite on all 64-bit Big-Endian tar=
gets,
> > full build log can be found in [1]. There seem to be multiple failures.
>=20
> Just checked out git with git from github (SCNR ;)) and built and ran the
> testsuite on ppc64, s390x and sparc64.
>=20
> ppc64:
>=20
> make aggregate-results
> make[3]: Entering directory '/srv/glaubitz/git-git/t'
> for f in 'test-results'/t*-*.counts; do \
>         echo "$f"; \
> done | '/bin/sh' ./aggregate-results.sh
> fixed   0
> success 20683
> failed  0
> broken  239
> total   21161
>=20
> s390x:
>=20
> make aggregate-results
> make[3]: Entering directory '/home/glaubitz/git/t'
> for f in 'test-results'/t*-*.counts; do \
>         echo "$f"; \
> done | '/bin/sh' ./aggregate-results.sh
> fixed   0
> success 21298
> failed  0
> broken  249
> total   21760
>=20
> sparc64:
>=20
> make aggregate-results
> make[3]: Entering directory '/home/glaubitz/git/t'
> for f in 'test-results'/t*-*.counts; do \
>         echo "$f"; \
> done | '/bin/sh' ./aggregate-results.sh
> fixed   0
> success 20703
> failed  0
> broken  239
> total   21176
>=20
> So, it looks like the failures might be specific to the Debian package,
> doesn't it? Where there maybe any recent commits that may have fixed
> those issues?

Did you build your version of Git with Subversion support, and if so,
which version of Subversion did you use (version of Debian package or
other source)?  The tests that were failing all require git-svn, which
in turn require libsvn-perl and subversion (/usr/bin/svn).  If you're
missing those packages, the Subversion tests will automatically be
skipped.

The latest version on master is 2.25-rc1, and that's failing in the
Debian package.  I haven't checked recently, but last I looked, the
Debian package wasn't applying any additional patches on top of Git, so
the version you're getting off GitHub is literally the same version that
you're getting in the Debian package.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4RFj4ACgkQv1NdgR9S
9otCHBAAlzstQK1C/Sb4/xNx344Who+kG3y8Yzovaw3Ty2oZRUsaXrb5DgWa+RyC
PS0IUfxcReyZC9XnB1BH4NKwVRm8ieezTupahZnyPD246hXyHYRs1hXOtfBf94js
mnCEN2KQmnkKQjtq2Q6oCgCtc48LE8q4mrBfPXKPOvlxu4eVISVd3T4v2N42Vfdm
2XlBC6W3G99HgNRfMBIlNjrOv2+Z/ArtaiEG2U2MfzO3FbQ3h7oj7zI6ztfnPVb7
gLKcYKSPR7M/U47WXB8l02yaA0hz3HtDLam4BJpRCVWilMn2gH4VtzNYSk72EGBt
ccS81RJSO1gpV4/ECnH7OBMmI4+L4NLOg6XMIOmpT4KH0f5QZ2px3+THrofRC0Hk
3vyeJhHMHqWdzDVR+XRN/5POnACCRaDFNKXf/uB1PThf+UV0bVsXuTz0sZWshy4Q
EYZGKOgtOQPYJBGT46/rAKug+eQDrv/5JHFbCqAOJrpM46A9ttpXlP7ufMwTiILL
eWQd6zVoIrZFUZQW8lU5zmecGmlS+NwP5bcAJr1xaHLHfwp9qcs5e7m8nMkPfd+0
tsYEb4UzbAQ2fm+eSnvf/lyst1Z9EOkSZhajmOqgoQNaJw7EO4zsK8brEukV8LFV
QiiG912e2TdD26IoPaI0j67n+bEGSj55l5RxVmVUplWfianO2TA=
=Xa/A
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
