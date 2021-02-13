Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075BCC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACF464E8E
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhBMBSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:18:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47282 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232105AbhBMBSM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Feb 2021 20:18:12 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA1DE6079B;
        Sat, 13 Feb 2021 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613179050;
        bh=fwN8nvc8hvPqCNPvhFTztXirIKLRwV1Y5zNxhChjT94=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XK3NzM3Rf4/4qL1gF6OzImP47m11xIQTFA32aIAX69wBr3RUSFF7ZxGaQFqGwhYWn
         +j34dUf1G5hhqeJ4tye++doTsnNfXawh1x4xtUx9vqJDrQbD/Ll45XZw6Ad58ywmnK
         HEnp7AdBBni8oVIaXCCyiMNh+rpXHk5yLcEBc5iqeHe0+0En2GO0gv0xBWiaBKH+87
         Qwb5xN43mMoIo/KKXB1snJjZ6h4SJWaYu6EoMeUQuDwAAte1Kdoik3t907Bk+bdyQi
         QKUvTWrGIl5qjAAqZBPsD7goHE0GPiaHGPdv0Eo4gZ4dSf3MT6ODxcmCmndXbwXA7L
         y4WZKHFyjvBHXHTHYn0otJfwek6rZE/E2nNzeln0xE+2suXTkegqtJ79YoNg7c0oC9
         h55rD43+bRkgXXVBoua6pAYpOMcV41Sp+ZQczQS23y2VK59Z57eRpql2lj1QuqamIC
         46ps1J2Do/tFTIezBqtKksI2TYbBHA9GBrJJeBCUIXSOe3lAxby
Date:   Sat, 13 Feb 2021 01:17:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Doggett, Thomas C. (GSFC-705.0)[TELOPHASE CORP]" 
        <thomas.c.doggett@nasa.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Zhang, Cynthia X. (GSFC-705.0)[TELOPHASE CORP]" 
        <cynthia.x.zhang@nasa.gov>
Subject: Re: inquiry on Git GUI for Windows 2.30.0
Message-ID: <YCcoorkH+E/dx5i1@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Doggett, Thomas C. (GSFC-705.0)[TELOPHASE CORP]" <thomas.c.doggett@nasa.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Zhang, Cynthia X. (GSFC-705.0)[TELOPHASE CORP]" <cynthia.x.zhang@nasa.gov>
References: <SA9PR09MB5807B61FB32C4865C1A2246DB68B9@SA9PR09MB5807.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3S7wDL2K+AVV9rqK"
Content-Disposition: inline
In-Reply-To: <SA9PR09MB5807B61FB32C4865C1A2246DB68B9@SA9PR09MB5807.namprd09.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3S7wDL2K+AVV9rqK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-12 at 15:20:07, Doggett, Thomas C. (GSFC-705.0)[TELOPHASE CORP] =
wrote:
> Hello,
>=20
> My name is Thomas Doggett and I am a Supply Chain Risk Management Coordin=
ator at NASA.  As such, I ensure that all NASA acquisitions of Covered Arti=
cles comply with Section 208 of the Further Consolidated Appropriations Act=
, 2020, Public Law 116-94, enacted December 20, 2019.  To do so, the Countr=
y of Origin (CoO) information must be obtained from the company that develo=
ps, produces, manufactures, or assembles the product(s).  Specifically, ide=
ntify the country where each of the following products were developed, manu=
factured, and assembled:
>=20
> Git GUI for Windows 2.30.0

You are referring to what is probably part of Git for Windows and should
be addressed to the Git for Windows project at
https://github.com/git-for-windows/git/.  They provide the Windows
binaries, since the Git project doesn't provide binaries of any sort.
The vast majority of the code for Git GUI is shared between the two
projects, though.

> If the CoO is outside the United States, please provide any information y=
ou may have stating that testing is performed in the United States prior to=
 supplying products to customers. Additionally, if available, please identi=
fy all authorized resellers of the product(s) in question.
>=20
> Lastly, as required by Section 889 of the Fiscal Year 2019 National Defen=
se Authorization Act (NDAA) please
>=20
> 1.) advise if the product(s) in question is/are not manufactured by, cont=
ain components manufactured by or substantial influence from prohibited ent=
ities - Huawei, ZTE, Hytera, Hikvision, and Dahua and their subsidiaries an=
d affiliates, and,
>=20
> 2.) advise if your organization has the covered telecommunications and/or=
 video surveillance equipment or services as a substantial or essential com=
ponent of any system, or as critical technology as part of any system withi=
n the organization.
>=20
> Product / Service Description: Git GUI for Windows 2.30.0
> Model Number	(if applicable): 2.30.0
> Country (or Countries) of Origin: [[please provide your answer here]]
> NDAA Section 889, Part A Compliant (Y, N, N/A) : [[please provide your an=
swer here - (Y, N, N/A) ]]
> NDAA Section 889, Part B Compliant (Y, N) : [[please provide your answer =
here - (Y, N) ]]
>=20
> Is final testing performed in the United States?:
>=20
> Recognizing that these questions don't fit open source software very well=
, will add that I've tried some workarounds - like your affiliation with th=
e Software Freedom Conservancy, but their entry on SAM.gov is expired (curr=
ent entries would have NDAA attestations on them).
>=20
> For these purposes, the country of origin of software is the country wher=
e the software was compiled and converted into object code.

I will just say that since Git is open source software, it's a bit rude
of you to ask us to do your compliance paperwork for you, since it's
significant work with no other benefit you are not paying us for, and
we're otherwise under no obligation to do so.  Many contributors
contribute to Git on their own time and equipment in order to benefit
the community and aren't in need of additional paperwork.  Since we
provide open source software, if you need a version that is compiled or
tested in a particular locale or a particular way, you are of course
free to do so on your own systems at your own expense, or hire an
appropriate party to do it for you, such as 18F[0].

Moreover, in many cases the code could have been compiled on an
ephemeral cloud server in one of many locations, so the information you
seek may not even be knowable.  Major Linux distros such as Debian even
compile packages for different architectures in different locations:
amd64 packages are compiled in Austria, Greece, the United States, or
Canada, but the ppc64el packages from the same source code might be in
either the United States or Brazil, and different versions, including
security updates, may be compiled on different systems in different
countries.

Git, and Git for Windows, have numerous contributors from all over the
world, and we appreciate all of their contributions, regardless of their
respective nationalities.  We don't inquire about where people do their
development work, since that information, given our respective projects
and the context of open source software, is irrelevant and asking would
be seen as invasive.  As a result, that information is also probably
unknowable.  (For example, I don't recall which countries I, personally,
have done Git development in, although I know the number is greater than
one.)

Before you head over to Git for Windows, I should also point out that
the main Git for Windows maintainer, while residing out of the United
States, is a colleague and a respected member of this community, and I
very much value his contributions to this project and that one.  Your
questions, even if required by law, seem like they might come off as
offensive or insensitive, and so I'd encourage you to be very careful
treading here to avoid offense.  In that vein, I would also advise you
to read and understand the codes of conduct for Git and Git for Windows.

So to get at least some of the information you seek here, you'd have to
ask the Git for Windows project, but don't be surprised if the
maintainers aren't delighted you came by.

[0] https://18f.gsa.gov/
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--3S7wDL2K+AVV9rqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYCcooQAKCRB8DEliiIei
geSdAP9dG3Tz6Pmi4CKUxh0yp91bsiPtcys0V0S7i0TltR1j8wEA1UtMjIP2TjJb
2RR2qI6Wx5uZoOotL5AgUbyTum7MQAI=
=SE5O
-----END PGP SIGNATURE-----

--3S7wDL2K+AVV9rqK--
