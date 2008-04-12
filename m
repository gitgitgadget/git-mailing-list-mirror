From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Sat, 12 Apr 2008 12:17:32 +0200
Message-ID: <20080412101732.GE31356@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <e2b179460804100233v7b8a2feare353cb4e5f718e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 12:21:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkcrH-0003Fp-5l
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 12:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758516AbYDLKUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 06:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbYDLKUe
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 06:20:34 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4691 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757205AbYDLKUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 06:20:15 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id D6DC5488063; Sat, 12 Apr 2008 12:20:12 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jkcnc-0000nC-T0; Sat, 12 Apr 2008 12:17:33 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jkcnc-0008PR-JR; Sat, 12 Apr 2008 12:17:32 +0200
Content-Disposition: inline
In-Reply-To: <e2b179460804100233v7b8a2feare353cb4e5f718e7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79344>


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Mike,

Mike Ralphson schrieb am Thu 10. Apr, 10:33 (+0100):
> On 10/04/2008, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> > This new command can be used to set symbolic marks for an commit while
> >  doing a rebase. This symbolic name can later be used for merges or
> >  resets.
>=20
> What would be wrong with using the existing tag machinery for this instea=
d?

You may have to deal with conflicts if users named tags 03 or 10. But
Junio suggested to use a ref, too. I think refs/rebase-marks/ is a good
prefix.

Bye, J=F6rg.
--=20
Der Hase l=E4uft schneller als der Fuchs,
denn der Hase l=E4uft um sein Leben.

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAIw8we0mZwH1VIARAixcAJ9iYym9dKIKPl3xiZ9xuOEma8XTZgCfV0A2
tjL9yyy48qgr2s9alorwKZ4=
=9JcO
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
