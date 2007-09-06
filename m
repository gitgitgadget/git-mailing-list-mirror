From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 1/3] git-gui/Makefile: Replace libdir with gitgui_libdir
Date: Thu, 6 Sep 2007 14:00:12 +0400
Message-ID: <20070906100012.GC6665@basalt.office.altlinux.org>
References: <20070905232153.GA331@nomad.office.altlinux.org> <20070906023227.GH18160@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:00:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITEA2-0003pI-2B
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 12:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420AbXIFKAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 06:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756759AbXIFKAQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 06:00:16 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:37724 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757210AbXIFKAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 06:00:14 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id E82391B5801C;
	Thu,  6 Sep 2007 14:00:12 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id D4BE6B0D92; Thu,  6 Sep 2007 14:00:12 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20070906023227.GH18160@spearce.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57854>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 10:32:27PM -0400, Shawn O. Pearce wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> > On GNU/Linux, libdir is used to mean "/usr/lib or /usr/lib64"
> > depending on architecture.  Different libdir meaning breaks
> > idiomatic expressions like rpm specfile "make libdir=3D%_libdir".
> >=20
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  git-gui/Makefile |   16 ++++++++--------
> >  1 files changed, 8 insertions(+), 8 deletions(-)
>=20
> Although I could apply this with `am -3` I'm NACK'ing this right
> now because...
[...]
> git-gui is its own project with its own Makefile.  Junio includes
> it in git.git to help widen its audience, and because it is quite
> portable and easy for him to include.   In the future git-gui will
> become a proper subproject of git.git.

The idea is that git-gui's libdir is not a traditional arch-dependent
libdir's subdirectory, but rather arch-independent datadir's subdirectory.
That is, I see no reason to call it libdir even in standalone project.

> If you want to define libdir in git's toplevel Makefile *and*
> that definition is being exported down into git-gui's Makefile

Yes, that was my first motivation, but the issue appears to be a bit more
complex.


--=20
ldv

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG38+sfKvmrJ41Nh4RAkzOAJ4uXn/y4PGWJLkeaWFZstMiFEhhoQCfYu3g
qCooF/QSgbdngDJoBVfzN2M=
=eDpj
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
