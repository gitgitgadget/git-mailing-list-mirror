From: Martin Waitz <tali@admingilde.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 21 Apr 2007 08:09:50 +0200
Message-ID: <20070421060950.GE27208@admingilde.org>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net> <7v647tcjr6.fsf@assigned-by-dhcp.cox.net> <20070419100757.GB27208@admingilde.org> <7vmz13z4au.fsf@assigned-by-dhcp.cox.net> <20070420193142.GA13080@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 08:10:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf8nb-00088u-2e
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 08:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbXDUGJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 02:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbXDUGJw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 02:09:52 -0400
Received: from mail.admingilde.org ([213.95.32.147]:42504 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbXDUGJw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 02:09:52 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hf8n8-00089S-L3; Sat, 21 Apr 2007 08:09:50 +0200
Content-Disposition: inline
In-Reply-To: <20070420193142.GA13080@uranus.ravnborg.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45150>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Apr 20, 2007 at 09:31:42PM +0200, Sam Ravnborg wrote:
> On Fri, Apr 20, 2007 at 04:14:01AM -0700, Junio C Hamano wrote:
> >=20
> > Making git.git the first guinea pig has a unique bootstrapping
> > problem involved, however.  These kind of changes in git.git
> > itself has to wait at least until what we have in 'next' today
> > is in everybody's hands.  Otherwise, people who want to use git
> > for their real work need to first grab a tarball snapshot that
> > has the plumbing subproject support, and then update to
> > 'master', because we are still too fast moving for any distro
> > binary packaged version to be satisfactory solution for people
> > who want to have all the bells and whistles.  Also, I cannot
> > have subproject in git.git until kernel.org starts running git
> > with subproject support -- otherwise nobody can clone or pull
> > from git.git X-<.
>=20
> The bootstrapping issue could be fixed by having a separate
> git-subproject.git on kernel.org.
>=20
> But I see no easy solution for the requireent for kernel.org to
> a new git (and I doubt kernel.org sysadmin is too keen to
> update to a next-based git).

Well, it only needs to be new enough to understand enough of
submodules so that it can play the server part.
So once we are in that part to be stable we can merge it to master,
so that kernel.org can use it.
Full submodule support should then mature until the next major version
after which git.git could use it itself.

--=20
Martin Waitz

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGKaquj/Eaxd/oD7IRArGbAJ0Wia1sYkaQQhu803MatmcVVl78vQCeMCuw
MQMamatrZ+Q5/96AULFTGkw=
=9e9t
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
