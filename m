Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64C3C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB43622C7D
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbhAVCvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 21:51:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58126 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbhAVCve (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jan 2021 21:51:34 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 88BA960781;
        Fri, 22 Jan 2021 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611283822;
        bh=WoHFMraHulc3KyMd5amM5Yox7fdzqEyyhZjz12kezjg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LvAdX0rDkyiOg2u4WfMpO3llzrses0dF67qyGHxDZejto0WBUH+sqa0MATAXqY8yx
         2pqaAsA0FSkJ72jNm0eg/CBbpDdRblOX866kZCVEbcfkkaUPt9gHYG+xx+MNhHAxR0
         kx3xIuBJkqc5Kezk97F/Yz/LidCs0hJmXzqPk5n8Hy4+Bd8yBD+VxN7y63L/Rlfhik
         iK1zCnz/jEuc/Z3+FpPC1plEeaZPwqc3DcMAN0MrEHon7RWqmi33sgLlITiGWt4rTK
         6w8VuzyDXMtwfJpf/LfktIRxjAscMBts6IaBZsCjRlYoN1mu1CNBDmNq/AC05lsQfl
         MJgB1HmTjH/HHHI4z11FuL/wRPtU7bec88i9vY+/7YKgz069JXts/9U54eguioHyS5
         +mtXnAFJmfNLprWdYnIQkQw2pzCLduLqiZSTW4AuFjzjYUSBVSQh2nUTyZmxBW2fzU
         e/DKDR+7BkcFJeX/h5H//c/F+q8kwDFNzeEQLHtrGzqTVKswvAT
Date:   Fri, 22 Jan 2021 02:50:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Seth House <seth@eseth.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
Message-ID: <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
 <20210109224236.50363-1-davvid@gmail.com>
 <20210109225400.GA156779@ellen>
 <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
 <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
 <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
 <20210116042454.GA4913@ellen>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0rr86kK5Yz08xea8"
Content-Disposition: inline
In-Reply-To: <20210116042454.GA4913@ellen>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0rr86kK5Yz08xea8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-16 at 04:24:54, Seth House wrote:
> On Sun, Jan 10, 2021 at 03:24:48AM -0800, Junio C Hamano wrote:
> > Note that with t7800 fixed with the patch, non Windows jobs all seem
> > to pass, but t7610 seems to have problem(s) on Windows.
>=20
> The autocrlf test is breaking because the sed that ships with some mingw
> versions (and also some minsys and cygwin versions) will *automatically*
> remove carriage returns:
>=20
> $ printf 'foo\r\nbar\r\n' | sed -e '/bar/d' | cat -A
> foo$
>=20
> $ printf 'foo\r\nbar\r\n' | sed -b -e '/bar/d' | cat -A
> foo^M$
>=20
> (Note: the -b flag above is just for comparison. We can't use it here.
> It's not in POSIX and is not present in sed for busybox or OSX.)

Can you report this as a bug?  This behavior isn't compliant with POSIX
and it makes it really hard for folks to write portable code if these
versions implement POSIX utilities in a nonstandard way.  As a
non-Windows user, I have no hope of writing code that works on Windows
if we can't rely on our standard utilities working properly.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--0rr86kK5Yz08xea8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAo9aAAKCRB8DEliiIei
gSMVAPwMVIrSDBj7v0aFcNs7rljOKC07SWm7yc8+OfJ/U2A4cwEA0Wv3cXqtkEuV
dGb6GZPLz6X4fuyGqpOTdHpSosJjRww=
=SmXV
-----END PGP SIGNATURE-----

--0rr86kK5Yz08xea8--
