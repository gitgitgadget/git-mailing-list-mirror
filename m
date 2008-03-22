From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
	commits
Date: Sat, 22 Mar 2008 10:40:51 +0100
Message-ID: <20080322094051.GA30074@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de> <20080322015252.GA7570@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 10:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd0Kl-000105-Ok
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 10:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbYCVJrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 05:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbYCVJrV
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 05:47:21 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1228 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbYCVJrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 05:47:20 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 47172488030; Sat, 22 Mar 2008 10:47:19 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd0DQ-0002C6-WF; Sat, 22 Mar 2008 10:40:41 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd0Db-0007pJ-1N; Sat, 22 Mar 2008 10:40:51 +0100
Content-Disposition: inline
In-Reply-To: <20080322015252.GA7570@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77796>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Bj=F6rn,

Bj=F6rn Steinbrink schrieb am Sat 22. Mar, 02:52 (+0100):
> On 2008.03.22 02:19:42 +0100, J=F6rg Sommer wrote:
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
> Uhm, why do you completely remove the possibility to edit A instead of
> fixing the code so that the editing actually works?

Because I didn't see why it's useful to edit A and create A' and merge in
A again, later.

M---A---B
 \       \
  C---D---+---o branch

M---A--------------B
 \                  \
  C---B'---D'---A'---+---o branch

Bye, J=F6rg.
--=20
Viele Leute glauben, dass sie denken, wenn sie lediglich
ihre Vorurteile neu ordnen.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH5NQiwe0mZwH1VIARAt9QAJoCZmTU2UL4mE8UiwQXdw7z9IYotwCfZE4C
8DSz+p6MHM1Fmj3a/Kw14uE=
=FzYi
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
