Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AD120401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbdFNLAA (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:00:00 -0400
Received: from sunbase.org ([178.79.142.16]:53594 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdFNK77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:59:59 -0400
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1dL61k-0004RS-S0; Wed, 14 Jun 2017 10:59:56 +0000
Date:   Wed, 14 Jun 2017 12:59:56 +0200
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure.ac: loosen FREAD_READS_DIRECTORIES test program
Message-ID: <20170614105955.aj4rtamzp4yy6g6b@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170614011514.sh4euddp44hjbu4u@sunbase.org>
 <20170614012535.GU133952@aiede.mtv.corp.google.com>
 <20170614021739.erkdifufziwiqjxp@sunbase.org>
 <20170614050215.c32crnjifah6cxae@sigill.intra.peff.net>
 <20170614051544.cz2zvnkc4mlysz7h@sigill.intra.peff.net>
 <20170614053018.pbeftfyz2md4o73h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6asl4ihl2262o723"
Content-Disposition: inline
In-Reply-To: <20170614053018.pbeftfyz2md4o73h@sigill.intra.peff.net>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170609-18-9a0a4f (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6asl4ihl2262o723
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-06-14 01:30:18, Jeff King wrote:
> On Wed, Jun 14, 2017 at 01:15:44AM -0400, Jeff King wrote:
> > Actually, I'm not sure if configure.ac is wrong, or the new uses of=20
> > FREAD_READS_DIRECTORIES. Because the test configure.ac actually=20
> > checks:
>
> Poking around more, I think the best thing is to just update the=20
> configure script. The rationale is below.
>
> -- >8 --
> Subject: [PATCH] configure.ac: loosen FREAD_READS_DIRECTORIES test=20
> program

Yes, this patch fixes t1308. I also ran the whole test suite with the=20
patch, everything succeeds.

Thanks,
=C3=98yvind

N 60.376=C2=B0 E 5.3334=C2=B0
OpenPGP fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5
17e7451e-50f0-11e7-a287-db5caa6d21d3

--6asl4ihl2262o723
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllBFysACgkQ+wy+6JSlBuVTLwCfcM147Z4Dy6COQn4XunisRaAS
q5kAmwXl5GkiBnAHp6pAqTCtOlT0MOVe
=Kj50
-----END PGP SIGNATURE-----

--6asl4ihl2262o723--
