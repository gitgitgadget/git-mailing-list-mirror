Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F324200B9
	for <e@80x24.org>; Wed,  2 May 2018 23:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEBXGC (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 19:06:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38530 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751148AbeEBXGB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 May 2018 19:06:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B2D986046C;
        Wed,  2 May 2018 23:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525302360;
        bh=qQaY2XcOe97YvaH/PAEpq6uIhDFWFAuv/YqqkMmonH8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=f96ZZx5a2DdPksFQv+V/2DQdL8ubSuB2Q6ZE5C3oeKMSSKz4aqMqTtQhFdubnc57p
         58Af4ELl0tBUChTF0TsDyXodteeuGqaUZu+crNPyvzuwpquY8is68sEtFRK2xb0SxC
         z8R+3O3CnTeTL9ODW0nCf+7OUXit0M55xh7uTKAidYDcdjkA+Bn3iC9UAM6RDI9y6Y
         z8v0xOYD4JO6Hz96jYpd+26+tOvtdET3NrlDn08SDZ+UNcSyZmBHGkGpZ9rrHMTd9v
         BmDgzWDjLKE8IVSsqfZT3W6FC1itpK+e9odqqc/8RjHj2OEOnyXnOfmYsHwHMDAvK6
         AeU2R2+z3NUrweKP9YlJW69hqKWayh5EnQFSxg52fzROEq64UFK97xr3b3t1taKJ0/
         DU3NdWC93qGEuj4yjduGxFFwuM2kHBF1xmJxXou2XB10J3YBwY9QZImgmJ7B3aJAwo
         eU0v9EvCbhDR7bbFEqeIj7e7qSxJXhxC5enK6256ajGxV0MBQUV
Date:   Wed, 2 May 2018 23:05:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/41] packfile: abstract away hash constant values
Message-ID: <20180502230555.GK13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-9-sandals@crustytoothpaste.net>
 <20180501102243.GE15820@duynguyen.home>
 <20180502001140.GH13217@genre.crustytoothpaste.net>
 <CACsJy8C1nLTOZFvdgrRYDTXbQhdt5vkbVxHSEiAVuH6Vo8WB_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2EnvhqpWJq810sZn"
Content-Disposition: inline
In-Reply-To: <CACsJy8C1nLTOZFvdgrRYDTXbQhdt5vkbVxHSEiAVuH6Vo8WB_Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2EnvhqpWJq810sZn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 05:26:25PM +0200, Duy Nguyen wrote:
> On Wed, May 2, 2018 at 2:11 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Tue, May 01, 2018 at 12:22:43PM +0200, Duy Nguyen wrote:
> >> While we're abstracting away 20. There's the only 20 left in
> >> sha1_file.c that should also be gone. But I guess you could do that
> >> later since you need to rename fill_sha1_path to
> >> fill_loose_object_path or something.
> >
> > I'm already working on knocking those out.
>=20
> Yeah I checked out your part14 branch after writing this note :P You
> still need to rename the function though. I can remind that again when
> part14 is sent out.

I've made a note in my project notes.

> > Unfortunately, I can't, because it's not an object ID.  I think the
> > decision was made to not transform non-object ID hashes into struct
> > object_id, which makes sense.  I suppose we could have an equivalent
> > struct hash or something for those other uses.
>=20
> I probably miss something, is hashcmp() supposed to stay after the
> conversion? And will it compare any hash (as configured in the_algo)
> or will it for SHA-1 only?

Yes, it will stick around for the handful of places where we have hashes
like pack checksums.

> If hashcmp() will eventually compare the_algo->rawsz then yes this makes =
sense.

That's my intention, yes.

> > I believe this is the pack hash, which isn't an object ID.  I will
> > transform it to be called something other than "sha1" and allocate more
> > memory for it in a future series, though.
>=20
> Ah ok, it's the "sha1" in the name that bugged me. I'm all good then.

Also noted in my project notes.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2EnvhqpWJq810sZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrqRFIACgkQv1NdgR9S
9otxug//XkTDncvV+3VI8nc66Po0e4gBVKPvUbqjx6HaNADQE5aMVMB259qUBqsW
hjstzEeZ+bGZRrG/HT1HjDf31FzjSGu4iCGDEBwAHP00PwBt5Qmcfp/RJVJ8EoTB
pgSw+m3b8d9IVYaCTlfcIF+LCrx0mHQhxwaOxlvERvqQptxNmll0niyeybwRx00b
Gzy9ySyjpxZInT8R5DGFMamCZkn70nkv8138/v6vvXgZ5UDwwEuAe6w2pMuSRpi6
i6VWQUchC9F9ykLnqIJ4DFdZsm1UsjEV2yEgW4zi3qm0AeyJbjynQM+lEn/W0yMC
t26UAluy/bHceoI7E93TK7FeBnOTXFs0D/S2APh9kWTHSxZsTiVyG75nUKENI3GX
E078B8lc0htVlxBnOe1OGsrBp9QnjJTmv8ogUkQGdGuWCMvswTnSD5KgvAyM8uP5
VT62vbea9m6REASPbVC2rWs2eV5xP/K+YIXwdv1TGJx1TrZVHmvEpOdsz59RdO8A
er0wdM4hyC5iSgO8OKzJ0MemPBFqn7G+W5ca5p0F/t3409piNqmqSnknL2SWX1OD
5Yd/pvLn+P+i6PYuEzQAY2LAaWSYyF4btk9dbIK6RCpXUwwJHffAmFcQFTcH3gXu
GxXA1dN8uFVniOumIEb3nIFHt+u50+9Z1uFWTnO5HHGLRM31JUo=
=RS6a
-----END PGP SIGNATURE-----

--2EnvhqpWJq810sZn--
