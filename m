Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB581F462
	for <e@80x24.org>; Tue, 18 Jun 2019 01:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFRB3w (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 21:29:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60284 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbfFRB3w (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jun 2019 21:29:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:8174:fea0:25b6:f16a])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A325605B2;
        Tue, 18 Jun 2019 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560821389;
        bh=njE42RNlZlJ4NWsjC9T6THavUyJCLYiW/bJFsKyvNLc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PtL058eJKgd+mHXYI1hPVZIylz4Y5RU637gAZO0xASxeQl5euGjN5EJn7ukZQCONY
         BXC+BmuzM70WDZ45CEKo478D3eSivyp2iShpozjpcxW7YDjrNtIVIQMD1Ev0K3LMdj
         w0/mFHu+VRIRd797xOyv/rwxLfOq+Aem+/Zna1stxkJV9Ut6+QwwmGGY4ccQ/gDpIZ
         bpnu70uGw4HMvto37dTHyGAZJ3XAQgHRYWX8TxsDsLuiTH5tpP9YEv87wh1WjodXvQ
         56jZwj1FNWHHZl9GMgDZ9FRh67htMud8CZ3hEUAYwwH7uZYv530VnpWH+iic+w+9Cd
         Knz8NS3pglqWOJULdM1Rp+sTmrFWxBB1QXpkvWIzeQu0T5RJ/JW8O/XhKigNez2e+5
         i0crmXxzP7fOPIp9KwZ1uelfIBEb4AwpaCOiMNf1j23scvFI+Rso8ZvpmCWj0MYDzi
         Y0riQNbSIVKqHKMAhQA5slNwuM5KI6+xO2xHlDF1gpIKitleZI2
Date:   Tue, 18 Jun 2019 01:29:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
Message-ID: <20190618012943.GB8877@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
 <20190616185330.549436-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-17 at 19:05:03, Johannes Schindelin wrote:
> I guess it does not *really* matter all that much, but this does spawn a
> new process (and I think it actually spawns 4 on Windows, for reasons, and
> spawning processes is super expensive on Windows).
>=20
> We might actually want to think about using something like this instead
> (which admittedly looks a bit like gobbledygook to the uninitiated, but it
> definitely avoids any spawned process):
>=20
> test_oid_to_path () {
> 	echo "${1%${1#??}}/${1#??}"
> }

I'm fine making that change. The original design was because we had
other code that used that technique and I didn't see an obviously better
solution. Now you've provided one and a good justification.

I think the complexity isn't too terrible since it's a one-line function
and the comment adequately explains the behavior so people don't have to
parse it to understand it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0IPocACgkQv1NdgR9S
9osJKRAAtvsJE25aop3VP0Yd5OZnyiskKxtLNfEQwIhAvpTuc4nmX5rX5/1QKu4G
eBCnvOGQPUDTvFdtCnUOrzCavBlrz0shTM9Roobxz908wvWSQn41lGTwZvOXdmb7
36La/ynyvy/lyEtkJANPjhp8l2F43zJzvuEqwBd8oGcpZl0YRDTTboaBqwBkFOPS
m26O2jZs7qX0jqlHY8UNOQLeWYKkD+KIcu852A8ZqgFTXBSwEnzwphbZ49/rVxJk
Np2tbxK+ykPe5CWQLbeIRvhRHuI0/4UU8x0y6yca4Avmbh6QKWjuB+m60EJ9MxVA
Iu8zSfejZvB9+xo9bQjgSe3Iafry+my5HVjJUrdv2TH3IXlcZOyP59q0xajL+e8q
dI3g3GKYKvhn4bBL3GWM17nmSoIdpgEPw/VVlTX2byzA1t3yizkRRPtV3w64iNQ5
3v/fX6sEJIAVwV8JOQJmdShO+Ix0KPPd43McD300dnsJYtCZCarAxWmU0GllOpBm
i6mZp2H0njBhhvQVbBDLNsVo4XKk6uWgOnWFD3yRpKSPAKyOHe0cX6llzYWUOeWs
w6vf61qSsokAdf2Bbro+7pEhYDduh8rVT/19tLVtZ0MARpUGXtCvEkltaTVylukb
bEwFkEeRkHk5KnyKycQ+ReAR9hj7WiTmOXKz8yHDDgipdFmsBeU=
=beqa
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
