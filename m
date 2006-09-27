From: Martin Waitz <tali@admingilde.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 13:38:13 +0200
Message-ID: <20060927113813.GC8056@admingilde.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 13:39:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSXk3-0006rI-Du
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 13:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965578AbWI0LiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 07:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965584AbWI0LiQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 07:38:16 -0400
Received: from agent.admingilde.org ([213.95.21.5]:28294 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S965578AbWI0LiP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 07:38:15 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GSXjx-0004PA-Tr; Wed, 27 Sep 2006 13:38:13 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27899>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 27, 2006 at 11:55:22AM +0200, Johannes Schindelin wrote:
> > My current approach is like this:
> >=20
> >  * create a .gitmodules file which lists all the directories
> >    which contain a submodule.
> >  * the .git/refs/heads directory of the submodule gets stored in
> >    .gitmodule/<modulename> inside the parent project
>=20
> Taking this a step further, you could make subproject/.git/refs/heads a=
=20
> symbolic link to .git/refs/heads/subproject, with the benefit that fsck=
=20
> Just Works.

in fact it is done this way (more or less).

> Nevertheless, you have to take care of the fact that you need to commit=
=20
> the state of the root project just after committing to any subproject.

why?

You can accumulate as many changes in different subprojects until you
get to a state that is worth committing in the parent project.
All these changes are then seen as one atomic change to the whole
project.

--=20
Martin Waitz

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFGmKlj/Eaxd/oD7IRAkhVAJ4/+BsDFnz+teX5no+/RH20M/654ACfeqFG
Pd9of5b0HA6x5lQr1P1lg8Q=
=OYym
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
