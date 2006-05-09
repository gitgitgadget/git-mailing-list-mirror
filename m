From: Martin Waitz <tali@admingilde.org>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 13:26:41 +0200
Message-ID: <20060509112641.GB3228@admingilde.org>
References: <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE> <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de> <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org> <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org> <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org> <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 13:26:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdQMa-0003iP-M4
	for gcvg-git@gmane.org; Tue, 09 May 2006 13:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWEIL0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 07:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEIL0p
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 07:26:45 -0400
Received: from admingilde.org ([213.95.32.146]:40682 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932282AbWEIL0o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 07:26:44 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FdQMT-0003Oa-EQ; Tue, 09 May 2006 13:26:41 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19832>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 08, 2006 at 08:08:41PM -0700, Linus Torvalds wrote:
> > What's the advantage of section quotation marks over just allowing these
> > characters in regular section names?  To be specific, what is wrong wit=
h:
> >=20
> >    [jc/show-branch-dense]
>=20
> This would _suck_
>=20
> What if you have a branch called "core"? Not all all unlikely.=20
>=20
> Think about what a section like
>=20
> 	[core]
>=20
> really means.
>=20
> Plus I really want to not be case sensitive by default. Case sensitivity=
=20
> really is _not_ normal for this kind of config file syntax.

So why is everybody trying to munch all branch related data into
one .ini style config file?

why not simply use the mechanisms we use elsewhere and build something
like our remotes or the new HEAD file?

--=20
Martin Waitz

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEYHxxj/Eaxd/oD7IRAr1JAJ0T6R+u84JKowbBpYWzDlYk1GnrrgCfW+B8
HAzi+9H8oJ3kcU6vOYbAyYI=
=iOVi
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
