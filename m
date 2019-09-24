Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510521F463
	for <e@80x24.org>; Tue, 24 Sep 2019 23:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442100AbfIXXhg (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 19:37:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442097AbfIXXhf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Sep 2019 19:37:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6D15A6045A;
        Tue, 24 Sep 2019 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1569368254;
        bh=sgEMv4NO7M69shZlschpnqdflp9HEUVGddwTWqjy+Ew=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=n2FRUrm5qknDzS0g454GRKaeq4D3K164PXfflUOEILROHnQc9uvpyfRXL4hfN6EzA
         p+fJkeVqsqJsREnU4N2KUQsSRKRixSQjAVzNPZpbDCn93bYmfuVn45IOYTDT760By8
         DdGZcaDcTwGJLSTs1Sh+a4x3vISVWh6fT5fktIAH4bsWeXDfvup0XrWjf/glk8Bf09
         EI1bJEhf4xGeGPPfKjUrSWItvl3rRhkYTBwbuqqgVqgx0dEDW8RGE0kjn6VHqlad12
         VeIMLJRHTiLCpQKMK74xvWsHwrPVwSx/98JK6xukHxP21TLcUCfAEiHU8N9+l6jwM/
         lc7J/kgqAi3JrxV/lwKnUEwdgigIf8DIiOga4Auqx6+ybmjVgJziNVbl5M0hl/2x0o
         dKKJmEGcYYWTMRQ5mJqQnvf7J12qMXUwOrGVgb9YfzhpWgy1g9lxJ/Wnd8hbl5IN3G
         mSzEZYz565ahJ8oXKEV/isv+wO2ffYYdpMeO34qAPQUzbYLiuOV
Date:   Tue, 24 Sep 2019 23:37:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924233728.6iueqaktlhhfwn7k@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
References: <20190924064454.GA30419@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7aqthwxoetbrkmh"
Content-Disposition: inline
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-rc5-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--m7aqthwxoetbrkmh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-24 at 06:44:54, Jeff King wrote:
> We've never had a formally written Code of Conduct document. Though it
> has been discussed off and on over the years, for the most part the
> behavior on the mailing list has been good enough that nobody felt the
> need to push one forward.
>=20
> However, even if there aren't specific problems now, it's a good idea to
> have a document:
>=20
>   - it puts everybody on the same page with respect to expectations.
>     This might avoid poor behavior, but also makes it easier to handle
>     it if it does happen.
>=20
>   - it publicly advertises that good conduct is important to us and will
>     be enforced, which may make some people more comfortable with
>     joining our community
>=20
>   - it may be a good time to cement our expectations when things are
>     quiet, since it gives everybody some distance rather than focusing
>     on a current contentious issue

I wholeheartedly agree with this assessment.

> If people are on board with this direction, it might be fun to pick up a
> bunch of "Acked-by" trailers from people in the community who agree with
> it. It might give it more weight if many members have publicly endorsed
> it.

I've already mentioned that I think this is a good idea, and I
appreciate your thorough rationale in the commit message.

Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--m7aqthwxoetbrkmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2KqLgACgkQv1NdgR9S
9osg9g/+IsXDq0LqWlen5Hcp7TNgZrEX8w87fYTPOxmQ37HTyEa5Pu1qS6aOWw44
B1pRg+rF0TAs6U4T8+JElXgRa6VALiyRQ8sliTuwaFizs6iPJjkBMyoNC+C3pdnA
invM65nDm3oOBcUF+ZpyCwSGxJPGAdy2UFMwa0gga5XTei6UKQYKFZzQIBrx92p2
noGyZYG3LxkQ3JXYfIc5iz3g7YdoW87pLUm2moThepJucujCnaZXdvxv39FzqY+f
Fgyx07rTxZbRFm+WS2IAJ/ABdieDUODcLJ1GyWABKd/8QaBSFZ355j3lKj4yN8cx
9uF9tvvgbg6w6hrQ9Ohkpipvyzje45jTLD/Gz7acisb/knRdIJqYDC7BK+kDOZ7V
iGkoXSXyjRZSjVwHG8HzMOMSaYbxq8qsWzjrUHheVX0DlTSWpR7WEj24ULVuaO7O
eAefvawzdmmMisRuvr+P39MwEb+/wb4NvU8//R0cAvLPcLtOSyq6s35GuudMXPUX
t4tAggjcfcpJJYPthU+l8in81ESRohdpgyOd8uRHKCVeWM88+jIYWdaSHkrU+VTl
6SDfpXbNR8F+NdWoGW3yyBNvy7vSSgkhS4d9bP2izCJ2wbj0mWAXuAXtTIsyz8VS
3KKOFQAxI4tu3Serz15KxtsgRcAt4LiYlnAQ1HQHUrjN56dL3A8=
=sPBF
-----END PGP SIGNATURE-----

--m7aqthwxoetbrkmh--
