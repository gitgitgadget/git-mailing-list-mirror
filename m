Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1627C1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 23:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfIIXr0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 19:47:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58624 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729118AbfIIXr0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Sep 2019 19:47:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:9d62:8fc3:cc7d:8629])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4364860448;
        Mon,  9 Sep 2019 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568072842;
        bh=682M10F7P8LNvgKkCqn6jaehN7mO6m/HsfGxPIgOntw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZRu9nxAm3ZawTqrzZI/EJwGEhfWA4CVfYLk5lxzWtok7Cy5AIBcxxKvd9dhyWVHet
         54NTeHFlaETT00d+8gJki842cZfiUvFq65MkA0oFjUnp2f3zgNDNX5MAcgiCNFiZvt
         OXEFXZ1qFoYkPAqpYad/q7/gAS0InkVDHDghcDDqKjz7OWw617Wg3/NKpGTFnCap6j
         ZrZ0//cWhJTY5LB4O7tMygRfDAG1hyMfNUUwZZaHl87pO5YLIco0vcdBNg9hcr5Opc
         ZD5KvXJ/nDu5t8WY3z2zu6FNwZXlGFnSZOGWmnxOTgflbNrk4iPCQ2P1QF8KRyU/0P
         or5XpHRMcGgSSp5AbDMJMiLGVoJh16EU8x7WB7m4Z8P6Qp6/E0mTY8lchXW1jd2Dpg
         eO22Cls6EuGNmZjfSccF8cTlUGvOtUVn40jdtkl/IIgh9zeKut3JZ/a5Zm61Y8PguI
         xrJiWksxpjDj6SlSJmCOwtvGy9M25lPpWCQglaqlMgvzK+5xeH6
Date:   Mon, 9 Sep 2019 23:47:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
Message-ID: <20190909234715.GO11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UFMLoheMaWcIEZAi"
Content-Disposition: inline
In-Reply-To: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UFMLoheMaWcIEZAi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-07 at 17:26:53, Junio C Hamano wrote:
> * bc/object-id-part17 (2019-08-19) 26 commits
>  - midx: switch to using the_hash_algo
>  - builtin/show-index: replace sha1_to_hex
>  - rerere: replace sha1_to_hex
>  - builtin/receive-pack: replace sha1_to_hex
>  - builtin/index-pack: replace sha1_to_hex
>  - packfile: replace sha1_to_hex
>  - wt-status: convert struct wt_status to object_id
>  - cache: remove null_sha1
>  - builtin/worktree: switch null_sha1 to null_oid
>  - builtin/repack: write object IDs of the proper length
>  - pack-write: use hash_to_hex when writing checksums
>  - sequencer: convert to use the_hash_algo
>  - bisect: switch to using the_hash_algo
>  - sha1-lookup: switch hard-coded constants to the_hash_algo
>  - config: use the_hash_algo in abbrev comparison
>  - combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
>  - bundle: switch to use the_hash_algo
>  - connected: switch GIT_SHA1_HEXSZ to the_hash_algo
>  - show-index: switch hard-coded constants to the_hash_algo
>  - blame: remove needless comparison with GIT_SHA1_HEXSZ
>  - builtin/rev-parse: switch to use the_hash_algo
>  - builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
>  - builtin/receive-pack: switch to use the_hash_algo
>  - fetch-pack: use parse_oid_hex
>  - patch-id: convert to use the_hash_algo
>  - builtin/replace: make hash size independent
>=20
>  Preparation for SHA-256 upgrade continues.
>=20
>  Looked mostly OK, with a possible update.
>  cf. <20190820223606.GJ365197@genre.crustytoothpaste.net>

Just to update on the status of this, I wasn't planning on a reroll,
although I'm happy to do so if folks have feedback.  Opinions for or
against the current state are welcome.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--UFMLoheMaWcIEZAi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl125IMACgkQv1NdgR9S
9ouDkhAAi2WdhbTLakj17jO9jWbsELkDme3DFzPcrX0mxOYbMMvt7HW423E/h8dS
6W/5GLIHzbNHEuZYCCg3aNpIXYSeFthTTbBQjQr9PypDW0biGYMcXbrsFcuiQQeD
Y7LfQzgNE5O9UclwPsg537woDz68uTSf9JKqw+jTwp0WnZc9rYEVqSwDR9YJU4PX
wTJBqMOGY44cR8cvG3fYw/ofWQMMHkabMbAOlVzlbpxcgvy2cx5t4aNSGzm38IaY
y5xmvAbx1w5yzpqMyxGP7UoglmJAOH0rQzYyeoy4QCmzsuGqzh4oF0dp6ivc+2gk
NkRk35Q9uv0I6vPm551u3Ofv6HcsUbK5ZKjbGvT0lp4ss1mFSjTz2U0Y1lIlRL4u
iF+2dyRlccFS0HO1lJ2CGJpkORswPlYlP6eN8YZclsUeZ4MOpiVKvIrWj6snTZGU
aY4evKRXrXUEwYo38hlU0oVmkC0b/lC5Kf10ckFKdGOEjxy1QKshHhQB62mRRsTE
f38+ez5XEAtlmyrfsN7cp5Aj2ICINsthtCKkAuECc6RdSNAuf92m4+XXQtcOK7qg
Uw3Q0dX3y4TMHN9YKlDDy4AH8Bv6Mw+FMRa69MZJ/jylUl6NqUdWefWANH6iy38D
NieCIfGDhQzqAVwKZAkBBMrNQYR6DhPRlF/w5++APPAb/OPKH4Y=
=7MKH
-----END PGP SIGNATURE-----

--UFMLoheMaWcIEZAi--
