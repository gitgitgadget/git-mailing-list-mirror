Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610511F453
	for <e@80x24.org>; Sat, 27 Oct 2018 19:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeJ1DwI (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 23:52:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52730 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728213AbeJ1DwI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Oct 2018 23:52:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B446B61B73;
        Sat, 27 Oct 2018 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540667411;
        bh=9XofwTqie3dS3bTuqq3FoQX0zgREbdGnvd3xghbNHCs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=k2ubgvMmM6g7fzDz/+PK/nas6zcNZm2M0ytnqCNUd+mNAWuEJ44J7pM689oA4vkuP
         Wlaa5k5n3+c+hLIPCFtS2tlX4KVdHNHj5YHtTOxb3NzLKh9SSNuEze35pqFqst1iWt
         ny2xH4woSxmDa66mlmfE2H4UbmMFxdzBqmb2+xC52YplIWnJJ66797lL3/KB3e9OB8
         xPDaHlFL6rzKpQs5+Q8dwL2UxzkwAw4dovqZhigl1anPrZKAIjHB+Y1lhTaVBqPCPb
         obFQ9Ry9QwFYfkaLXk96bvnLqLYcx8RCAO2WKCkuaWaMhfl6DPfvIh/pXgWtzTSe58
         UVe5r7zUq5LSPXCoFIuWEUp4qvr71U4rxrAB4o2PV3x+dyImh6ztGSVl6jrKvjWRFl
         oDWY5PZMmKM5g+nRIIxgiHGJy58GmCBfIotjGl+JsYWdUCTivlUuoxQzD6tYcmL1yS
         yfo9CTTqZkLAmw/J42gkkUMxVc5WHSLCMXqHt4mGQBOBOD19560
Date:   Sat, 27 Oct 2018 19:10:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Saturday, Oct 27)
Message-ID: <20181027191003.GG6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <5db6213b-b7d0-b995-de80-9671604416a5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <5db6213b-b7d0-b995-de80-9671604416a5@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 27, 2018 at 09:27:21AM -0400, Derrick Stolee wrote:
> In an effort to ensure new code is reasonably covered by the test suite, =
we
> now have contrib/coverage-diff.sh to combine the gcov output from 'make
> coverage-test ; make coverage-report' with the output from 'git diff A B'=
 to
> discover _new_lines of code that are not covered. This report ignores lin=
es
> including "BUG(".

Thanks for producing this.

> Commits introducing uncovered code:
> brian m. carlson=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2f90b9d9b: sha1-file: prov=
ide functions to look up
> hash algorithms
> brian m. carlson=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b3a41547c: hex: introduce =
functions to print arbitrary
> hashes

These two are expected.  One this series makes its way to master, I'll
send patches that use it in a bunch more places, and these functions
will be adequately covered by multiple code paths.

> Uncovered in next not in master
> -------------------------------
>=20
> apply.c
> eccb5a5f3d 4071) return get_oid_hex(p->old_oid_prefix, oid);

This one is just a name change.  However, I think it's interesting that
this code path isn't covered in the normal case (and presumably isn't
covered before my patch).  From the comment, this appears to be limited
to the case where the index line in the patch contains the full object
ID.

I'll try to see if I can come up with a test to cover this case.

> builtin/repack.c
> 2f0c9e9a9b 239) die("repack: Expecting full hex object ID lines only from
> pack-objects.");
> 2f0c9e9a9b 411) die("repack: Expecting full hex object ID lines only from
> pack-objects.");

These are a change solely in text from what was there before.
Considering that git pack-objects would have to be modified to produce
invalid data in order to trigger these (as discussed in the series that
changed them), I think it's okay that these are uncovered.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvUuAoACgkQv1NdgR9S
9otNzg/+N1gxSTSl3xFylSA+/zCEO/f/4VceRwaLtNxtS+3oipLiH0hW/7KFy2Ka
YYolVn/p+hYC+VJE1l03axN58StxtNugGpAExSNWQj0LEdrkvu7XEb6Yod8s6WkF
T2RzEYO7FroNE7ojslT9cWPOSB6VNT/7WwqASj8/peZzIWdkYuKWegBK7i2YGM3O
BrhErUzf37NNrf0FM890o98/YEePKuZGZsW6Y8cuATvn/Y7enkr5c4Uhz0LSbylG
YdwvsbIjRgTZK8toep4/xU/4Efx8/Y0AvcLBXgOfBo9dsCBl6pGUGs+1lrRQv+I5
JP92vaxrO5jHm2T4bt2uvXa27SMDE9qzwvaPv4VW+1MaNlYJ5+JV+KSWtk/mBOYY
DHC7uK99T9xDKSki4u87LcYRLhK8lxLF1H2CHfrQAaI+mc0EleSxs0IYeSJ+E7L9
QwJpbAgey7fzffse0nSDiJREozauhIJnk/qpYJObOw7+T6jTDpAgA/xv5EAQb6Q1
J5pbuZ9TNMRtXbB7rHKqSJ8+/d8lm24EW/0bK+mMszf5H9b9uVsU8MWjA4lXHi+a
DMz4DIznn+blewxyuf8+OeE5v7DdaRmC+kPtf9UaKQtXxkLAjs+PWh+1VFEgooQD
zeTN0RhxXrGGFB30echnJJng7Glu5dglzxY4aOaURPS7QfBu5Pg=
=O8ZK
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
