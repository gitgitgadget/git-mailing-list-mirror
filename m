Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE571FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbcGSSy4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:54:56 -0400
Received: from vpn.foo.tf ([195.154.43.236]:57854 "EHLO mail.foo.tf"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcGSSyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:54:55 -0400
Received: from localhost (unknown [10.10.68.1])
	by mail.foo.tf (Postfix) with ESMTPSA id 956E038953D;
	Tue, 19 Jul 2016 18:54:53 +0000 (UTC)
Date:	Tue, 19 Jul 2016 20:54:52 +0200
From:	Antoine Tenart <antoine.tenart@ack.tf>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Antoine Tenart <antoine.tenart@ack.tf>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
Message-ID: <20160719185452.GB28551@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf>
 <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 08:23:58PM +0200, Duy Nguyen wrote:
> On Tue, Jul 19, 2016 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> 080739b (worktree.c: find_worktree() search by path suffix -
> 2016-06-13) from 'next' should help identify worktrees in this case by
> specifying 'project0/foo', 'project1/foo'... Granted it's not fun to
> type all that when 'project0/foo' is something long, and bash
> completion probably does not help much either.

So with this I'll be able to create new worktrees, using paths having
the same basename, but in different let's say "project directories"?

> Note that we may need a unique name elsewhere too, e.g.
> refs/worktrees/xyz (even though we haven't settled on this yet). Then
> xyz would be more exposed to the user and an easily recognizable name
> would be a good thing.

Having a recognisable name surely is a good thing, when performing some
(rare) manual operations. Like moving a worktree (or is there a command
for this?)

Thanks,

--=20
Antoine

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXjnd8AAoJEFxNi8it27zYXDgP/AyIK5jTFDFtY2QfXoF5hUtJ
JIMeGLremCihH2pj2pjDyMYJrYBoF8WiBTXoaWaOaEeRGE2bzQa0DwKJ3Vm+LQ3L
Ha9Fh5h8lDl/wUJ738A7aR+UDCqQWQXwKFYV7aQ65MmHrztKExUf/szkLLt+s4dH
seyV4zUcSwfHFtp3GVQapIGYY7bS5O3WVr6snpTJMedANBxL+TCfIO0pcPmq34Sv
rFwTVG7Pi9Z1ks4hpyARjsqnR59a4SwUwhcI4++8sL/xeP9ApcD3jKt2jH/CGwPe
D/nO5gdUYqD2t0F5KVrDQ7Zb6eYV5Wt3YuxQvEkEqF8VYLNlm05dHDdcWgkN6ngO
Yphm0PXy4TyLyD0zourGEQndZGPs/t+lYRQp9GhRVfDvy/cq3xAOTbYtdHo+CLf8
2+vgXwPtOt08T46Duu43z+ml0y4sFFL98+wdmi2pRFU6VgnGREhoHqASgrKWZwLT
BPG55Lr5Q5LmddK2Ebf4U7sL4vNsCCglVwLqGWfN3E0NU64OMwzzH6bPEgTzuifu
7UK8RwMJFA7U7Qxia5ZVjwuuV1ob55yELkoCMzwxl2kfMFdXk+OWgleegQbNJ6Mz
9HDAmReX8bYtdU+zqQlblTYjjPIFoWDLo1iLu/3zZBvfY131BV5LkNP9RGjEUuPa
LiEEw+MhCtltodZ0dxBp
=lQzM
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
