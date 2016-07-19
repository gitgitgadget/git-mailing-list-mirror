Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A5D2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 19:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbcGSTfe (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:35:34 -0400
Received: from vpn.foo.tf ([195.154.43.236]:50574 "EHLO mail.foo.tf"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbcGSTfd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:35:33 -0400
Received: from localhost (unknown [10.10.68.1])
	by mail.foo.tf (Postfix) with ESMTPSA id 9328638A5CE;
	Tue, 19 Jul 2016 19:35:23 +0000 (UTC)
Date:	Tue, 19 Jul 2016 21:35:23 +0200
From:	Antoine Tenart <antoine.tenart@ack.tf>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Antoine Tenart <antoine.tenart@ack.tf>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
Message-ID: <20160719193523.GD28551@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf>
 <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com>
 <20160719185452.GB28551@kwain>
 <CACsJy8AkpBmNS0nOoKX7PUYhp9kKgvH=K2gpCnq+sR++ZmDAgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <CACsJy8AkpBmNS0nOoKX7PUYhp9kKgvH=K2gpCnq+sR++ZmDAgQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 09:04:11PM +0200, Duy Nguyen wrote:
> On Tue, Jul 19, 2016 at 8:54 PM, Antoine Tenart <antoine.tenart@ack.tf> w=
rote:
> > On Tue, Jul 19, 2016 at 08:23:58PM +0200, Duy Nguyen wrote:
> >> On Tue, Jul 19, 2016 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> >>
> >> 080739b (worktree.c: find_worktree() search by path suffix -
> >> 2016-06-13) from 'next' should help identify worktrees in this case by
> >> specifying 'project0/foo', 'project1/foo'... Granted it's not fun to
> >> type all that when 'project0/foo' is something long, and bash
> >> completion probably does not help much either.
> >
> > So with this I'll be able to create new worktrees, using paths having
> > the same basename, but in different let's say "project directories"?
>=20
> Well, internal name is still out of your control, but if you want to
> do something to a worktree you can say "do project0/foo". With 'next'
> those verbs can be lock and unlock. We probably can make 'worktree
> list' take filter and show just one worktree (and just add "git
> worktree show" for that).

Hmm, so if I understand correctly my use case still won't be supported,
as adding a new worktree with the same basename will fail. Or did I miss
something?

--=20
Antoine

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXjoD6AAoJEFxNi8it27zY+w4P/224G/4synnXa2GKqfZoCcBo
ru2Dkji930d7nOdwY50FxH3kWZbA+n8l/Vv0Shlca9GiB+8ZLgsao98p+L93HAfi
qCOFf2rMWg4sGewXfzYURbOyaVEM8/lKed/xWYNXkTECP2O11QkAa+0+vX3n3AuP
rv7l1lQ/o4ZTRX6DPRt6WMIcbtnhlRfIYmrd0OBQ6bU5/WNwf2t7fM7xroKCCDw9
5V6zhoi3Hlqa5u6Xb3Xc/MI2sfzOyUwMfPYuihnBv4TELEZvMoDjtw9ufpwhOEt9
oF2/tR+OYBRvpH5b6gxrdaASWo0bvia0SruQLiOX/kk6IGB0Ur3Cxp87y1rfLnie
a9oaVoPvGZaab09INM6ShmFG2LXzsBIq5HZHuqXLPRlgqnPRLVe9A4ekt/nlo8xj
X9K4Rb4xiJ4a2ANtRZHMpR19BXk83oENagiid+gOYgeXGqrRY7QtFlgbg8nytfJe
ABT/95LbY/LhQH8YgFXMHDEfmRKP7wSaT3aWy0E0K3HrC/m0Ty0PD4KfNFMq6iWs
otyeymPgF062jX2g+QlSNng/lkg5IZ4gEtlJcuWb0MKtipThEusH1aPj3u/fXvWh
NEQ+geLbFVmyETFNfwsj9EndMvp3z2Bxs5UBXiZ7xlTBGfgg0px+e+mGIyR83txQ
DOrIi5NLrrW2+MJ56BaW
=K9Zu
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
