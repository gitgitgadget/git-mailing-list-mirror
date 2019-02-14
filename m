Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864E41F453
	for <e@80x24.org>; Thu, 14 Feb 2019 03:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395334AbfBNDdY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 22:33:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbfBNDdY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Feb 2019 22:33:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1D2BD603C6;
        Thu, 14 Feb 2019 03:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550115202;
        bh=Uz12TeonuKIMtixCsJ1nX5Ve1fqs9k4CbnbsjOHCg7s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Wqv/HchXXqUZkBCKGkf4sy99dhlzf+nzS3bwR9b20DprAEUYeLNPkswjUlqGa+5Q+
         9q0ydqD854IOkatsiTQNxQ2P0sh/QIsxkstJMw9cnApSJ+kVlWlQzh+TtbAx++SLbq
         PIkMIKvvCGxKSbkV0f+8KLOcICoc7K8b33zZYrDQX3rLF+t5isVK+rNWxKka3Bhrtq
         wD6a+E9eDaH6F8FU/kOA+zxVqTRQlxx9KYBT0bQZbBz0adUvhzmvOfRvkPXurB7r51
         PwtbIU1Viw5Ds1Sm2nKJhhG9X99rpy41SnovuY6S1DQp3T1bI9J/TOGdVff1C6GYiM
         ha0E24jqPiUTxNY0coFIQSBuRorPNAScb3wjSr496Zb4JLuVhCJdRaIsW7ydNI3fcF
         kcTgKJTSQ/W7X3+kl+926KiOJPJjbwjeFekhoPErgQ/4mZSQdLs+XUgUjCqre6LZRp
         ev0f2R5lIjQM6kI/Z8xgswpVYTrIe3WXjmoNyBd8vmXLTy1u6tr
Date:   Thu, 14 Feb 2019 03:33:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 10/31] object-store: rename and expand packed_git's sha1
 member
Message-ID: <20190214033315.GK684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-11-sandals@crustytoothpaste.net>
 <CAPig+cS3i2FWf6mFmpPpctyJJbx4xdHgWXrveRUkjMHct5SbJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline
In-Reply-To: <CAPig+cS3i2FWf6mFmpPpctyJJbx4xdHgWXrveRUkjMHct5SbJg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:32:15PM -0500, Eric Sunshine wrote:
> On Mon, Feb 11, 2019 at 8:23 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > This member is used to represent the pack checksum of the pack in
> > question.  Expand this member to be GIT_MAX_RAWSZ bytes in length so it
> > works with longer hashes and rename it to be "hash" instead of "sha1".
> > [...]
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> > @@ -689,7 +689,7 @@ int cmd_pack_redundant(int argc, const char **argv,=
 const char *prefix)
> >         while (pl) {
> >                 printf("%s\n%s\n",
> > -                      sha1_pack_index_name(pl->pack->sha1),
> > +                      sha1_pack_index_name(pl->pack->hash),
>=20
> I guess there is no oid_pack_index_name() function yet?

Correct, although see below.

> > diff --git a/http-walker.c b/http-walker.c
> > @@ -434,7 +434,7 @@ static int http_fetch_pack(struct walker *walker, s=
truct alt_base *repo, unsigne
> >         if (walker->get_verbosely) {
> >                 fprintf(stderr, "Getting pack %s\n",
> > -                       sha1_to_hex(target->sha1));
> > +                       sha1_to_hex(target->hash));
>=20
> Should this have become oid_to_hex()?

No, I think what's misleading here is that the member for both is named
"hash". This is a struct packed_git, not a struct object_id. The reason
I didn't convert this to a struct object_id is because this isn't
actually an object ID, it's a pack checksum hash.

I've tried to be diligent about separating the object IDs from other
hashes because I think it makes it easier to reason about the code, but
also because it may help us avoid tricky behavior when we have to deal
with multiple algorithms for input and storage.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxk4XsACgkQv1NdgR9S
9otuVQ//VNGoBeWrdrBoi50DOZyjKLa6a7WxEeCnOiSD4QJND+CKjhHe5iLidXDg
TzhAC6CzcCbz34YWS2LA1GU0pU7RXVDZKv5gMe0QQ26VffrQoKCt4PHnu/W92uKG
2LjipxUOnPLuvbXgHjgfCbnWd34MkjC7nPlg8BorbyohxOHsQ6g3h1Ned7w+jRQ6
qPq6sVYM8AiZU4QRgOdFLWU7gzgW7vofp24hA1VCi30lkzG/W6xQnBmFD7Tx6H0V
bgbQwYZwAJ3DxAVYjYIqicZklh9ITQjV0haANOwfszEz40+auuzlvX4en6Vl8D6q
zXlRSGcbIASzw7W4SOo1hSGFcmCRl1mRS914zwI++G/T7I3jlMSGWWPwkoP3AQyh
3mCgzt3dU2h2u8asycs8eoBTQ9xZsCc2FHBtC+3/Vx3HmiG0nz/LgvskHsN9y1eH
m2K4D4FUm7XEZiXdWIkwTDKoVyLyiVV20Qd2xZE/9MNcx+zwqgJamWs9T5acLYAl
MqHpve6JS//pUUmaeXWEJwlhLRB4CMY2+0USuVlqJiq4W4pJmJ3ZOLE+xiKIPOHm
JCxwCgJWlkZ487NcG0w5u0c+/m/g+LLwB48gkX57fbTloz2DaSrHsammr8FCmOZy
VI4upur3JDw2CTUzwzubqdkNnuXHrrsqow0UDaDUVouGNrU7tus=
=+3UP
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
