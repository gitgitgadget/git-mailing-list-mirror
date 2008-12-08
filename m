From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Re: git-svn not working when parent of cloned dir requires auth
Date: Mon, 8 Dec 2008 17:07:50 -0500
Message-ID: <20081208220749.GB16418@cetel-004-xx6.admin.gatech.edu>
References: <20081208205418.GA16418@cetel-004-xx6.admin.gatech.edu> <7v4p1e73tt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:09:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9oHv-0000bB-Ui
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 23:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbYLHWH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbYLHWH4
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 17:07:56 -0500
Received: from deliverator4.ecc.gatech.edu ([130.207.185.174]:36462 "EHLO
	deliverator4.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752680AbYLHWHz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2008 17:07:55 -0500
Received: from deliverator4.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 675BB5E4139;
	Mon,  8 Dec 2008 17:07:54 -0500 (EST)
Received: from mailprx2.gatech.edu (mailprx2.prism.gatech.edu [130.207.171.21])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator4.ecc.gatech.edu (Postfix) with ESMTP id F3DE45E4064;
	Mon,  8 Dec 2008 17:07:51 -0500 (EST)
Received: from mothra.cetl.gatech.edu (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx2.gatech.edu, sender=stuart@cetel-004-xx6.admin.gatech.edu)
	by mailprx2.gatech.edu (Postfix) with ESMTP
	id B686A1F00; Mon,  8 Dec 2008 17:07:49 -0500 (EST)
	(envelope-from stuart@cetel-004-xx6.admin.gatech.edu)
Received: from stuart by mothra.cetl.gatech.edu with local (Exim 4.69)
	(envelope-from <stuart@cetel-004-xx6.admin.gatech.edu>)
	id 1L9oGc-0006RL-13; Mon, 08 Dec 2008 17:07:50 -0500
Content-Disposition: inline
In-Reply-To: <7v4p1e73tt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102588>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In looking at the source of git-svn, I see:

' # there are currently some bugs that prevent multi-init/multi-fetch
  # setups from working well without this.
  $Git::SVN::_minimize_url =3D 1;'

I tried setting it to '0' and rerunning my clone.  It no longer prompted
for a password, but it still failed to clone anything.=20

On Mon, Dec 08, 2008 at 01:30:06PM -0800, Junio C Hamano wrote:
> "D. Stuart Freeman" <stuart.freeman@et.gatech.edu> writes:
>=20
> > I'm trying to
> > 'git svn clone https://mware.ucdavis.edu/svn/ucd-sakai/gradebook-gwt -s'
> > that repo is setup to allow anonymous reading of that directory tree, b=
ut
> > git-svn prompts me for a password.  I think git-svn is traversing up the
> > directory tree and encountering a directory that needs authn, can I pre=
vent
> > it from doing that?
>=20
> That sounds suspiciously similar to what I observed long time ago:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/46361/focus=3D46=
558
>=20
> And $gmane/47151 in the thread, aka dc43166 (git-svn: don't minimize-url
> when doing an init that tracks multiple paths, 2007-05-19), supposed to
> have fixed it.
>=20
> Hmm...  Eric?

--=20
D. Stuart Freeman
Georgia Institute of Technology

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk9mrUACgkQ74jXllI0CXTPfQCdH8cmakbVsUc409dgj+AY+9KJ
KvoAn2BOIAl9NBEZJEu0RkHLsTcLjqtC
=sjZt
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
