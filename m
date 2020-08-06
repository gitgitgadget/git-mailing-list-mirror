Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA23C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 02:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA87022B40
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 02:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hcUgQ/SL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHFCX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:23:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41384 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgHFCX4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Aug 2020 22:23:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E4A8660799;
        Thu,  6 Aug 2020 02:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596680635;
        bh=JvA28xdjI8CfYo+Q0kwaRwhSY8Go2qqcNwzCxis0Q8o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hcUgQ/SLYlZwx1DVGFsYjoZ2TDWzxAaQn5279aerLd/4TC4erWamdhDtXWgV24x1c
         8CfDZYc8f3adEkFF2u8qmlXwQiNr7MGCIZzXd9A9zvz6/OMfFZPbJHPH7zqI57WWZo
         qdacleouQg8ePMjKttNXDjrEQ46QIyXrvfzOa/iCWuGqzH/+6hBB7YtfxT+zdGRxL0
         1K2HadUSS4QxqDkc0lCcIPGcMMyJrQwi3sNLnanTYBrXlEz+siwhBI8EQrR5EFZ8BQ
         w9W5QpreHjRBSJ2Igwkb3oROpgT5chnTAJMdYI24GtKzPKG5i3rnePdIHq6uDSzL2F
         Fj/Iq8OOLHN584fjzCEoe5OF6SOOQpTrr3s5PrgWr+U8bQ6DRtC53fX7pm8wnqauW2
         eVJKImKqJucukHPLJdESOtQE0JVjzaoLMLw7LpxOLX3PPnAVIsHg5Q8LZvgWcDZqiI
         t81bBTilJvkIAjVpI3zeriuThLDNKm6oqmBT5Xm2HJ3lxaPQkCO
Date:   Thu, 6 Aug 2020 02:23:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "KADOTA, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH 0/4] Fit the building tools to Plan 9 environment
Message-ID: <20200806022350.GT6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "KADOTA, Kyohei" <lufia@lufia.org>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="teKjxxMjPsACTz/N"
Content-Disposition: inline
In-Reply-To: <pull.694.git.1596675905.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--teKjxxMjPsACTz/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-06 at 01:05:00, KADOTA, Kyohei via GitGitGadget wrote:
> I've posted some commits for porting git to Plan 9.
>=20
> This pull request is thing that cut off building scripts from #305 and is
> re-constructed that.
>=20
> I expect this don't change any artifacts.

I took a look at this and left some comments.  I expect you're going to
have your work cut out for you in the test suite due to the lack of
good, modern POSIX support.

I regret to report that I looked at the source code of the ANSI/POSIX
environment from the Berkeley release and found that it's mostly shell
scripts (well, rc scripts) and has all of the functionality one would
expect from that.  I suspect that this will not make the port any
easier.
--=20
brian m. carlson: Houston, Texas, US

--teKjxxMjPsACTz/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXytptgAKCRB8DEliiIei
gYijAQCr7TTOW+M8X+k8PxDmXeX7xzHgwkYBWv5M8E8LQud1ggD6AoKpYUH/2FTP
qBAZaYHWjaqFc1y1ulADXA9UP4zTRA4=
=T8dd
-----END PGP SIGNATURE-----

--teKjxxMjPsACTz/N--
