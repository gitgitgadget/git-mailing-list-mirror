Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2481F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeB0CBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:01:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34120 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751396AbeB0CBS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Feb 2018 21:01:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C012460987;
        Tue, 27 Feb 2018 02:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519696877;
        bh=LerpZAu/IsZQhrD6OWODieD47djwFCdqy80oUfBDc94=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kj4Q/2qsAJLeJUCbLhOV4L2TErGxxKhFCemDv2cZvv3pqEqFuE9gdiw02kLYkDGso
         sbx0Iz2pkAARo3gDMb2DAcIsBv8WZQDPJ4uhrMuwa+wFTnY1bsVU1C1/Qw5RQwgE06
         rcxclMKFBbBU5N06PK6uKY4Ql97mBqIJz+hhXSRYdeJc1v6gK/ISf3PKTjbubP5eoq
         utK1zteBcIk4j5OLFgFTebf+CBbi4N6glIEJkyMyo7BTspbbTgznjOphgBdhRvnmSI
         tW1+x9/I8yCM6mS/7nELRgSnrgtOl2cjGbhWwJ8C769dBbWTV3IEz5p3CheJ+8IZ7J
         JvCKDztE6aEzb/B1UBZn6Dc5pIUPJGD4IRMOdNghLe6sCtyHNkLwEI+VkA21nUA+CX
         FByVAW1g0Yzg4aMNJFj6vwFFP3ET13QOo4BoGYCCw9onRkfrGgKSwVyu+ISATskEFZ
         OTxfEd1TmNITIPdx+NMKCbJFbA5ENZoewnP9AeLdr+SqsKiSIr6
Date:   Tue, 27 Feb 2018 02:01:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/36] resolve-undo: convert struct resolve_undo_info
 to object_id
Message-ID: <20180227020111.GG4620@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Patryk Obara <patryk.obara@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
 <20180225211212.477570-6-sandals@crustytoothpaste.net>
 <CACsJy8AnTp1kzwUbAY_9XKg=A6Mo0gUa8o_dimx=+c1rFqu16w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
In-Reply-To: <CACsJy8AnTp1kzwUbAY_9XKg=A6Mo0gUa8o_dimx=+c1rFqu16w@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 06:25:24PM +0700, Duy Nguyen wrote:
> On Mon, Feb 26, 2018 at 4:11 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > @@ -44,7 +44,7 @@ void resolve_undo_write(struct strbuf *sb, struct str=
ing_list *resolve_undo)
> >                 for (i =3D 0; i < 3; i++) {
> >                         if (!ui->mode[i])
> >                                 continue;
> > -                       strbuf_add(sb, ui->sha1[i], 20);
> > +                       strbuf_add(sb, ui->oid[i].hash, the_hash_algo->=
rawsz);
> >                 }
> >         }
> >  }
> > @@ -89,7 +89,7 @@ struct string_list *resolve_undo_read(const char *dat=
a, unsigned long size)
> >                                 continue;
> >                         if (size < 20)
> >                                 goto error;
> > -                       hashcpy(ui->sha1[i], (const unsigned char *)dat=
a);
> > +                       hashcpy(ui->oid[i].hash, (const unsigned char *=
)data);
> >                         size -=3D 20;
> >                         data +=3D 20;
> >                 }

It looks like I may have missed a conversion there.  I'll fix that in a
reroll.

> Here we see the same pattern again, but this time the @@ lines give
> better context: these are actually hash I/O. Maybe it's about time we
> add
>=20
> int oidwrite(char *, size_t , const struct object_id *);
> // optionally, void strbuf_addoid(struct strbuf *, const struct object_id=
 *);
> int oidread(struct object_id *, const char *, size_t);
>=20
> for conversion from between an object_id in memory and on disk? It
> would probably be a straight memcpy for all hash algorithms so we
> don't really need new function pointers in git_hash_algo for this.

I don't have a strong opinion about adding those or not adding them; if
people think it makes the code cleaner to read, I'm happy to add them.
It would probably makes sense to make them inline if we do, so that the
compiler can optimize them best.

I think we do need to preserve hashcpy anyway for a handful of cases
(such as pack checksums and rerere) that aren't technically object IDs
and won't use those functions.  I encountered a similar experience with
get_sha1_hex recently: there are a handful of cases that want to read
the name of a pack or a rerere cache, which are not object IDs.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqUu+cACgkQv1NdgR9S
9otMxA//eTwWNYdruxtY4Vpv7bPhSAu62JE7nzOiivh/776vDops2glz4drlkCty
OW0NCKQDudPmKnpsDSUfqncTVS9mvjcwgzBAi2S9pUctd8BKcOGbbHVl7k7TAj3h
vCP+I1MnbXPz5ydN/pyyC73t3YM9+EuNilYDalloUTXhcd8EbXw5raaUGu2KE7jI
ZzSovhC9Ic55VXJhczHNtFYRCid5YqBeaeOhlItdioQ86EHB4Yb9A9SLyORSo+BU
hNLS9zutNr8fS4zsqmHMbQM80/Bvbx2QITqkutFmhwEqQBmvLcPXmE6rxEwidraB
2WxpY+TTd2vbRi8hrtL14ViVY+XMler/bltDDLB3nxOM0lVSBtwTZkIpOTSWwm2w
re09aVi/QWaDDBXACR9kIrzkC7fs2JCOQf3t3zGJB9yW9nSu//aQffYJs8Sb5GSO
X2nS2hPkI6Eub5A9ffr9jg1KP9r/VyS+nGB5zVaLAjBYYLACl6gNw7PkqcMm7a5f
kjeX1tR2oD9iG6atfDFo7YtUJpdrln88R2AKZhdXxUGHLoZXOdVI3XwHoNs7Ebbp
sReEZOMTcqlhJG/trclVeRXe+6v7MUpGOyaRvnpn0DqVqB8jtQN8jQUIERA7JbgD
HWh9SPc+0DmqokgdEl4g1xe9xfk9UEx3LBZe+AoTCkYUQ/KYK/4=
=8rzZ
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
