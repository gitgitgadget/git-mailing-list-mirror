From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Error when pushing
Date: Wed, 7 May 2008 17:39:27 +0200
Message-ID: <20080507153927.GL1472@lug-owl.de>
References: <4B58A837F454E14AA0453EDBADE96A62B5F606@mildred.leeds-art.ac.uk> <20080507150440.GK1472@lug-owl.de> <4B58A837F454E14AA0453EDBADE96A62B5F621@mildred.leeds-art.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxavXfDenm+F7xE/"
Cc: git@vger.kernel.org
To: Ryan Taylor <ryan.taylor@leeds-art.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 07 17:40:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtlkq-00020k-1i
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 17:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763342AbYEGPji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 11:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762477AbYEGPjh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 11:39:37 -0400
Received: from lug-owl.de ([195.71.106.12]:44956 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763342AbYEGPj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 11:39:29 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 237C5F005C; Wed,  7 May 2008 17:39:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4B58A837F454E14AA0453EDBADE96A62B5F621@mildred.leeds-art.ac.uk>
X-Operating-System: Linux mail 2.6.18-5-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81451>


--FxavXfDenm+F7xE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-05-07 16:26:34 +0100, Ryan Taylor <ryan.taylor@leeds-art.ac.uk=
> wrote:
> On Behalf Of Jan-Benedict Glaw:
> > On Wed, 2008-05-07 16:02:46 +0100, Ryan Taylor <ryan.taylor@leeds-art.a=
c.uk> wrote:
> > > I'm getting the following error when pushing from my dev box to my li=
ve box:
> > >=20
> > > ryant@brewster:/gittest$ git push ryan@bert:/webdata/gittest/=20
> > > ryan@bert's password:
> > > updating 'refs/heads/master'
> > > =C2=A0 from 60d4194d6d5647f1c18fb7235754984bd4e5a8d9
> > > =C2=A0 to=C2=A0=C2=A0 97c26890703c1f08e02623e4e84a40e4ca0e0a1e
> > > Generating pack...
> > > Done counting 4 objects.
> > > Result has 3 objects.
> > > Deltifying 3 objects...
> > > =C2=A0100% (3/3) done
> > > Writing 3 objects...
> > > =C2=A0100% (3/3) done
> > > Total 3 (delta 0), reused 0 (delta 0)
> > > Unpacking 3 objects
> > > *** Project description file hasn't been set
> > > error: hooks/update exited with error code 1
> > > error: hook declined to update refs/heads/master ng refs/heads/master=
=20
> > > hook declined
> > > error: failed to push to 'ryan@bert:/webdata/gittest/'
> > >=20
> > > Can anybody shed any light?
> >=20
> > Did you actually *read* the error messages?
>=20
> Yes. But I'm new to git and don't understand what it means.

A `hook' is running. Hooks are (usually) little scripts to do some
additional automated tasks that aren't the main business of the SCM
system itself. In your case, the hook `hooks/update' was started and
it aborted (returning an error condition). Just look at that script
(it's on the server within the GIT repo you're pushing to) to see what
it does.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                           Wenn ich wach bin, tr=C3=A4ume ic=
h.
  the second  :

--FxavXfDenm+F7xE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIIc0uHb1edYOZ4bsRAigKAJ9hpxlm14MZNaypICC0LvOIIrgj5QCfSDCP
t6YqNuQaMX0kTNLjbPPiw4Q=
=/eZh
-----END PGP SIGNATURE-----

--FxavXfDenm+F7xE/--
