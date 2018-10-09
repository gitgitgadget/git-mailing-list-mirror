Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621531F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 22:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJJFoa (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 01:44:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49652 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbeJJFo3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Oct 2018 01:44:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 980016077F;
        Tue,  9 Oct 2018 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539123922;
        bh=PZlJ99D27pVDgeeOW0jifTfn6gToUYHoNO4XxshFW2k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AKfYrqdcPL7A908hpfqMXMr4sLhJ6zv84RR2+0W+X1HrIuQPuR579lHC+2dy90yaS
         0iPDx6OxWdxGK31fi5VAE2zhADyMoqkhX7ftRYTmEydhNpWZE3F2mWuHo732w6LG6k
         Ux3cypno6vIV5h7rAoTeb90G0ntjmG8eqjt7ylKXGA0eOtRQ7IqxqdxyPacXE3ADG5
         eTL0H2JuTln1djzNeByVDyQBZ61rnNJ2lOHOniQOIrwcK0dhKnJl5EKi0teWRAR6gK
         09Zbo+tfScpaM3uux2O6YJJuIOQqNc641t5/duXR8kDpCqOG8hCczSmPM7PV1YojPZ
         MZE4Azvz0uwE98QcRynaK04jBOZBzLg/1wVSSImtQnvZ8y3mXE12ipbHbsfg1Ebk22
         HIoqHmqGEQ845HntK7o2KJxiu0r5CuykcR4JN2uW1vAoDbFZmCxY87UTKVrFdrpxIr
         9mao0ErgBUpaW/ecAPIjjh8hE3KKjD9Ck55xqfIqBlrvlUSvcyk
Date:   Tue, 9 Oct 2018 22:25:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 06/14] packfile: express constants in terms of
 the_hash_algo
Message-ID: <20181009222516.GR432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
 <20181008215701.779099-7-sandals@crustytoothpaste.net>
 <CAGZ79kbirX6i+qkig6R1YOAsv=0BirhAVkar+AdBLyHgkrXYyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QU0xYvH/CPhunj+E"
Content-Disposition: inline
In-Reply-To: <CAGZ79kbirX6i+qkig6R1YOAsv=0BirhAVkar+AdBLyHgkrXYyg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QU0xYvH/CPhunj+E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 03:59:36PM -0700, Stefan Beller wrote:
> On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > Replace uses of GIT_SHA1_RAWSZ with references to the_hash_algo to avoid
> > dependence on a particular hash length.
>=20
> Unlike the previous patches, this is dealing directly with packfiles,
> which (I would think) carry their own hash function selector?
> (i.e. packfiles up to version 4 are sha1 hardcoded and version
> 5 and onwards will have a hash type field. Usually that hash type would
> match what is in the_repository, but you could obtain packfiles
> out of band, or the translation table that we plan to have might
> be part of the packfile/idx file?)

Yeah, the transition plan doesn't specify a format for pack files, but
we may end up needing one.  We definitely have a specified format for
index files already, and that's where the translation table will be.
Anything other than the pack index and the loose object index in the
=2Egit directory will have the same algorithm as the rest of the
repository, so technically we could use any pack format as long as it
lives in the .git directory.

This code is mostly here on an interim basis to let us compile with a
fully SHA-256 (no SHA-1) Git.  Once that piece is done, we can move on
to a stage 4 Git, which can do either only SHA-256, or only SHA-1, where
we'll learn about various pack file formats and detecting the algorithm
=66rom them.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--QU0xYvH/CPhunj+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlu9KssACgkQv1NdgR9S
9otltw//dc9/16Gj2catfm0sE0LwBJFlhBsqkvYPk8O0T22+wL3gNvDIRzj+r4a2
tz5MKmjt9gPePJy0QaLA0lN7Vz389RTfPQgOHj7yo++HnnF69UVQxQnBfmj+9DIl
GTnxS+DwooXdRlyd5l20T3BrlZXOAa9Cq5LVcE/Ut2qcE/SVLX6N3sYUAt6ZxS/5
S4ZcoSkDKWHBl/nqaAdr5hUul/9YRJmwSoNtj0W0ifatsAb7o/PnooztRQFel9jy
ubV5/pTnDj9hncMH9/Ylu29WDrRebgz7iStgUUJf16Nt2era0EFRdX8Tk17HiK85
GM1otkBhK2txElQXzOCTtbrGQPlccxIYai0eIjtzqsS1g9aX6PzkYPZQ33NvL8QO
m+1Q6uAeRFf1LpRYQh/8njo/KpKq/Cl046U2/uuUczIYvH9FlfI8hRHMY7xxmGtC
bcqP+hgcKu14+uexhpG6PAPLBmilEjT/w80AVZC+9PB74MxIUy4B5eXGs4KGopId
QHM8Ez1OT4g4Tucl+PjQrbD2cgPXzsWMe6Qfb4oPV47+bUQtpLrCVMVBZ4882QbY
jpNhTFhHGT8ozEkpn9ifOHqNq1tunpNIwLE3YboDb7kwQ6Z7tS0sJEEReXtfHHc8
jLE/zpnsxVMq1LwfsadvcbetK1vd5HHLprSKRgx7tDKUcqe7OJI=
=SPxs
-----END PGP SIGNATURE-----

--QU0xYvH/CPhunj+E--
