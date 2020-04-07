Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6CC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63CF20719
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k87eaaSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDGBHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51628 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbgDGBHP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Apr 2020 21:07:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AD2D26052F;
        Tue,  7 Apr 2020 01:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586221634;
        bh=GQGb8ouU+iOIUBfl8kou8cgQtDX/ilSr3eSog80p9s4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=k87eaaSKeLn7qEiNf0Pzx2YalCBd4w2P6gsJt7aRiFOLuJzthh3pkVOywj/XJiLu3
         lN1tEOGOmqQ3U/wTtgQO9SZ0bEyofLT8muQ3C8ZeBRGzqMddklSioPeIk7x73M13QM
         DuKfVxkfqQOm91IPEg9f3v0kiiDrXsJuR48C6NEVPnI25lMNTq/J1Px7LkgaK1Vxz6
         R1XxG322DBsW1bE2oo5P6lCWIVTYIjkdzZza5Rm6BuOVYwMRuz8iKcVpLU9CIZooAY
         EzTMvzBlydwa53fNXrNKO06hYA6kMkdiK/6vzm+C0WtXAQXk2Y4s7KiR8IY5ndyqsB
         u7Qj4AJUX6ST2a/3ej+593pd/cx70xzK9Dd5pDb8eToNJ4qAl96ptdBYPaIsmhUIum
         QY1zNwVGdttS0UboObkVmBdgtnXgyOZHqmPwq7Tp2U1iVsgQrbayn35qI6KCeC1cXX
         9CQ0HaU8j3Ge1zaoaKd1beieBkPDYYNhPvA6GuRsCrZOqfSsvT9
Date:   Tue, 7 Apr 2020 01:07:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH 1/2] gitfaq: cleanup gitfaq.txt
Message-ID: <20200407010709.GK6369@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        emilyshaffer@google.com, martin.agren@gmail.com
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
 <20200406181216.5340-2-shouryashukla.oo@gmail.com>
 <xmqqy2r8tbxn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sU4rRG038CsJurvk"
Content-Disposition: inline
In-Reply-To: <xmqqy2r8tbxn.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sU4rRG038CsJurvk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-06 at 23:46:28, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>=20
> > -How do I ignore changes to a tracked file?::
> > -	Git doesn't provide a way to do this.  The reason is that if Git needs
> > +How do I ignore changes made to a tracked file?::
> > +	Git doesn't provide a way to do this. The reason is that if Git needs
>=20
> With or without 'made', I think the header says the same thing, but
> I guess it does not hurt to be explicit.

I'm fine with or without this change.  I think the original is clear to
a native English speaker, but if we think it will be easier to parse or
harder to misread with "made", then I'm in favor of the change.  I, of
course, cannot speak for how either one reads to a non-native speaker.

I'm not sure it's fair to categorize it as a "grammatical mistake",
though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--sU4rRG038CsJurvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXovSPQAKCRB8DEliiIei
gc4yAQDX+1tjVjuAhHP+kQ/tJlGAQfMCFaqF5K+V0ZDCWSfAHwD/XbcMo/K8ntVA
AILZa60yLXCdw9LGuJviRLjCIsaorQw=
=5qjo
-----END PGP SIGNATURE-----

--sU4rRG038CsJurvk--
