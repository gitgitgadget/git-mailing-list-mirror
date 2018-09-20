Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFD5A1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 00:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbeITFkn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 01:40:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34032 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbeITFkn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Sep 2018 01:40:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:68ab:e3d3:c0a3:4717])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BED8B60735;
        Thu, 20 Sep 2018 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537401620;
        bh=FUS3D5cywFnj6QJ7RDw3qBjf8jfoMr3+6YD5o0yimfM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=d42GyLDpq8PNj+jy3vBORPRgSeR0JXxMccvXVqzQXZdYZFfU5KCbSbztVqm6Tyj5x
         QPt9gQBxP+yh7txDC39tiYufqLrx8BpxMGM9VTRLXheLQ5jC3z4zIqBw1Ahbt6bSNM
         6/AmSofNZrQdFG7UrcYt+ub8eSfOvarYsdhkgDKv+jl8P2Po1ch3xuFc8rrnvXYiV1
         46xTa1L3XKzDoM5b72ulE6DdTXDaZBDMFR/yGKQk1qpGt0JElG9RwiVUdalURgrdM1
         NdDQp/85Ot1c5dEJ+rT8ELMB69kVnoQcrWdiDEEjMbCipt4AaupvJGu9AkGSflieBf
         THowAi/TlEcFEXNvq6G6z69MBEWzFULGcNh8NYesztEFtm7+ThHTJ8TdMiaUBgHhBT
         E0PnbutTzUz56D/q3r7fJKH2pyGtOLpBAagP/W0urS/pdU0rAS54X/dCwVw7MbtzT/
         KtOzIwrMZ02jiZLRpbnMk7Q7Y/NaTuZrFGF/xW7hUqmGwPYsoLu
Date:   Thu, 20 Sep 2018 00:00:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
Message-ID: <20180920000013.GZ432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
 <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FJ766Kk/2p6HVARF"
Content-Disposition: inline
In-Reply-To: <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FJ766Kk/2p6HVARF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 08:00:27PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > To make automatically configuring one's editor easier, provide an
> > EditorConfig file.  This is an INI-style configuration file that can be
> > used to specify editor settings and can be understood by a wide variety
> > of editors.  Some editors include this support natively; others require
> > a plugin.
>=20
> Good intentions.  One thing that makes me wonder is how well this
> plays with "make style" and how easy will it be to keep their
> recommendations in sync.  Ideally, if we can generate one from the
> other, or both from a unified source, that would be great.

I think "make style" and the EditorConfig file are complementary.  "make
style" autoformats code into a diff.  I agree that if we always used
clang-format to format code, then this would be a non-issue in the
EditorConfig file, since we'd just tell people to format their code and
be done with it.  However, we don't automatically do that, so I think
this still has value.

(I am having trouble getting make style to work, though, because it
seems to invoke clang-format as a git subcommand, and I don't think that
works.  I may send a patch.)

Even if we did that, we couldn't do it for Perl, because the tidy tool
for Perl, perltidy, produces different output depending on version.  I
expect we'll have little success in trying to standardize on a given
version.

The EditorConfig file applies to a variety of formats and is designed to
set default editor settings (which users *can* override if they choose).
It applies to any file pattern; for example, as Taylor pointed out, we
could use it to recommend 72-character lines in commit messages.

I agree that maintaining more files is a hassle, but personally, I think
it quite unlikely that we're going to change the Git style, so I feel
the maintenance is fairly low.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FJ766Kk/2p6HVARF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlui4w0ACgkQv1NdgR9S
9ou+4w//WNKWUhwWTUE120wZXScv9tAp7Q4drdKKUl4I6MS9EEpoZMJgJOYqBCer
05AGhoCxMTnBgNjAiAwx1K+WwESS3JuhUadHHq/8/Rpjbr9dvhGiQ68V+pE3Fo55
Oshg7iEnMUmS/MzwYn6rlATX2QtYpiYdcWAGueKn59Y+7leYzIYO54dyCTMoxi6G
rA7xLiFZ4YoweAHMZaNtadkQs5ihp9YoklFuLjIzKqDWG15GMqlP1GDa7gDSvLJe
+P5wq8NrLBjc2FpEcHSV6634ZP2hC+z6nmqJiO2QrTsPYHWwKBuOUCpkoJDRW/Ur
LRwiCnNNgfvilb/I1XqKgJFUR0zdnypeZqBc46xewdInY9oSdBoE4j7HvX/DNZhI
8tyJ5NlJOBE9sOedu0QoDhBlTMDdfnpptJj8ChY6p16gegVQohtob78w8rRmahLU
MbnJySgeU6TDS2GtvDeaMGjuycj7sbYywOIeV51SQkwkiG8b/4RdPJ4nM52lKtuP
uKhOX4uflbDURSpXWV6OVBoUV8jh+6j9b4/Sg0ie+Pq+5j9k5cLV7keBmniRLEhc
pT3693CLu6bq9laEHj0CpXUV+TzUasZTECPRqg38X6Zqc2areWSEoFsMMEVAsxAv
J43h6r0Ot72PGwYo4eXGheUzFjt7nbCoDtH4dwsH682UdDaBlL8=
=YVPz
-----END PGP SIGNATURE-----

--FJ766Kk/2p6HVARF--
