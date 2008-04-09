From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: git-merge adds test to a message -- bug?
Date: Wed, 9 Apr 2008 12:40:48 +0200
Message-ID: <20080409104048.GA1782@alea.gnuu.de>
References: <slrnfudp0q.19k.joerg@alea.gnuu.de> <7vabko3dm2.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241208400.4353@racer.site> <7viqzcvznm.fsf@gitster.siamese.dyndns.org> <20080325001247.GB26905@alea.gnuu.de> <alpine.LSU.1.00.0803252102140.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 12:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjXoT-0005AG-W6
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 12:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbYDIKpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 06:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbYDIKpM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 06:45:12 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2070 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077AbYDIKpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 06:45:11 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id CB0F0488033; Wed,  9 Apr 2008 12:45:08 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjXjU-0003WM-GH; Wed, 09 Apr 2008 12:40:48 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjXjU-0000T0-4L; Wed, 09 Apr 2008 12:40:48 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803252102140.10660@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79101>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Johannes,

Johannes Schindelin schrieb am Tue 25. Mar, 21:04 (+0100):
> On Tue, 25 Mar 2008, J=F6rg Sommer wrote:
> > Junio C Hamano schrieb am Mon 24. Mar, 09:45 (-0700):
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > > On Sun, 23 Mar 2008, Junio C Hamano wrote:
> > > >
> > > >> I unfortunately do not recall why _prepend_, and not _replace_, ha=
d=20
> > > >> to be the right behaviour.
> > > >
> > > > http://article.gmane.org/gmane.comp.version-control.git/31896/match=
=3Dgit+merge+make+usable
> > >=20
> > > So it was "my suspicion that people who would want to pass -m would=
=20
> > > want it to behave this way".
> > >=20
> > > I do not care deeply either way myself, as I never have found use for=
=20
> > > -m to the merge command, but I think it could have been argued either=
=20
> > > way.
> >=20
> > I would like to argue for the replace way. :) Take git rebase -p as an=
=20
> > example. If a merge is included in the rebase, it's redone with git=20
> > merge -m. Because git rebase works with detached heads you get merge=20
> > messages like this: [...]
>=20
> That only means that the original author of rebase -p was a lazy bastard=
=20
> and did not use the proper way to call git-merge, namely
>=20
> 	git <msg> HEAD <the-other-branch>

It this really a proper way to call git merge? The manpage says:

    The second syntax (<msg> HEAD <remote>) is supported for historical
    reasons. Do not use it from the command line or in new scripts. It is
    the same as git merge -m <msg> <remote>.

And how would you pass the option for the strategy to this form? Git
rebase calls git merge with -s.

Bye, J=F6rg.
--=20
But in the case of "git revert", it should be an ancestor (or the user
is just insane, in which case it doesn't matter - insane people can do
insane things)
Linus Torvalds <alpine.LFD.1.00.0801041031590.2811@woody.linux-foundation.o=
rg>

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/J0wwe0mZwH1VIARAlSoAJ94eBrVB7AMxeSqhLgoI1QD3Q5gqACfVJG4
uOtXAZwvqhj7O4E3pSG/Fq8=
=dxrr
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
