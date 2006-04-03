From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 07:37:27 -0700
Message-ID: <1144075047.2303.97.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <20060403140348.GE16823@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hSCX9LOyvlGeP4B3VBA3"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 16:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQBn-0007vx-Iy
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWDCOhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWDCOhx
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:37:53 -0400
Received: from home.keithp.com ([63.227.221.253]:64529 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751547AbWDCOhw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:37:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 41C9113001F;
	Mon,  3 Apr 2006 07:37:51 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29478-03-2; Mon, 3 Apr 2006 07:37:51 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id EC4A213001E; Mon,  3 Apr 2006 07:37:50 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id E94AA14002;
	Mon,  3 Apr 2006 07:37:50 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 0CD0E54386; Mon,  3 Apr 2006 07:37:28 -0700 (PDT)
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060403140348.GE16823@harddisk-recovery.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18334>


--=-hSCX9LOyvlGeP4B3VBA3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-04-03 at 16:03 +0200, Erik Mouw wrote:
> On Sat, Apr 01, 2006 at 09:36:28PM -0800, Keith Packard wrote:
> > The UI is a total disaster, sufficient for testing. You must create an
> > Authors file in the current directory which looks like the git-cvsimpor=
t
> > authors file. You must also have a edit-change-log program in your path
> > which edits the commit message in place. /bin/true will work if you
> > don't need to edit the messages.
> >=20
> > I should clearly steal the existing git-cvsimport command line argument=
s
> > and use those.
>=20
> What is the current way to use it? I get the impression it reads raw ,v
> files, but how do I get along with a remote CVS repository?

You can't. You need to create a local copy of the repository. There is a
tool which can do that using the cvs protocol, but I don't recall the
name.

It turns out that parsing the ,v files directly is both faster and more
accurate than attempting to interpret the output of cvs log.

--=20
keith.packard@intel.com

--=-hSCX9LOyvlGeP4B3VBA3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMTMnQp8BWwlsTdMRAqKtAJ0ZBDaFEGiIyPa2FGCFrRMUmA3zlwCeOCo4
b28PZZoL6NNkmAdlEkbspjs=
=+pNR
-----END PGP SIGNATURE-----

--=-hSCX9LOyvlGeP4B3VBA3--
