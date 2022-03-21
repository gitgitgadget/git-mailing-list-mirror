Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91E4C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiCUXww (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiCUXwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:52:51 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE0190593
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:51:14 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C718B5A0C8;
        Mon, 21 Mar 2022 23:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647906667;
        bh=jfrIiyIe1RMHEs1hVwqGRfao7GHvOLuNncw7BZbrVRc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=U1YRLb8wa69o0i5F+Tlz/kUa2F5pV5Ecs1sakN4Pk8TamdOy42LPm7f0z6PttcZcF
         gPBAqhLE2MJfwcU/hwiCM7u4KUr+o51det87u9GDultLAp8TwgfCjFcH4i+qTvbMe3
         HcAqI45GES6YmXr909By/8Phs+fYW2pHSuxH7nN+Wq9QUTsFbMbeztQhQauFJhs5eV
         zWtKfwumCcJcbSkpNKr5g8Yrpk13EIEq1EEG2tP56HVp114M9NkzTWJH4VjgEo/h5z
         MWSt5twixnnCNJRpDETEvfCiTUmwAcpqnSC02nvktmVX66iEUeoI1WsjUa4qobwx6A
         Ob3HnFtJrJhoL3pdnsNAUbCCQ8Z7QWn3h5ptgsgxqrOVnnLE34zf0DRZ1k4Q86uhww
         jElvDQmYn3u7kQ7uPCznI0EJ7vWPpiNcFq5z2tqOeQzLzuf+FJNlshQJ+lCxEb2jMv
         aCyAbz0Hm9S386g8T07fX/6iQ3LwpuGhTnkVY9jIJxtanDI8HFc
Date:   Mon, 21 Mar 2022 23:51:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Hecker, David A" <David.Hecker@conduent.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Potential Bug - GIT/GIT LFS doing dnsquery on an IP address
Message-ID: <YjkPaBzrTeiskVTv@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Hecker, David A" <David.Hecker@conduent.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN8PR20MB28354228F53ACD3680F505E6FB169@BN8PR20MB2835.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W0lbARiL/FAlTonn"
Content-Disposition: inline
In-Reply-To: <BN8PR20MB28354228F53ACD3680F505E6FB169@BN8PR20MB2835.namprd20.prod.outlook.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--W0lbARiL/FAlTonn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On 2022-03-21 at 23:20:25, Hecker, David A wrote:
> I started the message below with git bugreport so I think I have all the =
details. (UPPERCASE to highlight; not shouting. =F0=9F=98=8A)
>=20
> Thanks!
> --Dave Hecker
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> WHAT DID YOU DO BEFORE THE BUG HAPPENED? (STEPS TO REPRODUCE YOUR ISSUE)
> -------------------------------------------------------------------------=
---------------------------
> I have an older laptop running Visual Studio 2019 and Git-2.35.1.2-64-bit=
=2Eexe WITH the "GIT LFS" option checked, which is working as expected: com=
mitting a change to a large file and pushing the changes DOES update the re=
mote repository with the change, and other team members who ALREADY HAVE A =
FULL COPY OF THE OLDER LARGE FILE are able to pull changes and will receive=
 the updated copy of that file.
>=20
> Another team member and I got a new laptop and set up Visual Studio 2019 =
and Git-2.35.1.2-64-bit.exe, and then attempted to clone the repository. Th=
e clone succeeds, but checkout fails with this error:
>=20
> batch response: Post https://tfs.acsgs.com/tfs/PDSI/HRS2/Learning/_git/Kn=
owledgeConnection.git/info/lfs/objects/batch:
> lookup 216.115.169.22: dnsquery: DNS name does not exist.
>=20
> GIT/GIT LFS successfully resolved "tfs.acsgs.com" to the IP 216.115.169.2=
2 for the clone, but then it seems like it=E2=80=99s mistakenly attempted a=
 DNS lookup of "216.115.169.22" which fails because it's already an IP addr=
ess, NOT a DNS name. (Doing "nslookup 216.115.169.22" fails in a similar/ex=
pected way: "can't find 216.115.169.22: Non-existent domain".)
>=20
> IMPORTANT: I then tried cloning to a new folder on my OLDER (Windows 7) l=
aptop, and GOT THE SAME ERROR. Therefore I SUSPECT this is NOT related to m=
y NEWER (Windows 10) vs. OLDER (Windows 7) laptop, but instead seems to be =
a GIT/GIT LFS bug=E2=80=A6and only when attempting the initial download of =
an =E2=80=9Cactual=E2=80=9D file.
>=20
> Another possibility is our internal TFS server perhaps has changed config=
uration since the first time we cloned our repository, but it seems unlikel=
y (I can manually download a large file into my local folder, then GIT/GIT =
LFS will manage it properly=E2=80=A6it seems to be only when trying to make=
 the initial download of a full file that fails with this =E2=80=9Clookup 2=
16.115.169.22: dnsquery: DNS name does not exist=E2=80=9D error).
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

This looks like a Git LFS issue, and Git LFS is managed independently
=66rom this project.  Could you please open an issue on the Git LFS issue
tracker[0] instead, including all of this information, filling out the
issue template, and including the output when using GIT_TRACE=3D1
GIT_TRANSFER_TRACE=3D1 GIT_CURL_VERBOSE=3D1 (stripping out any
authentication headers)?

That would allow one of us who work on Git LFS to look at this in more
detail.

Thanks.

[0] https://github.com/git-lfs/git-lfs
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--W0lbARiL/FAlTonn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYjkPZgAKCRB8DEliiIei
gcucAQDK8DCd+e8ylUrco11ksmVo+PPqx7t248JzcIWvnMsdLwD+NVW06og0WpwG
7fR+95wwUKY6QUK8DiUwGDPlFgwWjAg=
=eirp
-----END PGP SIGNATURE-----

--W0lbARiL/FAlTonn--
