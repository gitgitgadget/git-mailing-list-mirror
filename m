From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 25 Feb 2008 09:07:39 +0100
Message-ID: <20080225080739.GA13610@piper.oerlikon.madduck.net>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org> <200802071056.19370.robin.rosenberg.lists@dewire.com> <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org> <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org> <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYmj-0000YX-2Q
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYBYId2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbYBYId2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:33:28 -0500
Received: from seamus.madduck.net ([213.203.238.82]:49233 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbYBYId1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:33:27 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2008 03:33:27 EST
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id CADCB4064C3;
	Mon, 25 Feb 2008 09:08:36 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id E86D69F13A;
	Mon, 25 Feb 2008 09:07:39 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 832E34400; Mon, 25 Feb 2008 09:07:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18368.41742.689290.877767@cargo.ozlabs.ibm.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/5980/Mon Feb 25 08:24:21 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75011>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Paul Mackerras <paulus@samba.org> [2008.02.23.2349 +0100]:
> > Saving the geometry can cause several inconveniences, e.g. when
> > using a temporary dual screen setup, or sharing ~/.gitk between
> > multiple systems.  Additionally it can be argued that window
> > placement and sizing are the tasks of the window manager.  So
> > don't do that anymore.
>=20
> I myself find it useful to have gitk remember the size and layout
> of the various panes, so I won't be applying this patch.
>=20
> The saving/restoring of the window position was done by Mark
> Levedahl to make gitk work properly on Cygwin.  I agree it can be
> annoying on X and I would take a patch to inhibit the restoring of
> the window position when running under X.  I'd want an ack from
> Mark before making that change more generally.

May I suggest that such a patch actually disables writing of the
config file, so that we won't get conflicts every time you sync
config files via home-in-git?

Of course I offer to look into this once Mark approves.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"if there's anything more important than my ego,
 i want it caught and shot now."
                                                -- zaphod beeblebrox
=20
spamtraps: madduck.bogus@madduck.net

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHwndLIgvIgzMMSnURAijCAJ9BjtuX+JEQv07qFEmqdRpF7hNhvACglzf3
8rnTzNnN3S82ZoP4zwW0QU4=
=pbe5
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
