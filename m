From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 06/10] Unify the lenght of $SHORT* and the commits
	in the TODO list
Date: Sat, 12 Apr 2008 11:13:45 +0200
Message-ID: <20080412091345.GA31356@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de> <7vej9cndqp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 12:21:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkcrF-0003Fp-Hy
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 12:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710AbYDLKUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 06:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756991AbYDLKUO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 06:20:14 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4682 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291AbYDLKUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 06:20:13 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 3BE40488053; Sat, 12 Apr 2008 12:20:08 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jkbnt-0000mi-IL; Sat, 12 Apr 2008 11:13:45 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jkbnt-0008GQ-7y; Sat, 12 Apr 2008 11:13:45 +0200
Content-Disposition: inline
In-Reply-To: <7vej9cndqp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79343>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Junio C Hamano schrieb am Fri 11. Apr, 17:00 (-0700):
> J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> > ---
> >  git-rebase--interactive.sh |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 1698c3e..060b40f 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -600,9 +600,9 @@ do
> >  			MERGES_OPTION=3D--no-merges
> >  		fi
> > =20
> > -		SHORTUPSTREAM=3D$(git rev-parse --short $UPSTREAM)
> > -		SHORTHEAD=3D$(git rev-parse --short $HEAD)
> > -		SHORTONTO=3D$(git rev-parse --short $ONTO)
> > +		SHORTUPSTREAM=3D$(git rev-parse --short=3D7 $UPSTREAM)
> > +		SHORTHEAD=3D$(git rev-parse --short=3D7 $HEAD)
> > +		SHORTONTO=3D$(git rev-parse --short=3D7 $ONTO)
>=20
> Lacking is a better justification as to why this is a good change

=E2=80=9CThis makes it easier to test for equality of a commit in the TODO =
list
and one of SHORTUPSTREAM, SHORTHEAD or SHORTONTO.=E2=80=9D

> and 7 is a good number.

I don't know why 7 is a good number. It was there from the beginning:

% git show 1b1dce4b:git-rebase--interactive.sh G -C1 \=3D7
                git rev-list --no-merges --pretty=3Doneline --abbrev-commit=
 \
                        --abbrev=3D7 --reverse $UPSTREAM..$HEAD | \
                        sed "s/^/pick /" >> "$TODO"

Bye, J=C3=B6rg.
--=20
Damit das M=C3=B6gliche entsteht, mu=C3=9F immer wieder das Unm=C3=B6gliche=
 versucht
werden.                                       (Hermann Hesse)

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAH1Jwe0mZwH1VIARAsQbAJ9P5pmR8RW/k5S/FjDrB/F9aVXO5gCgsYdN
s4iF9tbbZgMh1s0UglK8Qyo=
=3ENT
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
