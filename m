From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH v2 02/13] Don't append default merge message to -m
	message
Date: Mon, 21 Apr 2008 02:17:26 +0200
Message-ID: <20080421001726.GA13639@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <7v7iescvu7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 10:04:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnr0j-00026W-V8
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 10:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYDUIDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 04:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbYDUIDf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 04:03:35 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4358 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282AbYDUID2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 04:03:28 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id E782A4880A6; Mon, 21 Apr 2008 10:03:21 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jnjip-00077U-A3; Mon, 21 Apr 2008 02:17:27 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jnjio-0003Yf-P9; Mon, 21 Apr 2008 02:17:26 +0200
Content-Disposition: inline
In-Reply-To: <7v7iescvu7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80013>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Junio,

Junio C Hamano schrieb am Sun 20. Apr, 09:52 (-0700):
> J=F6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> > From: gitster@pobox.com (Junio C Hamano)
> > Date: Sun, 23 Mar 2008 22:17:09 -0700
> >
> > Signed-off-by: J=F6rg Sommer <joerg@alea.gnuu.de>
>=20
> I'd admit that this was taken from my "You could do this" patch, and I am
> inclined to think that the users would probably want this behaviour of
> dropping the default merge summary when giving their own message with -m,
> but I am not absolutely convinced that doing this unconditionally is the
> right thing to do (iow, some people might have relied on the current
> behaviour).
>=20
> List, any objections?

What about a new option -M? But I doubt someone expects this behaviour
because the manpage says:

  The second syntax (<msg> HEAD <remote>) is supported for historical
  reasons. Do not use it from the command line or in new scripts. It is
  the same as git merge -m <msg> <remote>.
      ^^^^              ^^

Currently, it's not the same, but someone might expect it.

Bye, J=F6rg.
--=20
Die Erde ist das einzigste Irrenhaus, das von seinen eigenen Insassen
verwaltet wird.
                                                (U. Schmidt)

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIC90Wwe0mZwH1VIARAh95AKCEOa4wSgDsSFH240KewkUFRElICwCfWiT0
XbJKGaLiI398YGRMIdIa6M8=
=nu0D
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
