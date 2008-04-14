From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Mon, 14 Apr 2008 12:06:33 +0200
Message-ID: <20080414100633.GB15098@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <7vskxsneau.fsf@gitster.siamese.dyndns.org> <20080412101110.GD31356@alea.gnuu.de> <20080413035648.GY10274@spearce.org> <20080413165011.GB3179@alea.gnuu.de> <20080414062425.GB20979@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 12:43:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlM9N-0005I8-9J
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 12:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYDNKlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 06:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbYDNKlp
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 06:41:45 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3470 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158AbYDNKll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 06:41:41 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 469204880B4; Mon, 14 Apr 2008 12:41:38 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlLa5-0001DT-Hj; Mon, 14 Apr 2008 12:06:33 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlLa5-00040s-3z; Mon, 14 Apr 2008 12:06:33 +0200
Content-Disposition: inline
In-Reply-To: <20080414062425.GB20979@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79497>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Shawn O. Pearce schrieb am Mon 14. Apr, 02:24 (-0400):
> Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > Shawn O. Pearce schrieb am Sat 12. Apr, 23:56 (-0400):
> > >=20
> > > Why not use the mark syntax that fast-import uses?
> >=20
> > I didn't know it.
> >=20
> > > In fast-import we use ":n" anytime we need to refer to a mark, e.g.
> > > ":1" or ":5".
> >=20
> > Currently, I don't restrict the mark to be a number. It can anything th=
at
> > is a valid ref. Should I restrict it?
>=20
> In fast-import a mark can *only* be a number.

Only for the record: fast-import uses numbers and not strings of
digits, i.e. 001 =3D=3D 1, and it ignores stuff following digits, i.e.
"12a" =3D=3D 12 and "abc" =3D=3D 0.

> > Except of this, I prefer to use the colon to be much closer to the synt=
ax
> > of fast-import.
>=20
> Me too, but it looks like in a human edited "TODO" script we may want
> to be more friendly and allow named marks.

I don't think so. There shouldn't be so much marks that a user can't
remember them.

Thanks for your comments.

J=F6rg.
--=20
The UNIX Guru's View of Sex:
# unzip ; strip ; touch ; finger ; mount ; fsck ; more ; yes ; umount ; sle=
ep

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAyypwe0mZwH1VIARAlSKAKDCORlzNNYI+rmPkJizKomQqGXlWQCffbm1
hDEOf8A7GIQqeCqmC2pun3o=
=1emj
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
