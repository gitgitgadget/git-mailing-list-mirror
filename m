From: Martin Waitz <tali@admingilde.org>
Subject: Re: git refuses to switch to older branches
Date: Sun, 20 Aug 2006 14:19:35 +0200
Message-ID: <20060820121935.GF30022@admingilde.org>
References: <20060819202558.GE30022@admingilde.org> <7vac601hbb.fsf@assigned-by-dhcp.cox.net> <20060820072612.GA6003@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 14:20:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEmHT-0000Xs-Un
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 14:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWHTMTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWHTMTh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 08:19:37 -0400
Received: from agent.admingilde.org ([213.95.21.5]:38042 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750758AbWHTMTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 08:19:37 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GEmH9-0003Uj-A4; Sun, 20 Aug 2006 14:19:35 +0200
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060820072612.GA6003@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25749>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Aug 20, 2006 at 09:26:12AM +0200, Alex Riesen wrote:
> Junio C Hamano, Sun, Aug 20, 2006 00:39:20 +0200:
> > Martin Waitz <tali@admingilde.org> writes:
> >=20
> > > This safety measure is quite useful normally, but for files that are
> > > explicitly marked as to-be-ignored it should not be neccessary.
> > >
> > > But all the code that handles .gitignore is only used by ls-files now.
> > > Does it make sense to add exclude handling to unpack-trees.c, too?
> >=20
> > In principle, I am not opposed to the idea of making read-tree
> > take the ignore information into consideration.
> >=20
> > But I would suggest you to be _extremely_ careful if you want to
>=20
> It should be optional. And off by default, people already have got
> scripts depending on this behaviour (well, I have).

but having this sort of behaviour optional is bad, I think.
Some people will depend on one semantic and others on the other.
And then get bite if they want to share their scripts.
We have to find _one_ semantic that always works.

> > try this.  I do not have an example offhand, but I would not be
> > surprised at all if there is a valid use case where it is useful
> > to have a pattern that matches a tracked file in .gitignore
> > file.
>=20
> Ignored directory and but some files/subdirectories in it are tracked,
> because this is temporary or externally changed data (I have both
> examples).

but do you have non-tracked files in the ignored directory that you
really care about, i.e. which must not be overridden by a tracked file
with the same name?

--=20
Martin Waitz

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE6FNXj/Eaxd/oD7IRArFgAJ461T38nezHZ/jGbVJKwyzxhMEzTQCePCs9
gEk3egQ7HmGhzRREUsd9AG4=
=hpTL
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
