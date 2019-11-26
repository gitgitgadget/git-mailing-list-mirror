Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECEFC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137D12071E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mFMySpZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZAo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:44:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49534 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfKZAo0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Nov 2019 19:44:26 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F7E260446;
        Tue, 26 Nov 2019 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1574729065;
        bh=EWyJTyrqcYDzM82HCkvKuAo+TSU2GWMBzKrldBP0Dso=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mFMySpZoa6xwpuatS2qf7dCE96RGmUZWnBu409J9A89bjL4/yOSaiu3nwejxmiud3
         48MNpNGemLztJaAS5JBMWb1F4PqFoTEOAmJoRYk19Tzr8hs19bS0GRHPG297/OWfkn
         dfBm5MCUbFLhyjrcTA5UltFsxNDuTOJTdMXpgxvW8yfNCHoesmGm0t/ORqEU0ZfNcK
         LijEbCvlW59x2EDr4QxZANM44BoHHetRXN9UL5ltPi9ckH9RkD4Ma1rsisFv6SDq5G
         kcCwFm+EdGxTtsOJDxrRl+NQz9DFoBR4axWV8BNiFxYb7JF4RdJOy3XCxVzmUpJRP9
         VnH3Ef/e4RJDJ9ZDn7UsUhGBg3vQO8AbwzYrHSvwqqoxc56OLZeS7zloOYq4UeZfTm
         qX0v0ZSa63jrEYVyk02GH+ZtntmIs3qzlpAr7IpD1z0PHwP/YUHPrGZq/wli8AJt6n
         SjjPWF/82zTQhvXecmdqoG2boS3UW8pNq1Z6i1lZQq1PZ8sRdzo
Date:   Tue, 26 Nov 2019 00:44:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ed Maste <emaste@freefall.freebsd.org>
Cc:     git@vger.kernel.org, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH] ci: add Cirrus-CI config for FreeBSD CI
Message-ID: <20191126004419.GE2404748@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ed Maste <emaste@freefall.freebsd.org>, git@vger.kernel.org,
        Ed Maste <emaste@freebsd.org>
References: <20191125203740.72249-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <20191125203740.72249-1-emaste@freefall.freebsd.org>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-25 at 20:37:40, Ed Maste wrote:
> From: Ed Maste <emaste@freebsd.org>
>=20
> Cirrus-CI is relatively unique among hosted CI providers in supporting
> FreeBSD (in addition to Linux, Windows, and macOS).  Add a Cirrus-CI
> config to facilitate building and testing on FreeBSD.
>=20
> Signed-off-by: Ed Maste <emaste@freebsd.org>

I'm all for automated testing on FreeBSD, but we would need someone to
triage and address any failures reasonably quickly.  Is that something
you'd be okay with doing, or is there someone else who would be okay
with doing that?

> ---
> 6 i18n tests are currently failing and need investigation.
> Example result: https://cirrus-ci.com/task/5394512637067264
> Test log: https://api.cirrus-ci.com/v1/task/5394512637067264/logs/test.log

Could we fix these issues first so we don't have CI suddenly start
failing?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3cdWMACgkQv1NdgR9S
9ouH5A//YhxAGb+2bY15LEKyLGNiKrkl74Mck3s4bw1P/++GtBWyF9ZAPDhogSr4
J0zyklpGHecs5eMPWznehWvxXVUZpLHsxySTKsaQ1KEe6OhkF6GnSP81leCqhEs8
DFC0WL/syUV90DQ9DcMee/qjsWoh7rcIXbofvdz6cp2XTRMgTj42+Psvg/RkAnpH
uTUNc9DRRzsPgaqLjjJHaaYiCJ5Rl4qelvtCcmrexv1I5BZ+/lJU2Wp8DcEfvo/n
8dijPFbfLJK0glQqFaCTDIAwMtGIdDAI+QmAYgDIHIx0Rs26UfcwjHW1tuJQG2k8
xrpA/DnJpKDGEZSVs1lMDoQTxoWDjfH7iNWX83r6Qw7jfhSKSAbgIbWBuqdUy+ab
9wozoN99oJNla+ky1/0ZHeW0BRo2stBeZr9ytmf0gjbFG5hMYoI1oLCUznE0ZoSH
aLHJOF+s1934/BzGY7blUvbG9ruBNmbShT+qFFz/7+cTDY/B/JBOQ1FcPC37zBWx
e5Ju6lmoma9gwWZ5oTgzO6mJhkkjkI8jFlLkuzS1Sr7KvtrvuuDELVT3G0eFIyjl
JjaxOK+5acKyYSQa/sjPcdcG2LPAb/ayusvfWs5RGsBw7Rm1gtzpSZDjYTfl9+Yf
xPyOs3t7KrjGhlY9vh9/Jkd1ewFUTdbDQVo+/tFGlAmAjqJnl2Y=
=TjRr
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
