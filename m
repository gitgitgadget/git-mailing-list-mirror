Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18C41F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIRDvW (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:51:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59952 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727672AbeIRDvW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Sep 2018 23:51:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:68ab:e3d3:c0a3:4717])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A1F9E60482;
        Mon, 17 Sep 2018 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537222923;
        bh=K1nxHcfHGcM+Jh+ktWRaNnDhiGEtO3ITanDCUAfiT08=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bjEF9tSpBlWfgdNVVCmzwQZyuLy5Xv/hDa9aVW1mtqDFvw5QKh6qrqSdbTn23Rk2e
         9T/oUZEnKCdRHgaW/fF/1sk3kI+Zs4gif/lwojWeKIilb9pGRfr6SJSFuk83DRehnP
         J7zMTB2MZ5PtQhT3opU/E5Z6juIR7VhsEBw2ktzESxyYbq1CAG+M0QKljrgL5MCLSh
         TIBIj6m0Nvsyg9Mi/sAdnjVuO62dQNyFdbidH8eSW2clqXUWrN6lJsq61tXovXXchu
         L+JOVMUdAIqznYDoum8fPRtUeFxHc98wjlxnT4sZmU66g/NpsdbVh4w9ftXeBP48P1
         uNHBvNQV8nDxXHuBhKQ2ZWG4E9jFxdy7I+kUruLkXtGGMUqn/qQduNAn7FG+iWZlu6
         0UoGJgwEDYGrjUElLRWsefqgXkt787eaxVkGCZ2tTFlWItFmyu2auqdlWFeO5H58Ks
         v5gnGBkXVyffDRJ8Pi672cW+JtatjZ4or4/OmsfuykfdmsPm/G2
Date:   Mon, 17 Sep 2018 22:21:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] mailmap: consistently normalize brian m. carlson's name
Message-ID: <20180917222158.GY432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <20180522220826.GP10623@aiede.svl.corp.google.com>
 <20180522224215.GI652292@genre.crustytoothpaste.net>
 <20180917181800.GA140909@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Efge0/SQAHHP+Pr2"
Content-Disposition: inline
In-Reply-To: <20180917181800.GA140909@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Efge0/SQAHHP+Pr2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 11:18:00AM -0700, Jonathan Nieder wrote:
> v2.18.0-rc0~70^2 (mailmap: update brian m. carlson's email address,
> 2018-05-08) changed the mailmap to map
>=20
>   sandals@crustytoothpaste.ath.cx
>    -> brian m. carlson <sandals@crustytoothpaste.net>
>=20
> instead of
>=20
>   sandals@crustytoothpaste.net
>     -> brian m. carlson <sandals@crustytoothpaste.ath.cx>
>=20
> That means the mapping
>=20
>   Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
>     -> brian m. carlson <sandals@crustytoothpaste.net>
>=20
> is redundant, so we can remove it.  More importantly, it means that
> the identity "Brian M. Carlson <sandals@crustytoothpaste.net>" used in
> some commits is not normalized any more.  Add a mapping for it.
>=20
> Noticed while updating Debian's Git packaging, which uses "git
> shortlog --no-merges" to produce a list of changes in each version,
> grouped by author's (normalized) name.

I think this commit message makes sense.  I apparently still fail to
understand how the .mailmap format works, so I can't tell you if the
patch is correct.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Efge0/SQAHHP+Pr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlugKQUACgkQv1NdgR9S
9ovTQA/+OsU/QvdwS14is+ejOAxp1qX2ElZcf4jn9t+kocbqHL9zOREoMerMt+5j
FpugBnTvJCd1pGs8De0FvvSnkK6B4dcFMxFlsGczDEJ4qLU1ryKh1qlP1fl5DW8L
J81DttcRPrZC6C8LZbBUtwmgviulf+BFpXf40taep88+qZiujB/0cCyBZhvADVmQ
SXQ8hDYib45YZVi+PcVNChqe8VlQbCOBJCQtq63LPd0XasTicWBn8xahY4Bc9OFW
3dJzD5cxBWGbexlyTvWZCCrzf95hoIS/y0pVs32gW0T8wVvbXCPB8iIL+pwDl0ZM
6b6f35JW3SDnfrZPYf2VrIUBqolL/Gf3DLz41ON3G3yTxxzna9YirDBUZQyVz1eh
R2B5KX8XKvjJ6sMUSogw8llPDbaDbT7P66EU5mH8lHpbV8fTFAyJsCrJGDLhlgwM
x25HipOrWZbGjfG6brgxxdUeicsrUylviJzc8jRHNsfx4k4eVV/QcchODHUVsTIn
9F7U4Wrggt/WyGmefAe2jJKRxvNyfdgDdyUgjjEMRlvvjtL3bhW+Vb5nahwNd1Bp
ymGDCJUQRPNLLKYtXIAT1IgUZONwq8qY1Pr0LcW3hNeq6ltNT417qNaDw4Ed99sZ
oYhWSm3NjMcN4oHPFrsVsKFef8hoynlUpn0dOJq+TIahSBLkAdc=
=ptIr
-----END PGP SIGNATURE-----

--Efge0/SQAHHP+Pr2--
