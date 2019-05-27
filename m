Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D731E1F462
	for <e@80x24.org>; Mon, 27 May 2019 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfE0UZg (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 16:25:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36762 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbfE0UZf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 May 2019 16:25:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5881:abd5:52a:5d54])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 09B3260443;
        Mon, 27 May 2019 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1558988733;
        bh=XSVeiMYeVfJ3/s/tl2zgYJ8ukiXvztzgu1KLzW76UOI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pMCRRcVp3WoT1Bu0U67voh1AEzounvcN76kKcEuqcZE4afjhYlWPctA6kZdv3sj6j
         ywJ+7WKPIzxn7But1sr0uUwHngM5kPTZxeKJQHrEIWWppeLu6NfmzB00zeJFK46MHF
         Zzc5noW+XXSZMtpCIR8zFverrxSHSwC8Psec5oOXEEmyOxgPL3X5TOCTy+sr3u/S5i
         OYEZDaAvV4xx7X5GP2SEkbs9W7AR3LgUIrxWRUzocjwawQECWPjgbCgMI6vlHsqRkI
         0mnk0RrFpS38dD+SBvJVi3iLpk6Tn8ttIJrjVjkwFwPXwHBJoWHiWwysqaboCWl1wg
         +1W3V3/puIAzKI00TS7Zb0rVRGL9IY8Wjb8rAMXKQBekruGjG+Ka8LRAEpAaMGgEMb
         XydIHsKQQyM3p7DM/g/5nEU8dL+crngAcynqU+T/SKjnqpGW4JKwQlUtmClPMbIhSB
         0nfILySnmfoL2M27hy2N7RYMdw8FtOXH7sqLMQfpz2IYSh1mUN2
Date:   Mon, 27 May 2019 20:25:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] bundle verify: error out if called without an
 object database
Message-ID: <20190527202528.GG8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.226.git.gitgitgadget@gmail.com>
 <pull.226.v2.git.gitgitgadget@gmail.com>
 <8467593c158ffac56897cf02e165173d9c0b5880.1558988458.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <8467593c158ffac56897cf02e165173d9c0b5880.1558988458.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-27 at 20:21:00, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> The deal with bundles is that they really are thin packs, with very
> little sugar on top. So we really need a repository (or more
> appropriately, an object database) to work with, when asked to verify a
> bundle.
>=20
> Let's error out with a useful error message if `git bundle verify` is
> called without such an object database to work with.
>=20
> Reported by Konstantin Ryabitsev.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I think this looks great.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzsR7gACgkQv1NdgR9S
9otw8RAAurThy+E3QI3QnSlJlwO17F10LATwshf/2+AJEmZPKvI4W1mZvxUhd6l2
acf6q7OYrvntT8icIyAIERuf+d98CKkNQw1pl5FQagQqUTSpQ1qLXjiq4+v96okA
tdE4pADFr6+SOMLtSV0Q4emnN2Fgl0+eeuQyPtqnecXlJxhI912wED///j/JPbM2
oeJ2iuLO9Cd4YmxbS2/IQZTooctXFbxyacJDLhCKPCIaRYcT97A23cG/kV9Ww/68
W9SFwS8Lk+e/8ptOzBsYP6aqnGFTQjj0wmxtWRv6CQECas7wmVhl0NrlCkzqUX3q
mqaIx9ZB+ZpscMql2XoMfYffumCJxYDmbuGQAHosIfDPT+7SXVOrT5g0HJolffv+
q7nVcwKdiGjp7KQSrMfVBubkentBGIo0IAxv0aJINa3kwgjbNiARNGleXyC0dA20
k6IxzU02cwsCXfzWnzCpoOxzjsCxQKxAcz64SH2VFlzAO4aiixnv4sTi54tMWHT7
n59fuRt7of8vucSYyabgEj+cVEusBQtgq3/VmG9T7gRAaAKD/UzqhA/Z2TeOIkYe
47d2Iue32KCH2WpxbWBAypHeV1tAmhVe+yaRZiCtAQz6uoBLnRziDQANTv2b9iyP
iilQFMg+C5lHsUBFhL7aAqxHYEbsugaPCW1bf5blP75PpoHbxs8=
=v9hB
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
