From: Martin Waitz <tali@admingilde.org>
Subject: Re: git refuses to switch to older branches
Date: Sun, 20 Aug 2006 20:15:11 +0200
Message-ID: <20060820181511.GH30022@admingilde.org>
References: <20060819202558.GE30022@admingilde.org> <7vac601hbb.fsf@assigned-by-dhcp.cox.net> <20060819224457.GB23891@pasky.or.cz> <20060820122128.GG30022@admingilde.org> <Pine.LNX.4.63.0608201447470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 20:15:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GErpP-0004Vt-Tr
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 20:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWHTSPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWHTSPQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 14:15:16 -0400
Received: from agent.admingilde.org ([213.95.21.5]:21663 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750931AbWHTSPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 14:15:15 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GErpH-0006Sg-UR; Sun, 20 Aug 2006 20:15:11 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608201447470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25760>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Aug 20, 2006 at 02:48:34PM +0200, Johannes Schindelin wrote:
> On Sun, 20 Aug 2006, Martin Waitz wrote:
> > On Sun, Aug 20, 2006 at 12:44:57AM +0200, Petr Baudis wrote:
> > > Dear diary, on Sun, Aug 20, 2006 at 12:39:20AM CEST, I got a letter
> > > where Junio C Hamano <junkio@cox.net> said that...
> > > > But I would suggest you to be _extremely_ careful if you want to
> > > > try this.  I do not have an example offhand, but I would not be
> > > > surprised at all if there is a valid use case where it is useful
> > > > to have a pattern that matches a tracked file in .gitignore
> > > > file.
> > >=20
> > >   *.o and binary blobs of closed-source software.
> >=20
> > but if you want to switch from one branch which has the .o file
> > built from source to another branch which has the .o file tracked
> > in binary form, wouldn't you want to remove the generated file
> > in order to store the tracked one from the new branch?
>=20
> Not necessarily. Sometimes you have files in your working directory, whic=
h=20
> are not in your repository, you know?

Sure. But we are only talking about files which are explicitly
ignored in one branch and are tracked in another branch.

Perhaps it makes sense to check that the file is _not_ ignored in the
other branch (in which it is tracked).
Would such a check make everybody happy?

Is there an easy way to check if some file is marked as ignored in
an other branch?


--=20
Martin Waitz

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE6Kavj/Eaxd/oD7IRAuKBAJ4k9NsNtCEiMWU6y4jFjFwd/PPUFgCfd95T
RcFYKVDkTlAtGfSxDghvELY=
=FFBG
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
