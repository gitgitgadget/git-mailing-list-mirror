From: Jan Hudec <bulb@ucw.cz>
Subject: Re: remote#branch
Date: Sat, 27 Oct 2007 22:47:57 +0200
Message-ID: <20071027204757.GA3058@efreet.light.src>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz> <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src> <Pine.LNX.4.64.0710162228560.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Cc: Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 22:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlsaK-0001N2-47
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 22:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974AbXJ0UsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbXJ0UsN
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 16:48:13 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:55932 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbXJ0UsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 16:48:11 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8E04D57409;
	Sat, 27 Oct 2007 22:48:09 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id pD7SNJf89qB9; Sat, 27 Oct 2007 22:48:05 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3DC4B572F6;
	Sat, 27 Oct 2007 22:48:05 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IlsZZ-0001Es-Mw; Sat, 27 Oct 2007 22:47:57 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710162228560.25221@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62510>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 22:35:25 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 16 Oct 2007, Jan Hudec wrote:
>=20
> > If it is a fragment, than "#" is the only correct separator and should=
=20
> > stay that way.
>=20
> You did not listen, did you?  '#' is allowed in ref names.  Therefore thi=
s=20
> character really would lock us in to only ever reference _one_ and _only_=
=20
> one remote branch at a time.  This might have worked for cogito, but it=
=20
> does not for git.
>=20
> So, I say it again, '#' is _out_.

That does not imply it can't separate the ref from the repository...

> > If it is not a true fragment, than we might want to phase it out in=20
> > favor of something else. But I would strongly prefer staying within=20
> > characters allowed in URI (as per rfc2396).
>=20
> If you do that, "http://<xyz-with-branch>" would be ambiguous, wouldn't=
=20
> it?  This would already reference an HTTP resource, and you could not=20
> embed refnames into the URL.

=2E.. and because of this actually has to. You are right.

> > As for multiple branches, separating them with "," feels logical to me,=
=20
> > no matter what separates them from the repository path. On the other=20
> > hand given that neither ":" nor "@" is allowed in refnames, reusing the=
=20
> > same separator would make sense especially if git switched to either of=
=20
> > those.
>=20
> ',' is allowed in ref names, so ',' is out.

Actually since many characters that are allowed in ref name are not allowed
in URL at all, the ref-name has to be url-escaped. Which brings all
characters back in, because they can always be specified escaped.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHI6P9Rel1vVwhjGURAjylAJ9jJdE4F15QhkmOufvk8vMpGtcThQCg6YP3
Ngv0l1w83g75aDYtsZmKpDQ=
=0fgb
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
