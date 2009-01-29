From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 13:04:55 +0100
Message-ID: <20090129120455.GD3027@denkbrett.schottelius.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl> <20090129114834.GA10792@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 13:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVf5-0002MB-JC
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 13:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbZA2ME6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 07:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753855AbZA2ME5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 07:04:57 -0500
Received: from mx3.schottelius.org ([77.109.138.221]:35062 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZA2ME4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 07:04:56 -0500
Received: from ikn.ethz.ch (ikn.inf.ethz.ch [129.132.130.3])
	by mx3.schottelius.org (Postfix) with ESMTPSA id 405A9197A055;
	Thu, 29 Jan 2009 13:04:53 +0100 (CET)
Received: by ikn.ethz.ch (Postfix, from userid 1000)
	id 7BA73770A4; Thu, 29 Jan 2009 13:04:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090129114834.GA10792@coredump.intra.peff.net>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: ikn (Linux 2.6.28-rc9-wl-denkbrett-24896-gf4f5c96 x86_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107665>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King [Thu, Jan 29, 2009 at 06:48:34AM -0500]:
> [...] I think that is what people who ask for empty cloning really want:
>=20
>   1. make a bare upstream
>=20
>   2. clone empty repo
>=20
>   3. create commits
>=20
>   4. git push / git pull, as if we had cloned non-empty repo

I must confess, as a user I would like to do

1. create local repo

2. create a remote

3. push it

I don't care about creating empty repos somewhere:
My aim is to publish my work, that's it.

Comments on the steps:

  1.1. I don't care whether I push a empty repo or not. But pushing an empty
       one does not make much sense, so refusing this would be reasonable

  1.2. When creating a new repo, it would be helpful if I can directly add a
       description: git init [description] would be nice to have

  2.1. I (as a user) understand that I need to create a remote where I have=
 to
       push to. It would be helpful to specify --track-this/--merge-this to
       have it automatically connected to the current branch

  3.1.  I would really like to see something like git push
        --create[-if-not-exists]. This makes sense for me, but could also
        be a global configuration option (push.autocreate =3D true|false).


Just a comment from a user's point of view ;-)

Sincerly,

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmBm2cACgkQuL75KpiFGIxHbQCeIgh8cT2aWkC+H8GhzqVtbbJL
gQwAnR5AlRlKAe+Epiws2HaA3uPU6UPG
=n+L5
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
