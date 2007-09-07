From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 1/3] git-gui/Makefile: Replace libdir with gitgui_libdir
Date: Fri, 7 Sep 2007 16:44:54 +0400
Message-ID: <20070907124454.GD31861@basalt.office.altlinux.org>
References: <20070905232153.GA331@nomad.office.altlinux.org> <20070906023227.GH18160@spearce.org> <20070906100012.GC6665@basalt.office.altlinux.org> <20070907050148.GA18160@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:45:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITdCp-0003Sc-9J
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 14:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbXIGMo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 08:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbXIGMo6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 08:44:58 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:46562 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964861AbXIGMo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 08:44:58 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id 634C11B58105;
	Fri,  7 Sep 2007 16:44:55 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id 868EDB0D92; Fri,  7 Sep 2007 16:44:54 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20070907050148.GA18160@spearce.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58036>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 01:01:48AM -0400, Shawn O. Pearce wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> > > "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> > > > On GNU/Linux, libdir is used to mean "/usr/lib or /usr/lib64"
> > > > depending on architecture.  Different libdir meaning breaks
> > > > idiomatic expressions like rpm specfile "make libdir=3D%_libdir".
> >=20
> > The idea is that git-gui's libdir is not a traditional arch-dependent
> > libdir's subdirectory, but rather arch-independent datadir's subdirecto=
ry.
> > That is, I see no reason to call it libdir even in standalone project.
>=20
> Call it datadir then?  I see you point, and now agree with you.

I'm not sure that "datadir" is better choice than current "libdir".
First, from git-gui point of view, files placed in git-gui/lib/ are
rather library files than data files.
Second, if top-level makefile will define "datadir", original issue will
raise again.
That's why I suggested to add some git-gui specific component to git-gui's
libdir variable name.


--=20
ldv

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG4UfGfKvmrJ41Nh4RAg+dAJ4slZK1vb4bvzYyoirjL3QpqTmyTgCdEfcc
ZB067BYpnRWWO3Wp96ZuXVU=
=mbyV
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
