Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6449DC35242
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 00:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36561206CC
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 00:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CyQX5UZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBLAVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 19:21:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59124 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727985AbgBLAVg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Feb 2020 19:21:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D05FA60478
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 00:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581466895;
        bh=JVb/d46ukEXijtCcvfe5TQHY/QsLNp9xaiTVhpaZMWk=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=CyQX5UZ5kmEDZa9DM4cNbQmU6ee2+xnT0ApT0YUYQzf9rKft+ZjGQmBpF3CUN54GM
         s2/tzKEnUeNIfd6W4VgbpsEUUHwawuolMJKdc/NGXXo8ZMbR0I1ihzFmDt3szyblLr
         NAOgh1dEobmj1uSWgT6DkhlXDx3a1BwXuFjm66s2yJT3XtJyANAbehFy5+aKeBLFFk
         54dMcTKai4TJ7PqBAjKgHKzsFnqJJp3FDrL+u6594yg5GiVtByw36hbu1pQbDbKkBe
         jO975CGQVUYJBWVzIDeETPJIfIvyYUl5U7ouQ4WnY8YXNhM6VZ/laX6wcj7hhCvQUS
         /RS2qJkKcT1hbDUDoLQM3lxT4tlcyfX8s+N71Q1kbzPV4qNt8lnundU+c8jerNYWYy
         E8Ri0YaTFN3PaCTyP7pUbsoMNFdnWeeGX45l3+/kZ9oMZR9xFk2FDkXxYJ2fubqFRC
         6PFgxRqr8jHptJW+e7BnHJ4FSw4/lQPbJOpGQreDCHvjEY0i3cv
Date:   Wed, 12 Feb 2020 00:21:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Git representative on AsciiDoc Working Group
Message-ID: <20200212002129.GB6464@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've had folks from OpenDevise reach out to me and let me know that they're
launching a standardization initiative for AsciiDoc under the Eclipe
Foundation's open standardization process.  The goal is to standardize the
language, ensure compatibility across implementations, and provide a refere=
nce
implementation, with input from implementers, users, and others.

They'd like to extend an invitation for the Git project to send a
representative, since we're a significant user of AsciiDoc.  I'm sending out
this email to see what the project thinks and if anyone would be interested=
 in
fulfulling that role.

Here's a bit of a summary on what will be involved:

  As a Working Group member, the Git project will have the opportunity to:

  - Influence the scope and roadmap of the AsciiDoc standardization effort
  - Help define the AsciiDoc specification, including terminology, syntax,
  document model, behavior, and extension points
  - Establish compatibility rules that ensure portability and
  interoperability of content and language extensions

  To learn more about the AsciiDoc Working Group and how it works, please
  refer to the welcome messages on the mailing list:

  - https://www.eclipse.org/lists/asciidoc-wg/msg00001.html
  - https://www.eclipse.org/lists/asciidoc-wg/msg00002.html

If anyone has any questions, I'll do my best to answer them, or to pull in =
folks
who can if I can't.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5DRQkACgkQv1NdgR9S
9ouXIA//YtVXQQvP8VB0V+nU0ohX9Iu+lH9EC/uqZnySdUR/hHYQI9LtZHOlIU0I
o4if3ZEELHgFzlojz7VS0/ON9OxCXQsFZzfZvL+NPhEQzZWO2ufuWgXQWH6mEBOr
6OzZMN/VF8mTE49bh3wC1STm8tCPNwHmn5HrPW2v1m15eDMJSHQLms7iJ/IY/MBB
P4KcLbVCdvP/he4Y3yvy7dRK1ZQzSRG28gWMXCbtCTOFFO49LJS1OhzWkzWhYHSX
QTuD37Jsv7yWvu7mNQUpi70rU4goTp8rVqG8uQBDi0OxByOMbVWpAGoGv59rYkCJ
XY9uZTtJAOlJ/2eyrxJm5VA405zJ0akBwZLlbGWPoxxILLwmLrWLcmKyv6/UJaqU
a5wWi779VspBbqjWgTUzOgyvNO8GNqFqgQ8KdhcCjF+xPhc43cXDzbwegICuG5lB
nbpROabGbSvSbsg051VYQgmOJxOPTEjUwKVQz6ChpMP8ykE7mkB94WCBsZ0e48Rx
7JwIFOXG1oAs0hniTzdftnd9+fsYJK5QeD+3g09Jp8yGmhSk7iKMqV4cZq0+fMIj
YqlmdKJIJkEslLMjlWKdh3CvslDqs4eIhEElRM5cF7Ye5f/Af/PiGJpPcAof0sOX
KF/+4lMqw9cESJxUvDxSFLnYnIHkV+NrTFZUKIIGWn6jKfohoBY=
=s7Qq
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
