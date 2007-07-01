From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Qgit RFC] commit --amend
Date: Sun, 1 Jul 2007 14:26:25 +0200
Message-ID: <20070701122625.GC26243@efreet.light.src>
References: <20070610150839.GG4084@efreet.light.src> <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com> <20070611044258.GJ4084@efreet.light.src> <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 14:26:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4yVd-0002SH-HT
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 14:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbXGAM0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 08:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755672AbXGAM0b
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 08:26:31 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:59454 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523AbXGAM0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 08:26:30 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8523A5738A;
	Sun,  1 Jul 2007 14:26:29 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id uXTNrRUPMz4U; Sun,  1 Jul 2007 14:26:28 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 245B35728A;
	Sun,  1 Jul 2007 14:26:28 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I4yVV-0001up-7H; Sun, 01 Jul 2007 14:26:25 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51290>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2007 at 07:45:51 +0200, Marco Costalba wrote:
> On 6/11/07, Jan Hudec <bulb@ucw.cz> wrote:
> >
> >I think I mostly understood it now. Thank you.
> >
>=20
> Anyhow I think this could be useful to you:
>=20
> 	/*
> 	   getAllRefSha() returns the list of sha of a given
> 	   type, where type is a mask of Git::RefType flags
> 	   see src/git.h.
> 	   In this case we want the sha of the current branch
> 	*/
> 	QStringList revs =3D getAllRefSha(CUR_BRANCH);
> =09
> 	if (!revs.isEmpty()) {
>=20
> 		// all the sha info is stored in this QGit::Rev
> 		// class defined in src/common.h
> 		const Rev* r =3D revLookup(revs.first());
>=20
> 		// short log (title) is
> 		r->shortLog();
>=20
> 		// message body is
> 		r->longLog();
>=20
> 		// etc....
> 	}

Thanks.

I got stuck at git-commit --amend -F not working (because it's explicitely
forbidden), so I have to reimplement all of the commit stuff with plumbing
commands. I am in the middle of rewriting it currently. Unfortunately the
plumbing is a little too low-level.

However, I am currently not sure how to handle errors. If the current commit
fails, it will show a message box with it's output, but I can't see where it
is generated. It seems it's somewhere inside MyProcess, so I don't have to =
do
anything special though, right?

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGh51xRel1vVwhjGURAldZAJ41KjzAFO23lVB11dKofRYAP26deQCeLu7F
MAc9qKcgr2w9NKGSSMOfF+0=
=sK1p
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
