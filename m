Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FBA208D0
	for <e@80x24.org>; Tue, 22 Aug 2017 01:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbdHVBTO (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 21:19:14 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57742 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754434AbdHVBTN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Aug 2017 21:19:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DD179280AD;
        Tue, 22 Aug 2017 01:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503364749;
        bh=yZqDqNeieJPJwSAQpAMXOhcccLbo9Dhm+ry1VGXYHAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I60Iq6SrWC1t9t1MLU6d+Xd94v4phM4HOTFjPAAYg37o+++OMyWukMH6Rvbr7jL8Z
         Lwp+SkNcQ/+UA7z1tjd1/Ng8odez22eZy+VdbCbPan6M2PsH/lx/zUsSqq+Q9RHORi
         zYX4V3DqtuDGyiGbx7GwYrjpr40rsELW5zTgl3S4A/Dr2pXdYCGa0W9mHE9xJ6EYJ9
         V0HcFBbgv4boSrwxFscjEQN2wqUWOS2aoYQMlWxMHuA7pfsFf8C2WXM3CsF8tri00m
         E+/FyVMAJdqqhZl8rw2S+xo5etK4NqgSFUU+dv0RoO8SmwEvVfDNJ/I7KOaUMBHqhE
         lRNgDK14SVuT03DmPvIASJrJdXcnQIC7xJW6ic1em8crD4DKSgi9397NQbao2qlRYU
         Uxk/1KuciTiwtpCh4he5IGaVgVSo+51eI8w/S1CqB7eapKXUeP3cxeU60f+/8LFG6Q
         3mX2D0dwRajd6R5tG2tOo6urACelZaG/ab+CZDbhJeB3/Sg5bzs
Date:   Tue, 22 Aug 2017 01:19:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 15/19] Convert archive functions to size_t
Message-ID: <20170822011904.2mow7ejlr22y7ova@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
 <1502914591-26215-16-git-send-email-martin@mail.zuhause>
 <xmqqvalh5smc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mi2zkthcceranqed"
Content-Disposition: inline
In-Reply-To: <xmqqvalh5smc.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mi2zkthcceranqed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 11:42:35PM -0700, Junio C Hamano wrote:
> Martin Koegler <martin.koegler@chello.at> writes:
>=20
> > From: Martin Koegler <martin.koegler@chello.at>
> >
> > Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> > ---
> >  archive-tar.c | 16 ++++++++--------
> >  archive-zip.c | 22 +++++++++++-----------
> >  2 files changed, 19 insertions(+), 19 deletions(-)
>=20
> I feel that this needs a careful review from somebody who knows the
> definition of archive formats well.
>=20
> I am reasonably confident to say that the part of this patch that
> updates the variable used to interact with zlib to size_t.  Use of
> fixed-width uint32_t for CRC32 may also be correct, I would think.
>=20
> But for all the other changes, it makes me nervous to see that
> size_t is used to describe size of things in an archive, and makes
> me suspect that some may want to be off_t, because an archive is a
> concatenation of files, whose sizes are better measured in off_t
> rather than size_t.

I can't speak for Zip archives, but I'm familiar with tar.

> > diff --git a/archive-tar.c b/archive-tar.c
> > index 719673d..ee56b2b 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -12,7 +12,7 @@
> >  #define BLOCKSIZE	(RECORDSIZE * 20)
> > =20
> >  static char block[BLOCKSIZE];
> > -static unsigned long offset;
> > +static size_t offset;

This is fine.  The value has to be smaller than BLOCKSIZE.

> > =20
> >  static int tar_umask =3D 002;
> > =20
> > @@ -50,12 +50,12 @@ static void write_if_needed(void)
> >   * queues up writes, so that all our write(2) calls write exactly one
> >   * full block; pads writes to RECORDSIZE
> >   */
> > -static void do_write_blocked(const void *data, unsigned long size)
> > +static void do_write_blocked(const void *data, size_t size)

This is fine because it's only called from write_blocked, which is only
called on (a) extended headers, (b) global extended headers, and (c)
files below the big file threshold.

We already restrict the big file threshold to unsigned long (in config
parsing), which will be no larger than size_t, and we can't allocate a
buffer to load data into memory that is larger than size_t, so this
should always be safe.

> >  {
> >  	const char *buf =3D data;
> > =20
> >  	if (offset) {
> > -		unsigned long chunk =3D BLOCKSIZE - offset;
> > +		size_t chunk =3D BLOCKSIZE - offset;

This is safe because it's smaller than BLOCKSIZE.

> >  		if (size < chunk)
> >  			chunk =3D size;
> >  		memcpy(block + offset, buf, chunk);
> > @@ -77,7 +77,7 @@ static void do_write_blocked(const void *data, unsign=
ed long size)
> > =20
> >  static void finish_record(void)
> >  {
> > -	unsigned long tail;
> > +	size_t tail;
> >  	tail =3D offset % RECORDSIZE;

This is safe because it's smaller than RECORDSIZE.

> >  	if (tail)  {
> >  		memset(block + offset, 0, RECORDSIZE - tail);
> > @@ -86,7 +86,7 @@ static void finish_record(void)
> >  	write_if_needed();
> >  }
> > =20
> > -static void write_blocked(const void *data, unsigned long size)
> > +static void write_blocked(const void *data, size_t size)

This is safe for the same reason do_write_blocked is safe.

> >  {
> >  	do_write_blocked(data, size);
> >  	finish_record();
> > @@ -198,10 +198,10 @@ static size_t get_path_prefix(const char *path, s=
ize_t pathlen, size_t maxlen)
> > =20
> >  static void prepare_header(struct archiver_args *args,
> >  			   struct ustar_header *header,
> > -			   unsigned int mode, unsigned long size)
> > +			   unsigned int mode, size_t size)
> >  {
> >  	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
> > -	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode)=
 ? size : 0);
> > +	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode)=
 ? (unsigned long)size : 0);

These two definitely need to be off_t.  These could be up to 2^33 and
size_t may only be 32 bits.

> >  	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned l=
ong) args->time);
> > =20
> >  	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
> > @@ -219,7 +219,7 @@ static void prepare_header(struct archiver_args *ar=
gs,
> > =20
> >  static void write_extended_header(struct archiver_args *args,
> >  				  const unsigned char *sha1,
> > -				  const void *buffer, unsigned long size)
> > +				  const void *buffer, size_t size)

This is fine as it points to a strbuf length.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mi2zkthcceranqed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.23 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmbhocACgkQv1NdgR9S
9os0lA//fZ+jA0eKofjg17RDYp6MrR4MGwSsHJyyyoMr3q1o/DqpsO78zfdEyHPT
NQOVxLo1dvHWRfb1r1O5etrcTBRNzlOUJqashTdA95w5uXAQV6nAvoGxvhRGWVJk
BlYKgzuTwtxS9F1OltbpDT0Q+Rh9wv586EU+ZiwglWbSDiMaHVvtkR9EwutpFlB7
Coe2SmymQOHafmT2ZjbhiM7H1o64ohqb4iSxLmqLZQ8K5z1wQeKGGkW+5uuExwbF
55ohhSNbbK26E90+MTQ0DUy3nZ9NhDVAj9V9SN9u7xi+OBcPcyljedvjWWzJxtfJ
5Q2zwppXoGLXQ+WTlfYIFDAars4jHqbokjPfO8VYxBG36DRralWDwIRG0g+1lFTc
eCvleXkLJGRpRowQZEHjV1G8Ts7vtWa6eJ5FDj4TSdMeN6LhvzIzqlsalyBqLNZF
Frt/lJ84PaIlyFTaTapbVzPHAk3PU6con1ehU2kaZRBjkHW3GM+bxfzxlQhwiHAb
R6F1SiO8p2cd+NblUTg4SZ8tSkXqVa7/wM3qNz1KZ/HncvKDN1ikMi9KP4RR9qXW
dsUa6qBr7jn4YTVn838RTzFop4fGMzIdvNRa0mwpvcUf81qS/djWINSHJ8It/uLw
GGtE5mLHlOxt55QxhRZo25395TPPoaf3swksqpNPOz1BN/8BCFs=
=DDsZ
-----END PGP SIGNATURE-----

--mi2zkthcceranqed--
