Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1868D1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbcGTQM3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:12:29 -0400
Received: from vpn.foo.tf ([195.154.43.236]:43898 "EHLO mail.foo.tf"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbcGTQM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 12:12:27 -0400
Received: from localhost (unknown [192.168.99.5])
	by mail.foo.tf (Postfix) with ESMTPSA id 98B66874494;
	Wed, 20 Jul 2016 16:12:25 +0000 (UTC)
Date:	Wed, 20 Jul 2016 18:12:25 +0200
From:	Antoine Tenart <antoine.tenart@ack.tf>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Antoine Tenart <antoine.tenart@ack.tf>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
Message-ID: <20160720161225.GA23406@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf>
 <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com>
 <20160719185452.GB28551@kwain>
 <CACsJy8AkpBmNS0nOoKX7PUYhp9kKgvH=K2gpCnq+sR++ZmDAgQ@mail.gmail.com>
 <20160719193523.GD28551@kwain>
 <CACsJy8AatsjV7L6u6oA5xx+=K9hc9pjYTm_-XxxHHQ8aG9HyeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <CACsJy8AatsjV7L6u6oA5xx+=K9hc9pjYTm_-XxxHHQ8aG9HyeQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 04:54:40PM +0200, Duy Nguyen wrote:
> On Tue, Jul 19, 2016 at 9:35 PM, Antoine Tenart <antoine.tenart@ack.tf> w=
rote:
> >
> > Hmm, so if I understand correctly my use case still won't be supported,
> > as adding a new worktree with the same basename will fail. Or did I miss
> > something?
>=20
> Hm... _what_ fails? If you create two worktrees project0/foo and
> project1/foo, you'll get .git/worktrees/foo and .git/worktrees/foo1
> but worktree creation should succeed both times. As long as you don't
> have to look into .git/worktrees/ everything should be fine, you won't
> see foo vs foo1.

You're right, I don't know why I was sure this wasn't working... Sorry
for the noise :-)

--=20
Antoine

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXj6LoAAoJEFxNi8it27zY1x4QAIGyUS1wJ0aChMl0g22FxWlH
hx9uW01n/qsBZdlIQfMCWExz+eZ2WIsPiNMTYSjcE/iwu1tMcvxvTw45Tt54Szbt
qsjAEmhA+o5+fz1IlpCGbomE1MlR6k3f/EmT/hsiYTQbtTWAYfGc/YXt6PbxLMaz
UFq8qyofQ5ncgdarrrUSdYcRP06T6K+9CNGhRs4PUpqHNa5t+jKwxgplyjMrpGvL
jNsgE82Zl8G130J5nErU58iqXEk35BQR08mtxU6e/92ARCGV60/IG1k1Aj6YddnQ
qidKcj/ZG8PGPgwrZG+UL3dLYkSdjB5/LryRueQ+3zqXWOL30Rq7dtABnhT67rgV
PunD3e9PRPxxea9/KhnJmfO0OdrrN9sFrGICm5pdQ3xZs5ZpqO09qfWOyujlpxKL
BWD9wpj+hvgKXg7UKZouyOKKIWqbzkUmg90nk7uMgAAV7VX8OEZA0DiT0Rn869D2
1l8SNAjXZWiJkoKljX4zj9sax1XdjeY6krNbEm0nZBnMekimFUBeoBcl4By8XQrH
UfxSSiWFaVrDcH3ZdpXiA+xS7qdmbvdryn38Ym+FF1mUz46nXuFXfrwOQm5jaQtU
HHLDAslefZClqKo7RvAnrcioeuoDiQsI3JCrzukMEur3ada5uLua7Qof8bSSiaZf
maeEF4Z4W90ltzXPTtR5
=gNuu
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
