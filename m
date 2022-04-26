Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6212C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355387AbiDZV1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiDZV1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 17:27:35 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252016E87C
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 14:24:26 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D35565A421;
        Tue, 26 Apr 2022 21:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1651008265;
        bh=e22tQtmlHtp05IN4hWdnssYDt1yyEpZWzLdAlRKAnZE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=z73QHq6Q2U0Ba6knXnx4LOvXdMqIyGYaueeDNhBUhBF14GRNcIQB2Isz25OfKGlRa
         kU5iwZ6O8c/GEPV8kP5Dvb839jSLPj7u+mqZ7ep9R68af5z7xfeWaPn0GVLlDlGItO
         Nx3hPDUP6eSWQfTmf/Y1T5CVpAkLMpGtYrBjBYdzZT2MXWRqDbMRDstu/Bc5mNArx7
         tuHwWPtqoVNCIEB/9ZwZNUT03RyhB4h1ky/tGVzJEBqGfU2hrtOB+eD0XmTU38ahHP
         5GdMiyWE+eD9yG5NHUTO5C7ZPbE0Y1J6vhx2WhwUli+k+KQEjoEBzfP1N0mWyGm0ew
         DFf9/Jrdk1QhzXYpkylsxibWA0K2bivRZxVG5v95mK3TZrMp2iQPCW3132Tz9FrHg8
         MGQrsMQZBcLgIpbmfgxMKxF7xvK6TZAPWWswG+VZ03wWLpSQ3jtcdNFyPelQ4XBI7q
         ImbLEba+AcSuO/V4lfn47cKoSvx5WXbuj/7BHVJYbsbX0ebod/Z
Date:   Tue, 26 Apr 2022 21:24:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     "Elektronik (C.Gerhardt GmbH & Co. KG)" <elektronik@gerhardt.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "CRM (C.Gerhardt GmbH & Co. KG)" <crm@gerhardt.de>
Subject: Re: Error after update from 2.31.1 -> 2.36: Unable to negotiate with
 IP port X: no matching host key type found.
Message-ID: <YmhjBBlJ5mcI31uN@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        "Elektronik (C.Gerhardt GmbH & Co. KG)" <elektronik@gerhardt.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "CRM (C.Gerhardt GmbH & Co. KG)" <crm@gerhardt.de>
References: <VI1PR05MB6495349A4C42AA568A665D7BCCFB9@VI1PR05MB6495.eurprd05.prod.outlook.com>
 <20220426144914.nyaohjqqqlotxnnm@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="56SwbO+voGBQ+ZnG"
Content-Disposition: inline
In-Reply-To: <20220426144914.nyaohjqqqlotxnnm@carlos-mbp.lan>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--56SwbO+voGBQ+ZnG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-26 at 14:49:14, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> On Tue, Apr 26, 2022 at 02:05:14PM +0000, Elektronik (C.Gerhardt GmbH & C=
o. KG) wrote:
> > =C2=A0
> > I found that after an update from git 2.31.1. to 2.36 the authenticatio=
n to our git server (running gitea 1.13.1) fails. We are getting the follow=
ing error:=20
>=20
> I am guessing the issue might be the one documented in the following git =
for
> windows issue:
>=20
>   https://github.com/git-for-windows/git/issues/3468
>=20
> The problem is not with git (neither a git for windows) specific issue, b=
ut
> with the underlying version of openssh that is used in your server and the
> best course of option is to upgrade that and generate a new host key, but
> there are other options shown in that ticket that might help in the meanw=
hile.

Yes, the error message you're seeing indicates that your version of
OpenSSH, which is used by Git for Windows, has disabled the insecure
ssh-rsa signature algorithm.  Keys using the ssh-rsa key type, which can
use ssh-rsa as the signature algorithm or the secure rsa-sha2-256 and
rsa-sha2-512, can continue to be used if you support the new signature
types.

The problem is that Gitea uses the Go SSH library, which inherits this
problem.  Gitea is tracking this as [0].  The easiest way to solve this
would be to add a host key that is Ed25519, which won't have the same
problem.

The issue I mentioned above also has a workaround to re-enable the
ssh-rsa signature type if you can't do that, but of course that's
insecure.

[0] https://github.com/go-gitea/gitea/issues/17798
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--56SwbO+voGBQ+ZnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmhjAwAKCRB8DEliiIei
gdeqAP0VQHd1KGo28JoFk3kVdqxDZBO59iEKpr0luFdO/92bnQD9GJm8HLSrewfw
K3zz4OqwCQyMf6KgN39uFT/VV8o0LgA=
=M6ne
-----END PGP SIGNATURE-----

--56SwbO+voGBQ+ZnG--
