Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBCC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 11:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjAaLCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 06:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjAaLCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 06:02:42 -0500
X-Greylist: delayed 4053 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 03:02:33 PST
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE83433D
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 03:02:33 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 20AE95A300;
        Tue, 31 Jan 2023 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675162953;
        bh=h7CBfHQg7VVpMyypus6Trt6tKxyJy7efUbhOipywpEY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rfrM4Dk1xxCBaYoKGs/fSx2lcNByYM+RdV2hZNuz8M4hhBrqBHa3/DC7LG2EiBN17
         oaoWGrJ4SP6T5+v2UDUOm7WvqQVFM1KXRcyBZP3UynfZUbNeSQjrnuW0SbFRG9H7ey
         GMGEeZrkKrHPDRig90ziwfbdgH3XTlTh5t0K+w6E5zvPQoHAz2WveHzO/kwQ7KBJei
         iSkz/A0KGqj1r71uzfJQNjzwQ4IBcwYUIO3DjAryM4ZSnSQ5gy8tGlhdQfFUUOOo4f
         pi/e33LckfyC6UyQ+iHEIW++HALR9LioMMFDSZXOulrNUYVOapMAl01Bf1cYMpsvzm
         NdI+rRQInkli5pcNrNIAeFZ8tP3SC3mMegYmDZqL7vXjdqyH1X+49lFhBm15WNIZ5N
         9ycEnyghBl6WxY84FKBacvLdN87NKdLhZUyWpGMJ2QoY33qce4yY8tjI1NFImjW0+5
         0tRzvUN6BeajBauWmT3zcXRoSKcpVsQtPqJxcNvMdJTbYJ7qqQz
Date:   Tue, 31 Jan 2023 11:02:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
Message-ID: <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "peff@peff.net" <peff@peff.net>
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hgixattlv86u/4Km"
Content-Disposition: inline
In-Reply-To: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Hgixattlv86u/4Km
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-31 at 10:52:47, Bezdeka, Florian wrote:
> Hi all,

Hey,

> I just updated from git 2.30.2 (from Debian 11) to 2.39.0 (from Debian
> testing) and realized that I can no longer clone repositories using the
> git:// protocol.
>=20
> There is one specialty in my setup: I'm located behind a proxy, so
> GIT_PROXY_COMMAND is set. I'm usiung the oe-git-proxy script [1] here.
> My environment provides the http_proxy variable and privoxy [2] is
> running on the server side. That information should be sufficient to
> reproduce.
>=20
> I tried the following two repositories for testing:
>  - git clone git://git.code.sf.net/p/linuxptp/code linuxptp
>  - git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.g=
it
>=20
> The result is:
> Cloning into 'linuxptp'...
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output
>=20
> I was able to "git bisect" it to the following commit:
> ae1a7eefffe6 ("fetch-pack: signal v2 server that we are done making reque=
sts")
>=20
> Reverting this commit on top of the master branch fixes my issue.
> All people involved in this commit should be in CC.
>=20
> Looking at the TCP byte stream shows that the socket is closed after
> the client received the first "part" of the packfile.
>=20
> ...
> 0032want ec3f28a0ac13df805278164f2c72e69676d13134
> 0032want 57caf5d94876e8329be65d2dc29d3c528b149724
> 0009done
> 0000000dpackfile
>=20
> Let me know if you need further information. Hopefully this was the
> correct way of submitting a bug to git...

I think this may have come up before, and I think the rule is that you
need a proxy where closing standard input doesn't close standard output.
Since that script is using socat, I believe you need the -t option to
make this work, or some other approach where standard input and standard
output can be closed independently.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Hgixattlv86u/4Km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9j1RwAKCRB8DEliiIei
gRQ9AP9X/qBlhLZ1gBLVX0KNgO50dWUeQAl6Aqck9Hq+ly9aIQEAjNQulTHSfGkK
lBVStljyY6PqoOQEsQcC1O47ke2J/wA=
=jCL0
-----END PGP SIGNATURE-----

--Hgixattlv86u/4Km--
