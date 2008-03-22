From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
	commits
Date: Sat, 22 Mar 2008 15:06:48 +0100
Message-ID: <20080322140648.GA3189@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de> <20080322015252.GA7570@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 15:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd4Qj-0004oD-Ex
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 15:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbYCVOJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 10:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbYCVOJs
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 10:09:48 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1550 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbYCVOJr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 10:09:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 22D89488030; Sat, 22 Mar 2008 15:09:44 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4Mw-0002Li-BR; Sat, 22 Mar 2008 15:06:46 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd4My-0000rl-1i; Sat, 22 Mar 2008 15:06:48 +0100
Content-Disposition: inline
In-Reply-To: <20080322015252.GA7570@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77807>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Bj=C3=B6rn,

Bj=C3=B6rn Steinbrink schrieb am Sat 22. Mar, 02:52 (+0100):
> On 2008.03.22 02:19:42 +0100, J=C3=B6rg Sommer wrote:
> > The current version of git-rebase--interactive shows the user the commi=
ts
> > coming from a merge.
> >=20
> > M---A---B
> >  \       \
> >   o---o---+---o branch
> >=20
> > Rebasing branch on M with preserve merges gives the commits A and B. But
> > if you mark them for editing or remove them the rebase fails. You must
> > keep them as they are. It's useless to bother the user with these commi=
ts
> > and might lead to mistakes.
>=20
> Uhm, why do you completely remove the possibility to edit A

Ahh, now I see what you've tried to say. I did add the option
--first-parent for rebase interactive *without* preserve merges, too.
I'll update my patch.

Bye, J=C3=B6rg.
--=20
=E2=80=9CScience is the game we play with God to find out what his rules ar=
e.=E2=80=9D

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH5RJ3we0mZwH1VIARAnpPAKC4M7F4KZoXqLLUHsyEJdEvAbyHFACdGCh/
oWrB/6NlR8EZ/hG7IcEmzIw=
=YF+S
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
