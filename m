Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663592018F
	for <e@80x24.org>; Tue, 19 Jul 2016 19:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcGSTdz (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:33:55 -0400
Received: from vpn.foo.tf ([195.154.43.236]:49584 "EHLO mail.foo.tf"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbcGSTdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:33:54 -0400
Received: from localhost (unknown [10.10.68.1])
	by mail.foo.tf (Postfix) with ESMTPSA id 547FF3880F1;
	Tue, 19 Jul 2016 19:33:53 +0000 (UTC)
Date:	Tue, 19 Jul 2016 21:33:51 +0200
From:	Antoine Tenart <antoine.tenart@ack.tf>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Antoine Tenart <antoine.tenart@ack.tf>, git@vger.kernel.org,
	pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH] worktree: add: introduce the --name option
Message-ID: <20160719193351.GC28551@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf>
 <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <20160719184510.GA28551@kwain>
 <xmqqh9blfntw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <xmqqh9blfntw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 12:08:11PM -0700, Junio C Hamano wrote:
> Antoine Tenart <antoine.tenart@ack.tf> writes:
>=20
> > Being able to manually define the name can also be useful in some (rare)
> > cases, where you reorganize your project directory tree. But that's not
> > a strong argument for adding this option :-)
>=20
> Continuing the rationale that rejected the topic from the earlier
> discussion thread, the above is like saying that we should expose
> inode number more to the users and and allow users to tell a
> specific inode number to use when creating an entry in a directory,
> which would allow users to edit the directory with binary editor and
> replace the entry with the same inode number to move or rename the
> path.  The discussion considers that the "name" is an implementation
> detail of the worktree subsystem, like inode number is for a
> filesystem implementation.  A proper solution would be to invent
> "mv" command ;-).

Hehe :-)

--=20
Antoine

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXjoCeAAoJEFxNi8it27zYbDUP/2o0kDSLaf5Firt+Sf0LiXFq
MEFIKSOlZI6AKJRu/dl/uR/eOdabcXxYlihvptko3hwH9s7WakScHGL5P2xNHVem
bf6+9mviCRv9r/AzwHdBydOxSMaHPFL1aeqWO9UZihwxNV5uvl3W0dO3wXs+wLxI
tPf482RNelVSvOixJrEnhFr0wW5Ldyxi5TFeBMlk6Edfp4yl/eAXwEeMDD1njyn6
PjHb2tkZdQMBkN1f6sks/4rBroGDxhkp1Vmm3zL2fku/vqHQ73cM6A/rx6zl6kjJ
PaIFC0BEAZOx2+OlJLwLMd9bInU7tHWNmZiF/67LyCVgqKno1nzgYA6L8zFGugjM
1Y1Jc4miIwVuNGEtdFIlMGcyFbMGjq4rfTWyeZSb9jtjc2CK1MsxerR/AkeRi3y9
S2oKhlsZ8v0G84vTiljA5b/KiFGl0Uv+WOFKFCdSEP0H/Zm5PFTGDQtiM9Hv1kz4
Tc0J4rdD0MRo5NDyyK7QtVkvyCdxc0OqX1OqEeJ2Y8UfiqViXG5GN8JgWy1zMBDz
KA9oU1QNTv2iZBdhzFahX7wOnlWlzq9jcHCv7bvsirLV/Z1MTW4H3xfQVFE0Kmve
uj3ys0IO75KfQ/JUPAWCiVTD4Re4z+NzWfz3BCrOEDrKu5aak4Mn/11+VKZG0fQi
afTfSVtpNxjxcCAXhO82
=4xGG
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
