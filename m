Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC29C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34558208E4
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PYOj3I46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTVtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:49:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgCTVtw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Mar 2020 17:49:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 966896077C;
        Fri, 20 Mar 2020 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584740991;
        bh=70XX+FdT85tKQyjeDWAHcWIU0F0du6NTbILF/QPoWpQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PYOj3I46NzgW4CWD0Ne8TAHnKqnapIw31/PSqgqDGrPJunq5Mvyswh/dUKBiI3WLb
         rDXEqtm/LrgcSwug6I0mhjo89VwYPNQq1RYOU63mmoVVp2TMtnkWAtGmxza7PLoIVE
         DzHrqfm8hKnjgYCCNbt77Z6/dZBUFMr53knH8e+1L2D2sQH8mG5ywXn7VwyZe0eaik
         8l2KQQO0+HCfs9AFnvucYoomSq68+OAM4EFF32xyCYXWz+MWSKKARloC/IWc0hjM0c
         cPhcgwtF/l4qOo6aBNzdpG1TmJ/04ElYsH9MYbp3C+HfuPmXiRcJQ+uoA7ET8vOJfl
         5RX2Hl8hzB+pWBvBtl1BKwNpL1EpQQB3sjpFTX6ZnhlFedfuJHH4Bo9kuTXAelaDF3
         y2vXbSgdF1AGLTgf+u7VZIQC8Phv+wEoaxHT+qs/Qehhz3KHzLN3P3kw+nIyseaqTk
         OPMd9xBSYrIelRAYE/uhiy4pRxErajp2nHSIvgo9loVkc0tNcqc
Date:   Fri, 20 Mar 2020 21:49:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3419: prevent failure when run with EXPENSIVE
Message-ID: <20200320214947.GH366567@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20200320213916.604658-1-sandals@crustytoothpaste.net>
 <CABPp-BGiP7eG7Ojt8FKV5PUBFk74pkO6jnOwJEZbDzBjdJUm5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <CABPp-BGiP7eG7Ojt8FKV5PUBFk74pkO6jnOwJEZbDzBjdJUm5w@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-20 at 21:44:41, Elijah Newren wrote:
> Good catch, thanks.  Perhaps we just want to invoke 'git rebase
> --quit' and let it clean up instead of manually doing so ourselves,
> since it may buy us some future-proofing in case we ever want to move
> the place we store rebase state?

Sure, I can do that.  I think there are other people (e.g., zsh) relying
on these locations for the state of the various rebase versions, but
nevertheless it seems like a good idea to use our existing cleanup
tools.

I'll send a v2 shortly.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnU6egAKCRB8DEliiIei
gd1JAQDA6rms3LAHmmdCClJjQkgNp3t429u1uqakECUTDdOcBQEAvTVhJ3Fsx/vj
OrtcmP7FXb5jwMKtzU/TAYKRFakMews=
=Cuv3
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
