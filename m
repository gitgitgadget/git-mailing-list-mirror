From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Sun, 13 Apr 2008 18:50:11 +0200
Message-ID: <20080413165011.GB3179@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <7vskxsneau.fsf@gitster.siamese.dyndns.org> <20080412101110.GD31356@alea.gnuu.de> <20080413035648.GY10274@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 02:06:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCCL-0003fZ-Lu
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbYDNAE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYDNAE2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:04:28 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1405 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084AbYDNAE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:04:27 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id E133248809D; Mon, 14 Apr 2008 02:04:24 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCA1-0005nn-A4; Mon, 14 Apr 2008 02:03:05 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jl5P9-0001Mb-7F; Sun, 13 Apr 2008 18:50:11 +0200
Content-Disposition: inline
In-Reply-To: <20080413035648.GY10274@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79429>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Shawn O. Pearce schrieb am Sat 12. Apr, 23:56 (-0400):
> Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > > Wouldn't
> > >=20
> > > 	pick 5cc8f37 (init: show "Reinit" message even in ...)
> > > 	mark 1
> > > 	pick 18d077c (quiltimport: fix misquoting of parse...)
> > > 	mark 2
> > > 	reset 1
> >=20
> > =E2=80=9Creset 18d077c~2=E2=80=9D or =E2=80=9Creset some-tag=E2=80=9D o=
r =E2=80=9Creset my-branch~12=E2=80=9D
> >=20
> > >         merge #2
> > >=20
> > > be easier for people?
> >=20
> > I don't know. Using the special sign everywhere a mark is used looks mo=
re
> > consistent to me. The only case where it might be omitted is the mark
> > command, because it only uses marks.
>=20
> Why not use the mark syntax that fast-import uses?

I didn't know it.

> In fast-import we use ":n" anytime we need to refer to a mark, e.g.
> ":1" or ":5".

Currently, I don't restrict the mark to be a number. It can anything that
is a valid ref. Should I restrict it?

And how do you handle the :/ syntax? =E2=80=9Creset :/Bla=E2=80=9D is than =
not valid.
Mmm, I'll add an exception for :/.

Except of this, I prefer to use the colon to be much closer to the syntax
of fast-import.

Bye, J=C3=B6rg.
--=20
Der Wunsch, klug zu erscheinen, verhindert oft, es zu werden.
    	    	    			      (Francois de la Rochefoucauld)

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAjnDwe0mZwH1VIARAv+yAJsG3RBePUSYSuCyX+J5QrH6spRyvQCePQ09
CYyTzCwIefbMPp56sGQLuHA=
=dPWu
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
