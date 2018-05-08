Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE1C200B9
	for <e@80x24.org>; Tue,  8 May 2018 12:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754951AbeEHMzP (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 08:55:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42362 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754777AbeEHMzO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 May 2018 08:55:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2620:0:28a2:4010:3238:4f3a:179:aaaa])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 73BA260444;
        Tue,  8 May 2018 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525784113;
        bh=Z4yrOaGBhPrh82UodaIhO9Ew7Ix7dAqfM4Voe27dRPE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hczonY8EYJ6talqHBrNxAkV5KqApr2Ey3g1A7JcDCuNzxaCwdFOvtNiujw/SxX0Fa
         FBW6KeF5CMsh/TpRWPO53kQiPn63bOU4gmVLUvoTC2h2U+XQnax+E8gpC4jHUcLvs0
         3+snte4VC9ep2ibgK9Lh0XcDYBgkovgPDPxeaxWpZm7phNWldp3dDLxQEX0rdnMAvu
         IOiq3AEdAcGcGoCKNNWpBeyld619THx/gl0XxwFvAE5g+7OeMqpYZqtDiImNAWVGdA
         qe7sOGfGweV8ABXSr/4gqvpUMfeVUAx7rd0iPvmBr2lPSrW67DKkbGqEFvm744a2SO
         0UCXU1UdI+NRw+rNy4yfZ2Z9/H8UoGgdz+AHMwHDv3A4/ZJt5LLj0DMk6u8bOO2sZ+
         4kiVyDAZmpXliXYaYufRj+zJsk3o4Ph/I7lR1Xk1lFAXWXqVDjTroTxsmb1KIodIb7
         MzfRev5YC8ZlSJAtLyB1M/8/NbnrTFCcYqE+cZJDKIcaCv+gd5i
Date:   Tue, 8 May 2018 12:55:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: main url for linking to git source?
Message-ID: <20180508125508.GA275488@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
References: <20180507063713.GA28961@sigill.intra.peff.net>
 <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
 <20180508015130.GN953644@genre.crustytoothpaste.net>
 <20180508024658.GA4204@puremoods>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20180508024658.GA4204@puremoods>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 10:46:58PM -0400, Konstantin Ryabitsev wrote:
> On Tue, May 08, 2018 at 01:51:30AM +0000, brian m. carlson wrote:
> > I think I would also prefer a list of available repositories over a
> > hard-coded choice.  It may be that some places (say, Australia) have
> > better bandwidth to one over the other, and users will be able to have a
> > better experience with certain mirrors.
> >=20
> > While I'm sympathetic to the idea of referring to kernel.org because
> > it's open-source and non-profit, users outside of North America are
> > likely to have a less stellar experience with its mirrors, since they're
> > all in North America.
>=20
> I'm a bit worried that I'll come across as some kind of annoying pedant,
> but git.kernel.org is actually 6 different systems available in US,
> Europe, Hong Kong, and Australia. :)

That is very interesting to know.  Perhaps it would be useful to update
https://www.kernel.org/category/about.html?

I did specifically look to see where various mirrors' servers were
located, although I didn't actually test for kernel.org since you
specified on the website.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrxniwACgkQv1NdgR9S
9osOFA/9FUKegbPwypese+/eW5KUYk4lDM93ltvg1T9LQfb6asVRb3Wfq8I6QaQ4
PxaJOfdrlN5lRl3+n4xJR5BI85RkpK/cFmA+Gxjz3ATyTzbqmfEgU4E2LpWw74lh
/z9Agv173VmPgGdw0MxWbY3QBOGOg6k6HMDbHB2ItjyGHumA1Clq2nbYrka5pB6S
I6etL3sVoxvVbEGPBfct9/HgCP+O7BAmOUCMDL9SJbkJ/wIg9j5apjGQFX9yLqL+
Z/nLTTKN7bdZ1cNoC/BLd43vM5FSM8l4SVhiu07PXMUPlRovfv+/+1n8hmmjLz9j
zrAcxLQTbjCyada4g59vWRPmQAwijJZutp2ZwMe/g1vN6hZJ96clXsQriw/4ObNg
z5+017IIHouDGcxCzWOsI5YoFhiTjWIP0Xq9K9ne/z1AyeRIWJwLX73FqyVnr4Cg
TYJUEdSg68LzCogVZTwDSAnBPjrMOx3MpUnu669Ug12ASwI0srUi8oBoXlInOius
+iiu99f1HLKHcGvF9xNI0L1Z0wpuYNr5S92U0LYoGHtTZQtB/8EqJ9pryt5EAyjl
3hiiYhmIW3cISsklrBunXtSxw4QIm9dDRNdalXLq14hLf8y/9ARb/Vuf8omITf4N
RjnoA7U2xz3e2x/6mDd6odysAuNphQU1bja7Z41cJPw9bxuifKI=
=+I5v
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
