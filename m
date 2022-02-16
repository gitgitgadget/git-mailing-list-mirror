Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F25C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiBPK3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:29:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiBPK24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:28:56 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AF21D425
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:28:30 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 68A4B5A062;
        Wed, 16 Feb 2022 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1645007306;
        bh=NSx1TLNCtW5Fshz2SOAnr75AQi0A2oBFWbU6xamgvBE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=azmHUIAC3xfmPvIHZvMvKSYIYZyfC1OllKoqC0qtlcvFGLNvo5K+yRi8b+5iE3ztc
         ZehTLJRuJuJzhgBujthfHOc00rSSllCLYfybD7/fzXoBRb8pn9JeVzFVC+YTKuVsvk
         HQ2HJ036+WQ0S1J2KZSMnqlyMU7cEBwEmV4ilbC7PZk0OQQewKR574MOHayvuPKseH
         dAwQAnmx0dHwGZgEzjcNSeWH99DiyYyEShUKdhIm6ayqT6cMQtwhaMfybF/V2ayHC6
         GLXCaqTrLMBrxkHI2o8B3mQOnOl8l5+ZY9VuWfHOqHxREACK36ROkyut5IyjmUjcYT
         a99w8ACBnyXIb8RS1pb3gPesVcEbCyL4ohqkGqKBntouZRFqRBJBIsYhCOt8MKJH8E
         3LpnFOEV7oQBGYsVa00E/TFKoEk6FhRwLh4XHsJUajOCk2wH92NzcWTPI5rHlmhjse
         sQjYiQqZQvjm7SMUhIRhKeTAclpEMjxv16+xL4toW8OEmmSAsWT
Date:   Wed, 16 Feb 2022 10:28:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Message-ID: <YgzRyKZwsPw6rTyT@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
 <xmqqilth2u28.fsf@gitster.g>
 <20220214204631.mquj645jt5qajwku@tb-raspi4>
 <xmqq8rud0ytj.fsf@gitster.g>
 <9ab7761a-ff63-f809-47af-033825e5779e@kdbg.org>
 <YgwtMhuODDcVWEd6@camp.crustytoothpaste.net>
 <9ce63b16-cf75-3404-88cf-0623194db07b@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XtnbrmpsgaXQI0AY"
Content-Disposition: inline
In-Reply-To: <9ce63b16-cf75-3404-88cf-0623194db07b@kdbg.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XtnbrmpsgaXQI0AY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-02-16 at 07:00:24, Johannes Sixt wrote:
> Just so you know where my confusion arises from: Your updated text has
> the structure (as I read it)
>=20
>    if ... set or unspecified or if auto then ... detected ... and LF
>=20
> It is unclear whether the 'then' conditions apply only to 'if auto'.
> Even if the additional 'if' in the middle makes me think that the
> 'then's apply only to the 'auto' case, it is sufficently vage because in
> my mental model there is not much difference between an 'unset' and a
> set-to-'auto' attribute, and I wonder why the 'then's should not apply
> to the 'unset' case as well.
>=20
> Moreover, after re-reading the text, I notice that text may be read as
> "this attribute has an effect only if <conditions>" where <conditions>
> basically means "always except for when the 'if auto' case is not met",
> right? Would it perhaps be better to write "has no effect if <very
> specific condition>"?

The situation is that eol is in effect if and only if:

* text is set;
* text is unspecified; or
* text is auto, the file is detected as text, and the file has LF line
  endings in the index.

Alternately, it has no effect if and only if:

* text is unset;
* text is auto and the file is detected as binary; or
* text is auto and the file is detected as text and has CRLF line
  endings.

I'm not sure one reads significantly easier than the other.  I slightly
prefer the former because it has fewer conditions with multiple nested
entries, though.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XtnbrmpsgaXQI0AY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYgzRxgAKCRB8DEliiIei
gVE6AQCCaoFASaSaAciwCM9qIhDS6Vdz3Rf68CCEV3NUfX65XgD/UZ51Bs/dAVHl
WGK2Yw6R7P0ZTfIBa4yb4BpqoZ6cMgU=
=JpyJ
-----END PGP SIGNATURE-----

--XtnbrmpsgaXQI0AY--
