From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Large-scale configuration backup with GIT?
Date: Sun, 2 Sep 2007 23:24:31 +0200
Message-ID: <20070902212431.GC10567@lug-owl.de>
References: <20070902201724.GB10567@lug-owl.de> <85642spzvs.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 23:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRwvw-0001Hl-GE
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 23:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXIBVYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 17:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbXIBVYd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 17:24:33 -0400
Received: from lug-owl.de ([195.71.106.12]:39055 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbXIBVYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 17:24:32 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id BABA8F0078; Sun,  2 Sep 2007 23:24:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85642spzvs.fsf@lola.goethe.zz>
X-Operating-System: Linux mail 2.6.18-5-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57388>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-09-02 22:37:43 +0200, David Kastrup <dak@gnu.org> wrote:
> Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:
>=20
> > I'm just thinking about storing our whole company's configuration into
> > GIT, because I'm all too used to it. That is, there are configuration
> > dumps of n*10000 routers and switches, as well as "regular"
> > configuration files on server machines (mostly Linux and Solaris.)
> > While probably all of the server machines could run GIT natively, we
> > already have some scripts to dump all router's/switch's configuration
> > to a Solaris system, so we could it import/commit from there. There
> > might be a small number of Windows machines, but I guess these will be
> > done by exporting the interesting stuff to Linux/Solaris machines...
> >
> > I initially thought about running a git-init-db on each machine's root
> > directory and adding all interesting files, but that might hurt GIT's
> > usage for single software projects on those machines, no?
>=20
> It could break shell scripts, since
> cd /;echo `pwd`/filename
> does not return /filename.

Well, I don't think that this is much of a problem.

> I don't think that the root directory is a good place for starting
> git.

Maybe :)  But this is why I brought up the discussion, to get other
people's oppinion on this topic.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                http://catb.org/~esr/faqs/smart-questions.html
the second  :

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG2yoPHb1edYOZ4bsRAtkPAJ4nsr53IPSGH8yRq8flOJkw7j/dsQCeI/Gw
HGsK8NdefYHJYrwshdvZab8=
=NPoR
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
