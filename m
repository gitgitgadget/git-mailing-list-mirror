Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 00:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356512AbiD0AyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356481AbiD0AyD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 20:54:03 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E256D857
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 17:50:54 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 12CDA5A421;
        Wed, 27 Apr 2022 00:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1651020654;
        bh=6VArr/ghItA7YoPn9XagQBqZgjWDPM61g9MhHNauLoI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JIEcLsRY/0zynuCZWjUjW7VDHJ3AOyonnTf7Xau7Pw7UfEhknBy74OZXyJHMPYyfa
         85ibKZrk6GJ6N1grgDaXgFf/oss/oY+ZMHqav6AAbL4SqqOQOoPTLnksMPOIqft/sE
         nX2qusms1BAAtJgXhqaMiQq9tu8yuoYk695Q++U2fsKBCjtbSfS7K2L6Xfss5iF+JT
         5Xdd0WLzicR6ZHHUvSzIG3xgtkzMSsu9pgcrCAl74SZ8vdrGNAJF7/V/GByJOFXLIq
         JbctnDKlxIwrPG6Tx/dGrypJRGvsGx//cGvt8ITrLVplLBCRGuByUaBYCY0ExsuInL
         gcsw3s61tIIkjmRmkEweZ0JHQ8yqkFdQBcmsX0VBq5gBby2HXKZ1S30Ucg4o1Vb8wT
         udWjYGq1+uiva6OB8xMESje+8l8BbjYKTeTjhoHGe5FFs3gJWaJEKS3yzP3UcPGhP2
         vtmCRpjEm7sRL4/gSf+uVnHxZtiQpIpzz7BVv7L7QfCoLl7LEb0
Date:   Wed, 27 Apr 2022 00:50:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Artem Semenov <artem.semenov@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: GitBash Paste with Insert Key on Windows 10 not Working
Message-ID: <YmiTaVnRVUPcS5CJ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Artem Semenov <artem.semenov@icloud.com>, git@vger.kernel.org
References: <66F55DFB-0CB5-4A70-B23E-8EE7844C4B56@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="diOyxdlf7AHte19n"
Content-Disposition: inline
In-Reply-To: <66F55DFB-0CB5-4A70-B23E-8EE7844C4B56@icloud.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--diOyxdlf7AHte19n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-26 at 19:57:32, Artem Semenov wrote:
> Hello,

Hey,

> Quick question, the Insert key used to work for pasting text, but it appe=
ars to no longer work with the latest version. Was the Insert key disabled =
as an option to paste text?

Git Bash and the terminal emulator used there are not part of core Git,
but are shipped as part of the Git for Windows project.  You probably
want to report this to their issue tracker: https://github.com/git-for-wind=
ows/git/issues
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--diOyxdlf7AHte19n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmiTaQAKCRB8DEliiIei
gQvUAPwPKlnU8INI6j6/H+uL5FUqgoVBlydicGH/wcSF1RnOaQEA3DyOpnADjiiz
anUmMDoJX27DhausVxYSAoRdECS0GQg=
=G3bX
-----END PGP SIGNATURE-----

--diOyxdlf7AHte19n--
