From: Simon Fowler <simon@dreamcraft.com.au>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 23:13:50 +1000
Message-ID: <20050428131350.GL17682@himi.org>
References: <200504271251.00635.mason@suse.com> <200504271831.47830.mason@suse.com> <20050428084156.GK17682@himi.org> <200504280756.58293.mason@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TN8pJM9vJMHHFgJc"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 15:09:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR8kv-0000lD-34
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 15:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVD1NOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVD1NOE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:14:04 -0400
Received: from dreamcraft.com.au ([202.55.152.18]:6637 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S262113AbVD1NN6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 09:13:58 -0400
Received: from private.himi.org (dsl-203-113-232-142.ACT.netspace.net.au [203.113.232.142])
	by dreamcraft.com.au (Postfix) with ESMTP id 110B55B986;
	Thu, 28 Apr 2005 23:14:21 +1000 (EST)
Received: by private.himi.org (Postfix, from userid 1000)
	id 876CCB6F0; Thu, 28 Apr 2005 23:13:51 +1000 (EST)
To: Chris Mason <mason@suse.com>
Mail-Followup-To: Chris Mason <mason@suse.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200504280756.58293.mason@suse.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--TN8pJM9vJMHHFgJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2005 at 07:56:57AM -0400, Chris Mason wrote:
> On Thursday 28 April 2005 04:41, Simon Fowler wrote:
> > I've got a version of this written in C that I've been working on
> > for a bit - some example output:
> >
> > +040000 tree    bfb75011c32589b282dd9c86621dadb0f0bb3866        ppc
> > +100644 blob    5ba4fc5259b063dab6417c142938d987ee894fc0        ppc/sha=
1.c
> > +100644 blob    c3c51aa4d487f2e85c02b0257c1f0b57d6158d76        ppc/sha=
1.h
> > +100644 blob    e85611a4ef0598f45911357d0d2f1fc354039de4      =20
> > ppc/sha1ppc.S commit
> > b5af9107270171b79d46b099ee0b198e653f3a24->a6ef3518f9ac8a1c46a36c8d27173=
b1f7
> >3d839c4
> >
> > You run it as:
> > find-changes commit_id file_prefix ...
> >
> > The file_prefix is a path prefix to match - it's not as flexible as
> > regexes, but it shouldn't be too much less useful.
>=20
> I dropped the regexes for speed with diff-tree, they weren't that importa=
nt to=20
> me...The features I was going for are:
>=20
> 1) ability to see the changeset comments in the output.

I'll add a -v option tomorrow (it's 11pm here) to show the commit
comments in the output, if you like the idea.

> 3) Some quick cut n' paste method to generate the changeset diff.  This i=
s why=20
> I do diff-tree -r in the output, so I can just copy into a different wind=
ow=20
> and go.
>=20
Would the two commit sha1s space seperated, rather than with the
'->', be better for that? I'm a little reluctant to have it output
the full 'diff-tree -r' thing, since it's inconsistent with the
other tools.=20

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--TN8pJM9vJMHHFgJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCcOGNQPlfmRRKmRwRApvQAKCUufiNyS1PHCwXkwtA3zt6BIQk1QCfQpCB
LhZwOTXvULnRFDh/cwILfFQ=
=KjHt
-----END PGP SIGNATURE-----

--TN8pJM9vJMHHFgJc--
