From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to
	chmod.
Date: Wed, 10 Oct 2007 11:47:04 +0200
Message-ID: <20071010094704.GA7865@efreet.light.src>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net> <20071003231941.GA20800@admingilde.org> <Pine.LNX.4.64.0710040053380.28395@racer.site> <470482A2.3080907@op5.se> <7vr6kbbdph.fsf@gitster.siamese.dyndns.org> <20071004071751.GD20800@admingilde.org> <7vir5nb89d.fsf@gitster.siamese.dyndns.org> <20071004084237.GE20800@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 11:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfYA4-0006yA-8G
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 11:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbXJJJrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 05:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbXJJJrR
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 05:47:17 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:53843 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754533AbXJJJrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 05:47:15 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 828F857368;
	Wed, 10 Oct 2007 11:47:13 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id VeMTVgxBVvYm; Wed, 10 Oct 2007 11:47:10 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id BDCD9572BC;
	Wed, 10 Oct 2007 11:47:09 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IfY9g-00033Y-7Z; Wed, 10 Oct 2007 11:47:04 +0200
Content-Disposition: inline
In-Reply-To: <20071004084237.GE20800@admingilde.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60488>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2007 at 10:42:37 +0200, Martin Waitz wrote:
> hoi :)
>=20
> On Thu, Oct 04, 2007 at 01:21:02AM -0700, Junio C Hamano wrote:
> > FWIW, I did not mean it to be an example for preferred
> > indentation nor code layout, but as a better way to explain what
> > the logic is computing.
>=20
> sure, and I think it makes sense the way you wrote it.
>=20
> > I do not think git on Cygwin nor WinGit creates $GIT_DIR/config
> > with executable bit set.  Is this pretty much a workaround only
> > for vfat-on-Linux ?
>=20
> I just checked Cygwin, it creates files without executable bit and
> disregards a chmod +x.  So yes, this seems to be a Linux-only problem.

AFAIR in cygwin it depends on both configuration of cygwin and whether you
are on NTFS or FAT. On NTFS with proper setting (CYGWIN=3Dntsec IIRC), cygw=
in
actually implements the x bit (uses the NT ACL to somewhat represent it). On
other filesystem there is an option somewhere to tell whether it should show
the x bit always set or always cleared (for me it seems to be always set).

On the other hand MSYS shows the x bit as set whenever the file has
executable extension. I don't think cygwin has this mode.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDJ+YRel1vVwhjGURAvqbAJ4tk6ZI7mk2ZR876aX1MAaZl8nvCwCg4PBX
0Ibs0lImsG8Xu+ZGpCZzltI=
=rCOh
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
