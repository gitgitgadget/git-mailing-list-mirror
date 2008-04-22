From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: mark parsing in fast-import
Date: Tue, 22 Apr 2008 11:39:42 +0200
Message-ID: <20080422093942.GA3752@alea.gnuu.de>
References: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208169584-15931-1-git-send-email-joerg@alea.gnuu.de> <20080414232958.GE20979@spearce.org> <20080420234438.GC12865@alea.gnuu.de> <20080421002626.GJ29771@spearce.org> <20080421084151.GA31344@alea.gnuu.de> <20080421235940.GQ29771@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:03:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFL1-0004lF-Bk
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758888AbYDVKCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758868AbYDVKCM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:02:12 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2403 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758290AbYDVKCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:02:11 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id ACD82488024; Tue, 22 Apr 2008 12:02:07 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JoEyV-0007mv-6s; Tue, 22 Apr 2008 11:39:43 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JoEyU-000104-V6; Tue, 22 Apr 2008 11:39:42 +0200
Content-Disposition: inline
In-Reply-To: <20080421235940.GQ29771@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80091>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Shawn,

Shawn O. Pearce schrieb am Mon 21. Apr, 19:59 (-0400):
> Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > Yes, you're right. I've checked some other functions and found this
> > behaviour. Can I use a different behabiour, i.e. return 0 on failure and
> > !0 on success?
>=20
> I wasn't objected to the return values as written, but more to the
> fact that it seemed like a logic error to me.  We use both patterns
> in Git.  Perhaps the best example to follow is get_sha1_hex();
> it returns -1 on error and 0 on success.  So a common pattern is
> "!get_sha1_hex()" to ensure a successful conversion of a hex string
> to an unsigned char array.

Thanks for this explanation. This was what I was looking for.

Another question: Is :0 a valid mark? In import_marks() is a check for
!mark, but I haven't seen it anywhere else.

Bye, J=C3=B6rg.
--=20
Du hast keine Chance =E2=80=93 also nutze sie.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDbJewe0mZwH1VIARAjPmAKCLYwpqC0IfRFmBK+BWsXNuDztQjQCfZFUu
+OWdbHW2bPyEi51pQQuHIck=
=MFnZ
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
