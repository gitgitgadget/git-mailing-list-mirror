Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9CC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 02:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316C42173E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 02:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Bev1RL5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHFCOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:14:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41374 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgHFCOA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Aug 2020 22:14:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 98D1C60799;
        Thu,  6 Aug 2020 02:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596680038;
        bh=EfvxbwJxFjeW08lJfUdJ4s0aLh6aTJCze4zP6R91PvE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Bev1RL5RWiEF/Y6AbS3aNViUXQSHAvyGOfC4d/YyQx4Z6ZAj3Pn3loZLhTJsCttr8
         9Hmi4zyMCEVIdsoB7JggFnqqpI6PFRTtCGomXo5nkimbCyuYmGYFnLVzNiAXoHSsHN
         CMVDugOSG3iW4s8XTx1NE5xjp+KN8Rp9BgImhdUNlE2eTpWebyzOYC0aTM49qQvhuA
         EmIf23DeGPRMRMEpOILxnQUjBwE+Mvz1QMFrNecf3e5GTeC8ehjXwjThb/ABmxJYkr
         SAi2HCBrlf0Y+sgUUii6hL+daB9AtkHgQekDzdTsBBsidHfoe2exqZ6Y2gKVFdzPtm
         7Qx3bxBXrSzY5JOAoreifO598wkXy8QPdNQ3hZWu8a0lOcSmjtjao7l7F8+Uqewfzy
         uuwl/oGBMGjhIMSHOirZreAzfgWoAcdncVM+8xYUsuwOIXEBYq4mECoC+bcjQtJMJe
         6ZDtUzGf/Fu8jhKCSzRxGENJJ/KmTkZcEvZ/VkRwRJ1qzWab2jy
Date:   Thu, 6 Aug 2020 02:13:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "KADOTA, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH 1/4] Use $(SHELL_PATH) instead of sh in Makefile.
Message-ID: <20200806021354.GS6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "lufia via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "KADOTA, Kyohei" <lufia@lufia.org>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <1f63b4fc7c2ae1970d7226bbf0b66901528fb9d8.1596675905.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Content-Disposition: inline
In-Reply-To: <1f63b4fc7c2ae1970d7226bbf0b66901528fb9d8.1596675905.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-06 at 01:05:01, lufia via GitGitGadget wrote:
> From: lufia <lufia@lufia.org>
>=20
> In the not POSIX environment, like Plan 9, sh might not be looked up
> in the directories named by the $PATH.

I think Git's editor handling assumes that sh is somewhere in the PATH,
so it might be fine for us to just ask the user to adjust PATH
appropriately before running make.  I don't have a strong preference; if
this works on a standard Unix machine, which it looks like it should
(although I haven't tested), I'm fine with it.
--=20
brian m. carlson: Houston, Texas, US

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXytnYgAKCRB8DEliiIei
ga49AQCdGtTEM77h+OMNj2beRuo2OL78RWgq3+wi27Y5qrkCYgD8DCQtGgTwpXYv
P1d3A9WgpnivXBBh7FrE0GeXs6oqjwk=
=XajD
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--
