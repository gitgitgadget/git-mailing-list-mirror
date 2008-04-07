From: Luciano Rocha <luciano@lsd.di.uminho.pt>
Subject: Re: git repo being corrupted?
Date: Mon, 7 Apr 2008 12:39:21 +0100
Message-ID: <20080407113921.GA13667@bit.office.eurotux.com>
References: <47F9F1A1.30009@diamand.org> <20080407111740.GA12776@bit.office.eurotux.com> <47FA03C4.9030104@diamand.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 13:40:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiphy-0006Dw-Uo
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 13:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYDGLjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 07:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754450AbYDGLjf
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 07:39:35 -0400
Received: from linux.di.uminho.pt ([193.136.19.96]:43944 "EHLO
	dcs.lsd.di.uminho.pt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751930AbYDGLje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 07:39:34 -0400
Received: (qmail 32677 invoked by uid 89); 7 Apr 2008 11:38:59 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@lsd.di.uminho.pt@81.84.255.161)
  by dcs.lsd.di.uminho.pt with ESMTPA; 7 Apr 2008 11:38:59 -0000
Content-Disposition: inline
In-Reply-To: <47FA03C4.9030104@diamand.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78970>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2008 at 12:21:40PM +0100, Luke Diamand wrote:
> Luciano Rocha wrote:
>=20
> >> Linux 2.6.22-3-amd64
> >> File system is XFS
> >> git version 1.5.4.4
> >=20
> > You're using XFS. Did you have a power fail in the recent past?
>=20
> How did you know?

XFS doesn't order metadata writes with data writes, so if the power
fails, it can find an update in the journal but the data wasn't written.
Then it fills the file with zeroes to the new size.

I've lost /etc/passwd once with that behaviour...

Also, ext3 doesn't order the metadata and data updates with
data=3Dwriteback, but the default is data=3Dordered, which does.

I use xfs, but only when I know I have at least daily backups (or on
systems with UPS and with UPS initiated orderly shutdowns).

--=20
lfr
0/0

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH+gfpinSul6a7oB8RAlM1AJ47TGll1C8NpPimhVq/zowMKkB1ZgCdHoGv
xBpN5jxlMa7JHdNl0z/LHuU=
=3hix
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
