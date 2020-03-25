Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EFCC18E5B
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 00:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBA02073C
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 00:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oYOcu78U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgCYANE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 20:13:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbgCYANE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Mar 2020 20:13:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 468896077C;
        Wed, 25 Mar 2020 00:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585095183;
        bh=CW+jDbMQkYgxIKGH1S+nBA3840FKmFNi5MuPRia4llo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oYOcu78Uyw1oNDjpT/8tu+h/K4oo+PM+0tF36wNgx44xTN92Mvnw/fP8kVa3BGoOk
         EgKkoGe9/4KfbFsBXUXAygQVLOnuca8cyNAMAcgY2Gxor7oqgJKn6gWZxZYjEII1zY
         DRif5SAW9TLi5NYqKS3Gfbfxa4tJL67NBzM2USCzfvzVoDc2l/QGTB8hJcvhRkH6zP
         Puk2xXcoXe+XtHk4WD+gICq4wiM5lcZ+HRyV/znWNrJr8uuj4F97Zdba896dWVgIcA
         MU1K2fO4rw8erKXCmFxx/ANDfX5BlLrPeMooHRkrTpVD4nf/A+1ykUZ1nN9jYFUg5k
         1gjEDjeqEz5nWNtWcZZBtYP+rmhsoMacK2cSZclSvf1tLlJAe9ESeUP1dZZ4k8hPSj
         SHT3SsuCnT/YA8zFpe+mLYQTbFRbOmr7ZOjf0f9dReNSXxkEsECX+RogEr8HRSthkT
         H+96Yh9I6WBEJ6peKAygMV/umWIolCCiOh6JfP62Fcj3LckTFLQ
Date:   Wed, 25 Mar 2020 00:12:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Anton Mladenov <anton.g.mladenov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Wrong Version On The Website ?
Message-ID: <20200325001258.GJ6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Anton Mladenov <anton.g.mladenov@gmail.com>, git@vger.kernel.org
References: <D6C222C5-3949-43F3-A63C-24D58EAB6675@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tu8ztk+XgTAiG9Id"
Content-Disposition: inline
In-Reply-To: <D6C222C5-3949-43F3-A63C-24D58EAB6675@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Tu8ztk+XgTAiG9Id
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-24 at 19:20:38, Anton Mladenov wrote:
> Hello Git team,

Hey,

> Third, I think the version on your website is wrong.
> The version number atop the Release Notes link (where I found your email)=
 is newer than the one on the desktop screen below.
> I checked your Github and saw the latest is 2.26 but the link from the sc=
reen image points to some other version. At least for Mac.

The Mac and Windows builds linked to from the website are provided by
third parties.  The Git project itself only provides source releases.
While the Windows builds are usually released around the same time as
the main source releases, the Mac builds sometimes take longer, since
they're done by a volunteer.

If you're interested in the latest release, I recommend trying Homebrew,
as they tend to be a little more up to date.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Tu8ztk+XgTAiG9Id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnqiCgAKCRB8DEliiIei
gYWyAP4/2L81xVbZ+QejlNWV10/K/75kwOHUugaveT0wfqRVPAEA3x+nHxCEfIgZ
bVc9UYX8PWxgyQa1E9X/60Y6ZCkkLQ4=
=vrJo
-----END PGP SIGNATURE-----

--Tu8ztk+XgTAiG9Id--
