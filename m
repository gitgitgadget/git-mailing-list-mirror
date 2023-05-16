Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8B8C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 21:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjEPVat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 17:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPVas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 17:30:48 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A56E88
        for <git@vger.kernel.org>; Tue, 16 May 2023 14:30:47 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2900A5AF40;
        Tue, 16 May 2023 21:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1684272646;
        bh=jCNAF5kUf7xYmF2CUprrf2mxitQzuj8UiEYgOfeWZZQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BfFXtydGeH5emd9qXFc5EL7MpDErsbpL8f81CCjQZA9jRpvjcO2yLZ0WbNSy7Uy8G
         emxwSb5DXnQzvMyug4wqozBOHGTlKEGqDO/AwE4W6r3IkuIIdOE7+4SPN8QhaP0MNy
         o9XS9WRCHBZ9/6khYhB2/nECWAJK8DH7DtLOTKDyXMP2btbUYJO+41PpvnRJ0Zqqc8
         mZtbAyBVVLzE55a92LmvK//EgFaJpclo/3SbL3Nc2a4F8pVtJJhgPxhssOup8Tve68
         ZNp/uJcqOZGqmM5IrrTjLWfW8ywM2DBPj+k+CkLX1k9GX7bUQs6XEz+YHKwRjacnN6
         572EhUVsHCBHO+2my9TAJw63lUjQTbbFuH7DcfuvqYmk7ekyOZhWCYWCF7Wof/RBpB
         sqQL33cgiOV8eSBUQKyiFmWskabf20kajsdjAdfiG3nKgESoH7zqeFTmjNqQqXHNsN
         iYj9M4hEIfLXgZ+OXJoNNwMqOyKCGd+NmwVpotjnqec1GBk8Wtd
Date:   Tue, 16 May 2023 21:30:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git hangs with --separate-git-dir
Message-ID: <ZGP2AzYJSLpI4kGN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BY5PR14MB36544D63ECEAB9954C14407FA5799@BY5PR14MB3654.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CgZhJIbQCGpDV2/z"
Content-Disposition: inline
In-Reply-To: <BY5PR14MB36544D63ECEAB9954C14407FA5799@BY5PR14MB3654.namprd14.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CgZhJIbQCGpDV2/z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-16 at 17:54:41, Tim Walter (Visual Concepts) wrote:
> Windows 10 PC
> large project
> 300GB
> 500,000 files
> mix of binary and text assets.
>=20
> cd /d D:\myproject
> git init --separate-git-dir=3DF:\myproject.git
> git add *
>=20
> Git runs for a little while then hangs and does some really bad things to=
 the OS as well.
> it seems impossible to kill git.exe even with administrator priviledges.
> f: drive ends up locked and any other process, such as explorer that try =
to look at it also hang
> you cannot log out without hanging
> or even restart
> This then requires a hard power cycle to fix.
>
> 100% reproducable.
>=20
> running git init without=C2=A0--separate-git-dir and git add * works fine=
 (takes 3 hours,.. but works)
> then I can move the .git dir to f: and reinit with=C2=A0--separate-git-di=
r and that works.
> So this seems to only be a problem for the initial init.

I don't use Windows so I can't verify this, but I would not expect this
problem to occur.  Even hashing 500,000 files consuming 300 GB should
not hang the computer or take 3 hours.

What kind of disk is F:?  Is it an external disk (USB or such, and if
so, what speed and kind)?  Is it a network drive?  Is it another local
disk in the computer (SSD or HDD)?

Are you using an antivirus or firewall other than the default, or any
sort of other monitoring software?  What I suspect is happening here is
that you have an antivirus intercepting Git's operations and scanning
the files for viruses, making everything really slow, and then at some
point a bug occurs in the antivirus (which may have a kernel driver) and
then things hang.  This is probably made worse if F: is an external
drive or network drive.

If you are, can you try to completely uninstall that software and
reboot, and then try again?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--CgZhJIbQCGpDV2/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZGP2AwAKCRB8DEliiIei
genUAP4wHvrm8e8yAYcH/BpK5QysXvdsj3r3LeMPkrLjYBNpDgD+PFMh0FiqmmTs
pWUh44vzgj21Szry837Lt8OW4Xck7w4=
=2J30
-----END PGP SIGNATURE-----

--CgZhJIbQCGpDV2/z--
