From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] gitk: Update German translation
Date: Thu, 15 May 2008 18:20:52 +0200
Message-ID: <20080515162052.GC12350@leksak.fem-net>
References: <200805012142.10151.stimming@tuhh.de> <200805022123.22333.stimming@tuhh.de> <20080503012419.327120@gmx.net> <200805072256.50520.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Thu May 15 18:24:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwgDN-0002sZ-Md
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 18:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804AbYEOQVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 12:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756707AbYEOQVI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 12:21:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:44878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756704AbYEOQVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 12:21:00 -0400
Received: (qmail invoked by alias); 15 May 2008 16:20:57 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp011) with SMTP; 15 May 2008 18:20:57 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/OCvwjnDLOEl+gqIo9mIcbQHNX49+Xx46MbgNaC/
	LOPq4Eye8f8auq
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1JwgCK-0007DQ-Ea; Thu, 15 May 2008 18:20:52 +0200
Mail-Followup-To: Christian Stimming <stimming@tuhh.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200805072256.50520.stimming@tuhh.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82209>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christian,

> > The original
> >  "Find next/prev commit _containing:_ [insert]"
> > should be translated to
> >  "Suche n=E4chste/vorige Version, die [insert] enth=E4lt."
> > But this is beyond the used techniques for software translation ;-)
>=20
> Yes. But maybe even without GUI modifications this can be translated in a=
=20
> better way. Eventually, I would expect something like this:
>=20
>   Suchen: N=E4chste / vorige Fundstelle mit Kriterium 'Enth=E4lt Zeichenk=
ette':  [insert]

This can be a choice, but it's very long. ;-)

I want to repeat my suggestions from the last mail:
  1. "Suche n=E4chste/vorige Version nach _Beschreibung:_ [insert]"
  2. "Suche n=E4chste/vorige Version nach _Pfaden:_ [insert]"
     (or maybe "nach _Dateien:_", if it's commonly accepted that=20
      directories are files, too.)
  3. "Suche n=E4chste/vorige Version nach _=C4nderungen:_ [insert]"
which makes it much more clearer than the English original, imho.

> IMHO this shouldn't be one single sentence which is what the current engl=
ish=20
> GUI tries to mimic. Instead, this should be something with a heading and =
a=20
> choicebox for the criteria and appropriate labels for those.

Yes, if one single sentence does not work in another language, why keep
it?  But, one single sentence works here ;-)

> > Btw, 'man git-cherry-pick' says
> >         "Apply the change introduced by an existing commit".
> > So why not take this and use
> >  "Durch diese Version eingef=FChrte =C4nderungen =FCbernehmen" or
> >  "Durch diese Version eingef=FChrte =C4nderungen anwenden"?
>=20
> This is indeed a case where a better translation can still be found. Howe=
ver,=20
> all of "kopieren, =FCbernehmen, anwenden" IMHO sound too similar to actio=
ns=20
> that already appear here or there in the version control GUI.

You are right with "kopieren" and "anwenden", but where is "=FCbernehmen"?

Ok, it is used in the glossary for "pull", but nowhere in code that is
actually used.  And I think a better translation for "pull" is
something that stresses the fact that "pull" =3D "fetch" + "merge",
something like "Holen und Zusammenf=FChren".

> Cherry-picking is a specialized action and should thus get a specialized=
=20
> German word.=20

I'm still unsure about this.  But it's your choice. ;-)

Kind regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILGLkbt3SB/zFBA8RAkZSAKCLuOLvA5m/f/Mks3eixcq/G5HL0QCfVxj2
lYonaoKY7RbJmNqech7+XGQ=
=aynd
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
