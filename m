Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E7CC64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjCCXDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 18:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCCXDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 18:03:37 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60FC5FFD
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 15:03:27 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C93515A1DD;
        Fri,  3 Mar 2023 23:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1677884606;
        bh=cj1VivsiS+nenTElEBrpfk8G+j6pylJmkVpQRn/LkgQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wyCzw3FZna1/NcGth//XT0Wp019wKiF3N36eVsq9vFCcI47UdO/uRQRpa2hGM31n7
         Sk54oSQaiK/76KcivqTDu3OK2MsU+KyxgXm4u51HajKg7Y4Zx3gY5vN3kd7AkNVXxO
         +tqhhh3g0xAW7iHSroozoI06htNPs2Jcljc3hyel/i/vzBNgD+MjySQEZvjz3OtsAI
         A44sa+ZZxUpVHkKiTKXv+SLg67n96Jek0qjcc0wicpv0IZEnLBpb4PLXq0scMRqE6b
         42xl3yawwaqxagm/7CIX21uO0k8s2wnVNB7oozGdMbCM1zHTQIMjffFpHLFzKKNL2v
         sa/i+S1IKQv+JVF19FpDQlqWAjIWOtIjg5QhoVQgHdTonQ4V6zmNBiJt8oQ/+WoRLy
         wqni6QdGwU0N8VcMbiBrovDiNeCyej+FMFr4YegvOgE+7wHvKsaSUb/z2L9fX9b01K
         WzjpjdjQdzPS7w5y/WnX6AX8EDBEnZudM+P+5O2UJ54sU8m03ti
Date:   Fri, 3 Mar 2023 23:03:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Magnus Asplund <asplund.magnus@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is xmllint no longer supported in (latest) Portable GIT 2.39.2 ?
Message-ID: <ZAJ8vDUeLDH0CZAd@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Magnus Asplund <asplund.magnus@gmail.com>, git@vger.kernel.org
References: <CACw=1eCKN-saQCbOmoyZ1=ydcwoC0FE0KvE5UQ5ttkkv0OeBcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DdL8+bD3i0godPDn"
Content-Disposition: inline
In-Reply-To: <CACw=1eCKN-saQCbOmoyZ1=ydcwoC0FE0KvE5UQ5ttkkv0OeBcg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DdL8+bD3i0godPDn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-03 at 18:10:19, Magnus Asplund wrote:
> Hi,

Hey,

> I have a bash script created in RHL environment (Linux). The script
> extracts data from a great number (+100000) of XML-files and generates
> "row-col" data as output to a CSV file.
>=20
> Due to limitations in both technical knowledge and
> access/authorization restrictions of other persons than myself, I
> decided to give Portable GIT a try in Windows 10 environment to hand
> over the script execution to those other ppl.
>=20
> The script works fine using 64-bit Git for Windows Portable version 2.38.=
1.
> However support for 'xmllint' seems to be gone in version 2.39.2....
> (this one: https://github.com/git-for-windows/git/releases/download/v2.39=
=2E2.windows.1/PortableGit-2.39.2-64-bit.7z.exe)
>=20
> Any answers to this? Is xmllint not longer supported? Any alternative,
> besides using to older version 2.38.1 ?

The Git project doesn't ship any binaries, and it doesn't ship anything
but Git, including xmllint.  However, Git for Windows may ship those
things, and you'd probably want to go to their issue tracker
(https://github.com/git-for-windows/git/issues) and talk to them about
this.

My guess is that this was necessary to build and it isn't any longer,
and because libxml2 has a constant stream of security vulnerabilities,
it's not something they want to keep shipping, but you'd really have to
talk to the Git for Windows folks to be sure.

If you need a more complete environment on Windows, you may want to try
a Linux distro such as Debian under the Windows Subsystem for Linux,
which will likely provide an up-to-date version of this tool.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--DdL8+bD3i0godPDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZAJ8vAAKCRB8DEliiIei
gQFWAQCSqf4RTHBS2ijZFKwT3iUU527rdBczWwyxjzDYoM/icQEA/Ds5Wpu+qFG9
gvyrHukS7PQJoqw2DMShheCGNloPBg8=
=ir4d
-----END PGP SIGNATURE-----

--DdL8+bD3i0godPDn--
