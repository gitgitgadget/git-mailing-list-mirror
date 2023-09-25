Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953E6CE79A5
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 21:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjIYVyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIYVyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 17:54:45 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18303AF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 14:54:38 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3FE8A5A2FC;
        Mon, 25 Sep 2023 21:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1695678877;
        bh=wm/YyxIrpG/sRdBdEa6b2inS64z2eAWTl0Fnwm2E6Ck=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=P8YCFMiq2l24U1NVsIlaeSY4g90xpGrmpo/Sn7JGogJsZUTKx80EO3IBESp3PEm5n
         rqDFzYwwCCGuMyc/Akf7riE9adYK05OXXyw25UDinOK6N0b4l0l9omGsk29zUkM3Hm
         0/MWWW0Cbu73KucCPrUgSLFOMpmVqUV1e/xTxIvLtToDikoE9ZxqpfBnREPqUCrjvI
         DXhZQnGMtdB8uv0VKeW6NXlvu8Rwr1pyAHVTih/ADtHbDZMUGvZzHQJWVlV7hWf1u6
         MfJ5DBL3rnRgNla1V79iF2WVCb9hLhniFO8YHu2zZ/lA6PmerlqcRAH9KgSGtArdsU
         inpGatnbqNV3rnu4ZoqgtPcwGm0/i4gTKVvJZifskGTCOk+7btUHFlpd4EvpZ/lQAb
         LYXsx14uFZnKRiGPOfwnrlQE1kPxToKC0wkLtpWZ5GnkQ2jOfHl5Q3g29paDkz9YDE
         4gdOwcEHOomQvjr6xa+qNHxLRg9IHkE9Yk6QADiB8sQwGg1pHab
Date:   Mon, 25 Sep 2023 21:54:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Robert Smith <robsmi_ms@hotmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request for Curl.exe update included in Git binaries
Message-ID: <ZRIBmxT4mh5Rlt3-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Smith <robsmi_ms@hotmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <IA1PR02MB9088F7E0AB55FE03CF0C38B186FCA@IA1PR02MB9088.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0zjvkizVPy4MsQ/8"
Content-Disposition: inline
In-Reply-To: <IA1PR02MB9088F7E0AB55FE03CF0C38B186FCA@IA1PR02MB9088.namprd02.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0zjvkizVPy4MsQ/8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-25 at 15:37:46, Robert Smith wrote:
> Hello,

Hey,

> Regarding this CVE:
>=20
> https://curl.se/docs/CVE-2023-38039.html
>=20
> Is there any plan to update Git for Windows to include the updated 8.3.0 =
Curl binaries?

The Git project doesn't ship any binaries at all, and we don't ship
curl.  Git for Windows does ship a substantial amount of other software,
including curl.  You can find their issue tracker at
https://github.com/git-for-windows/git/issues, but I believe this has
already been fixed in https://github.com/git-for-windows/git/issues/4605
and will be included in the next version.

I'm not certain about their release policy, but I seem to recall that
they don't issue updates for dependent packages until a new release
would normally be done.  To be certain, you'd have to inquire with them.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0zjvkizVPy4MsQ/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZRIBmwAKCRB8DEliiIei
gcc5AP43GEr/f1zqfpTT1Bk1m+LlB6T3G4AznF0cUfegJloRjAEA1zHv3s6iDEf0
4G5yfn9zkc5DIOx/2PeyunXKhu59sQU=
=balx
-----END PGP SIGNATURE-----

--0zjvkizVPy4MsQ/8--
