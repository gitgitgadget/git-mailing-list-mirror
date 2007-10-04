From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to chmod.
Date: Thu, 4 Oct 2007 09:15:17 +0200
Message-ID: <20071004071517.GC20800@admingilde.org>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net> <20071003231941.GA20800@admingilde.org> <Pine.LNX.4.64.0710040053380.28395@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 09:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdKve-00066Z-Va
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 09:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbXJDHPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 03:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbXJDHPT
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 03:15:19 -0400
Received: from mail.admingilde.org ([213.95.32.147]:45614 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbXJDHPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 03:15:18 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.63 #1)
	id 1IdKvV-0000fu-E6; Thu, 04 Oct 2007 09:15:17 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710040053380.28395@racer.site>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59924>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Oct 04, 2007 at 12:54:06AM +0100, Johannes Schindelin wrote:
> > -		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> > +		/* test that new files are not created with X bit */
> > +		filemode =3D !(st1.st_mode & S_IXUSR);
> > +		/* test that we can modify the X bit */
> > +		filemode &=3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>=20
> Should that not be &&=3D?

originally I wrote it that way but the compiler complaint.
I guess we are too used to perl ;-)

--=20
Martin Waitz

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHBJMFj/Eaxd/oD7IRAnSPAJ44Ehb51OVCpiJLzLzKIc/azCFBjwCcDgU/
6jgHVf7B1oehd7ievPzSoTs=
=4k5d
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
