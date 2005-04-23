From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Catching up: git-pasky-0.6.2 broken?
Date: Sat, 23 Apr 2005 18:19:52 +0200
Message-ID: <1114273192.27940.17.camel@nosferatu.lan>
References: <20050423124758.B32116@flint.arm.linux.org.uk>
	 <20050423151238.C32116@flint.arm.linux.org.uk>
	 <20050423152102.D32116@flint.arm.linux.org.uk>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QmhkttKNRqmH0qqeUWkB"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 18:11:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPNED-00077Y-PR
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 18:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVDWQQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 12:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVDWQQG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 12:16:06 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:30142 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261527AbVDWQP4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 12:15:56 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id D43F825A4;
	Sat, 23 Apr 2005 18:15:52 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 15DBA3A2430;
	Sat, 23 Apr 2005 18:22:16 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26022-06; Sat, 23 Apr 2005 18:22:12 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 1E4C73A241A;
	Sat, 23 Apr 2005 18:22:12 +0200 (SAST)
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050423152102.D32116@flint.arm.linux.org.uk>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-QmhkttKNRqmH0qqeUWkB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-04-23 at 15:21 +0100, Russell King wrote:
> On Sat, Apr 23, 2005 at 03:12:39PM +0100, Russell King wrote:
> > On Sat, Apr 23, 2005 at 12:47:58PM +0100, Russell King wrote:
> > > Any ideas what's going on?
> >=20
> > Could the problem be related to some random garbage left in .git/add-qu=
eue
> > and .git/rm-queue?
> >=20
> > If so, how did these files get generated in the first place, and why
> > weren't they removed when they were finished with?
> >=20
> > IMHO updating a repository from an external source should _NOT_ be
> > affected by the presence (or absense) of these two files, which
> > contain only _local_ state information.
>=20
> Ok, don't bother looking into this - I'm now completely git-free here.
> I think I'll prefer to use the old diff and patch method to submit
> stuff to Linus, until git has progressed sufficiently such that it
> doesn't end up wasting hours of my time.
>=20
> Yes, it's a radical solution, but since I _can't_ get it to work for
> me, it's the only one which will allow me to get any real work done.
>=20
> (and it all looked soo promising pre-0.6.2)
>=20

You did try 0.6.3?  Think it fixed some annoying bugs.  Also pull and
reinstall it to make sure one or two others might be fixed.


--=20
Martin Schlemmer


--=-QmhkttKNRqmH0qqeUWkB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCanWoqburzKaJYLYRAtagAJ4h3w9N/vEZuf+5SqN3a0bPUNoTUQCfTI3Y
pRlRpYPdsPygvxgr3c+yAOM=
=sWNt
-----END PGP SIGNATURE-----

--=-QmhkttKNRqmH0qqeUWkB--

