Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04761F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeJQGgq (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:36:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50924 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726923AbeJQGgp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 02:36:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA90861B72;
        Tue, 16 Oct 2018 22:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539729849;
        bh=1LZD9Z27D7Kd4qb4ApKDMzaYBxc231BN9BNcigLVjIg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jpls8b4YTkTcRiBHc6yBmSrUk1AimF3pRvwki+PRgEGXefvU9Yraldld4mFulQAkH
         cGyaHUVATVK1eTbv8/jbwRaqc+S1v6rn6IBOR4xR7xxAWDG5Cpv6Zq5dSy3X80Lobc
         dSUIYQd3hwmS6IxY0JZ2jees8C3wVFtxwW+CmCftxLnt3rQnhE/ABeL0piThzFxIlM
         7V0k/nwSy4KU1j3FbG1GAguyLFZF/aPaPuO+l6jj+xJTi7/+rA3VfBg7n5VXziPBKV
         ebxtMNixuv9i9Jbfc/PeC1I/ZN1heskGrWuGcLYprpwer/IUQeg23ehE94rCLA9yJo
         MgoXWqB8EwsPxMLGFQF3zqAoKF1oNDjgvbdti+Ds06HdJSuwYII7YE/xz4SPiSzkjn
         1o3tFLQTpjcMgzSC1uGukOmvJHLEer+XK8c2/FRB2TYWZ8hufufZxo3xWlZ8idDQf5
         MdflKRfKSRR9BbuQ0tgukALAoDKYMjPQfMrcHakoXLtlROx8TYh
Date:   Tue, 16 Oct 2018 22:44:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
Message-ID: <20181016224404.GD432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
 <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
 <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com>
 <CACsJy8Bg6BpQp4dDXzs8Y_d6RHW9ti4+FLqnAqGwW8F-SWUnPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6+xh7U81BA4t3uLM"
Content-Disposition: inline
In-Reply-To: <CACsJy8Bg6BpQp4dDXzs8Y_d6RHW9ti4+FLqnAqGwW8F-SWUnPg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6+xh7U81BA4t3uLM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 06:09:41PM +0200, Duy Nguyen wrote:
> On Tue, Oct 16, 2018 at 6:01 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 10/16/2018 11:35 AM, Duy Nguyen wrote:
> > > On Mon, Oct 15, 2018 at 4:23 AM brian m. carlson
> > > <sandals@crustytoothpaste.net> wrote:
> > >> Since the commit-graph code wants to serialize the hash algorithm in=
to
> > >> the data store, specify a version number for each supported algorith=
m.
> > >> Note that we don't use the values of the constants themselves, as th=
ey
> > >> are internal and could change in the future.
> > >>
> > >> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > >> ---
> > >>   commit-graph.c | 9 ++++++++-
> > >>   1 file changed, 8 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/commit-graph.c b/commit-graph.c
> > >> index 7a28fbb03f..e587c21bb6 100644
> > >> --- a/commit-graph.c
> > >> +++ b/commit-graph.c
> > >> @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_d=
ir)
> > >>
> > >>   static uint8_t oid_version(void)
> > >>   {
> > >> -       return 1;
> > >> +       switch (hash_algo_by_ptr(the_hash_algo)) {
> > >> +               case GIT_HASH_SHA1:
> > >> +                       return 1;
> > >> +               case GIT_HASH_SHA256:
> > >> +                       return 2;
> > > Should we just increase this field to uint32_t and store format_id
> > > instead? That will keep oid version unique in all data formats.
> > Both the commit-graph and multi-pack-index store a single byte for the
> > hash version, so that ship has sailed (without incrementing the full
> > file version number in each format).
>=20
> And it's probably premature to add the oid version field when multiple
> hash support has not been fully realized. Now we have different ways
> of storing hash id and need separate mappings.

Honestly, anything in the .git directory that is not the v3 pack indexes
or the loose object file should be in exactly one hash algorithm.  We
could simply just leave this value at 1 all the time and ignore the
field, since we already know what algorithm it will use.

> I would go for incrementing file version. Otherwise maybe we just
> update format_id to be one byte instead, and the way of storing hash
> version in commit-graph will be used everywhere.

It needs to be four bytes for pack files so that it's four-byte aligned.
Otherwise accessing pack index fields will cause alignment issues if we
don't massively rewrite the pack handling code.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6+xh7U81BA4t3uLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvGabQACgkQv1NdgR9S
9osgWRAAli6ZDuok4n20p1wAeOCrv2xRF/M+j23sYDRosWRwEKYqTkO9cP581nHi
rjrT/A72/Qj8lgOy6gzNLibFe8k7vwMFA45Pts9M6VAfe5WD1xxYV1wzO+SSEF03
ZveeXnhWpI2lLQaMETaoCjtujxXwqAkdOECWXW91NUvE4Plm3cjRHRiHnLtQkP3Q
EWdA26BsbE3HsJH2qc3jE/EnMMNwOgJjZCTno0GIQNTjP4mKrYtdXo2i3dMWB+mG
O/i2hhQfVqtjM6PXEcJaMa9XK+sLtv6uTy8vA3WtdMD27oqZqfZdNq0CSdvn4eu4
LEHMIkcAe3UZJtnx6t9M4G30/BNrJKVjlf6H7v+bsO8JuSeuD7ZJ+0XT2aTtWdNf
hG4xzX/F+4hdd0nFHhQ0m1FsAQOXa9riTajyGFPrN7DDZEbkRXihkjlc+zLKvHhm
k/nLsp6JL3cb0lM8NlbI3ZUZsaMaSObdA/bvMAzYQGcPJgqNquswsQcGFuVrkopH
3TnLD/7gftAshi2w54gyHT1Jbrwg75c/8CYWJgGyeHeDzp49IWHvKa52vx7PbHM1
gIpeDnhegOUbe1XcH+qGp8oM+4vfrQFAYSbtT7nGz6mTQ/jeNYpwoTkDCxDYRNHN
1SqQH0262/ohRA04ZyWP/d7B2DThM6ik/14QLt5znaFSSuCfsVg=
=HSmj
-----END PGP SIGNATURE-----

--6+xh7U81BA4t3uLM--
