Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8BD1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJQGb5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:31:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50914 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbeJQGb5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 02:31:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 499A261B72;
        Tue, 16 Oct 2018 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539729562;
        bh=GdTm6GgJP/br5ilvV1vjU6pB1HdaWuD3Y6OH7Q3X+10=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VAcDnrEFLisM8iksyLhhFkPv37p+/MfYQBgfPh5GgN8M7rzN+ZYtIBG8wqRAC7+qB
         cWU8jY6CsKiLyu5vWNONnl8WiB/vDg9Cm4jweQhOTpOa7TpTWGQ2LtPYdCAhbxCDND
         q7RPr5RvS1cCoynOi0crQvtSFrUSzlia5yN9DOfRv4DMl1c/JpBiJ6loAxKek8CHz6
         JZ49f8wHOhCte09LI3Bj/Lxfh2120mpdO2GvgJiIy0T3fM3VIYkI34oRSRGimAK/15
         +pqzbJ20n1t8Fybp1vUTDWLYbOyNe9zJocWLagA5kcrUap5HMnnYYT1ApcsnOyjRgE
         Gg8jQIK9xhVuiZAf4GrZOL7hJNLoH7xyfqhpvUQu8YP1J55JQhAMiQhxg1xbZJioiM
         MVAocSQni2n1VxFyikY3Qu21HfWxgRg7StVj5OPC/gFGU6jUXTiFFgFwTgBzk4uUTw
         6ln9hQ8HSlXxPBbS6XZK9AgZTvvVxsS0P7JZH6EYgRXOgcjdNGp
Date:   Tue, 16 Oct 2018 22:39:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
Message-ID: <20181016223917.GC432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
 <xmqqk1mi4pn0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o8DTQsiwS+K7TY1f"
Content-Disposition: inline
In-Reply-To: <xmqqk1mi4pn0.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o8DTQsiwS+K7TY1f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 11:00:19AM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Since the commit-graph code wants to serialize the hash algorithm into
> > the data store, specify a version number for each supported algorithm.
> > Note that we don't use the values of the constants themselves, as they
> > are internal and could change in the future.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  commit-graph.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 7a28fbb03f..e587c21bb6 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
> > =20
> >  static uint8_t oid_version(void)
> >  {
> > -	return 1;
> > +	switch (hash_algo_by_ptr(the_hash_algo)) {
> > +		case GIT_HASH_SHA1:
> > +			return 1;
> > +		case GIT_HASH_SHA256:
> > +			return 2;
> > +		default:
> > +			BUG("unknown hash algorithm");
> > +	}
>=20
> Style: align switch/case.

Will fix.

> Shouldn't this be just using GIT_HASH_* constants instead?  Are we
> expecting that it would be benefitial to allow more than one "oid
> version" even within a same GIT_HASH_*?

I really would like to have us rely not rely explicitly on those values.
We don't serialize them anywhere else, and they're explicitly documented
as not being suitable for serialization.  If we were writing this fresh
today, we'd probably use the format_version field, which is designed for
this purpose, or simply omit the field altogether.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--o8DTQsiwS+K7TY1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvGaJUACgkQv1NdgR9S
9otFQw//Q2m6OPpoMXlpFtOTKvBwpNxCTlzy1T4hCyMiW9x+KAXexVMsnm5it3U8
ySqu5B0y+f8IKjm3r0mGoieJnWl8/x95o5ACQM0Ce4QwnjhCEuKNq2n4nQP0mr+V
tnT/NJtgIeoq6Q1mGjfjBkP9oFew/i39t++NSnAMG0vFb9Etj0ZZHrTJK/YyXGeU
VbYcmYbvPXFJnGFeROxWuP2FVsUNNQy5lCufBSz3PDW9Ah40AYxUx0/utFT06ZWW
N+UXdSqQLbnuTTyc+FV8Kn0iQp4FnD2HG6XeC45M5j+024Vi5PsyKp7W5+nz2oEX
Ys0mOfF+wUvXNPFrCSa90tZsCKTQBaQs9jPXyO2w1JK8y6i4Lj3FdbJbTrt2A8+X
QFohe7wBZ+lnbgUApwYSjWk6CgrqKIp2GizMYwsTRZFu53gNFv59zNwc4P9oMUJk
oL/UX6/DRGBuBfmGj6dMtV7eLgxL5FYjnOFlW3O+/XP3Fi4Lgv9lzCYvkJimmhm2
4XT7KO6DmswANFIgyyWEarLxSgYVwetdH4oGUM9nxQqL+Ed5w9MV0rK73AbPTB6J
8AknpzsKfjRXFQbY9fkaHH9qhYBq/ZcfQXricGsOXnNY03RqQE+MrQYUhREx39Nm
NpDJlY6gp5SM+4ce7zTz1zY1ypXrPofxs4/NOwO0rVrlAELHsmA=
=tQ/W
-----END PGP SIGNATURE-----

--o8DTQsiwS+K7TY1f--
