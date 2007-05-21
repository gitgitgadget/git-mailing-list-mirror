From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Mon, 21 May 2007 22:02:35 +0200
Message-ID: <20070521200235.GE5082@efreet.light.src>
References: <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521180506.GP942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 22:03:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqE6J-0002Ac-PX
	for gcvg-git@gmane.org; Mon, 21 May 2007 22:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbXEUUDD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 16:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761948AbXEUUDD
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 16:03:03 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:3457 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757608AbXEUUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 16:03:00 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.483756;
	Mon, 21 May 2007 22:02:39 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HqE5U-0001i2-DZ; Mon, 21 May 2007 22:02:36 +0200
Content-Disposition: inline
In-Reply-To: <20070521180506.GP942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48046>


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2007 at 20:05:06 +0200, Sven Verdoolaege wrote:
> On Mon, May 21, 2007 at 06:59:38PM +0200, Jan Hudec wrote:
> > We could store the GIT_DIR of submodule within the GIT_DIR of the
> > superproject instead of the submodule directory itself. So instead of:
> >  /
> >  /.git
> >  /subdir
> >  /subdir/.git
> >=20
> > There would be:
> >  /
> >  /.git
> >  /subdir
> >  /.git/submodules/submodule-name.git
>=20
> I have this already, except that I use /.git/submodules/submodule-name/.g=
it
> because I was too lazy to figure out how to get clone to use the above
> without using --bare, because --bare disables separate-remotes.
>=20
> Is there any good reason, btw for --bare not to do separate-remotes ?
> We could throw out a lot of speical cases, especially the --bare http
> fetch if we would simply always do a separate-remotes.

Glad to hear it. I didn't really have time to read through all the patches.

> > This would require changes to the logic how git finds GIT_DIR (which wo=
uld be
> > really deep change),
>=20
> Euhm.... I just add a symlink...

Yes. Except I am not sure mingw supports that.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUfrbRel1vVwhjGURAkHbAJwMh+eMPO2ULY1Li/CdHX7zZ5O/pACff9Vo
QtHzYEOJj2btrqhgQCieA/w=
=Frkh
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
