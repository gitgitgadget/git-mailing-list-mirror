From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] git archive broken in 1.7.8.1
Date: Tue, 10 Jan 2012 23:50:11 +0100
Message-ID: <20120110225011.GJ2714@centaur.lab.cmartin.tk>
References: <5142795.2dTmMhVRTP@xps>
 <20120110213344.GI2714@centaur.lab.cmartin.tk>
 <1431498.0yPWNQLupF@xps>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Cc: git@vger.kernel.org, peff@peff.net
To: Albert Astals Cid <aacid@kde.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 23:50:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkkWC-0000HL-6D
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 23:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab2AJWuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 17:50:06 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:58537 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab2AJWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 17:50:05 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9d122.pool.mediaWays.net [77.185.209.34])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4ED49461C3;
	Tue, 10 Jan 2012 23:49:51 +0100 (CET)
Received: (nullmailer pid 13025 invoked by uid 1000);
	Tue, 10 Jan 2012 22:50:11 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Albert Astals Cid <aacid@kde.org>, git@vger.kernel.org,
	peff@peff.net
Content-Disposition: inline
In-Reply-To: <1431498.0yPWNQLupF@xps>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188300>


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2012 at 11:05:45PM +0100, Albert Astals Cid wrote:
> El Dimarts, 10 de gener de 2012, a les 22:33:44, Carlos Mart=C3=ADn Nieto=
 va=20
> escriure:
> > On Tue, Jan 10, 2012 at 10:18:41PM +0100, Albert Astals Cid wrote:
> > > CC me on answers since i'm not subscribed to the list
> > >=20
> > > Hi, one of our [KDE] anongit servers was updated to 1.7.8.1 and not t=
he
> > > syntax
> > >=20
> > > git archive --remote=3Dgit://anongit.kde.org/repo.git HEAD:path
> >=20
> > This syntax is no longer allowed due to some security tightening. Use
> > the alternate syntax
> >=20
> >     git archive --remote=3Dgit://anongit.kde.org/repo.git HEAD -- path
>=20
> Unfortunately this producess a tarball with a different layout, e.g.
>=20
> git archive --remote=3Dgit://anongit.kde.org/kgraphviewer.git HEAD:doc/en=
_US
>   gives me a tarball with the doc/en_US files in the root
>=20
> git archive --remote=3Dgit://anongit.kde.org/kgraphviewer.git HEAD -- doc=
/en_US
>   gives me a tarball with the doc/en_US folders and then the files
>=20
> Is there a way to keep the old behaviour or do we need to update our scri=
pts?

Not as far as I know. However, the commit that hardened the input
(ee27ca4a781844: archive: don't let remote clients get unreachable
commits, 2011-11-17) does state that HEAD:doc/en_US should be valid,
so it looks like it's actually a regression. As it's bedtime in my
timezone, I'm blaming Peff and I'll look into this if it hasn't been
fixed by the time I get to the office tomorrow.

>=20
> Thanks for the fast answer!
>=20
> Albert
>=20
> >=20
> > > does not seem to return a valid tar archive anymore when it did work
> > > previously. In fact the man page of my version has that syntax in one=
 of
> > > the examples.
> >=20
> > That sounds like a documentation bug.

Notice that the syntax is for the local case, not for --remote.

   cmn

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPDMCjAAoJEHKRP1jG7ZzTXlYIAIxPglMwXfnc+TXH5QmbSQQt
0DIxyT4ccWmuzqc/PY2MAD3666u2JAubLNSuw3KfllskwgnxyvTMrhvyGPcYgKv5
ODMCbOSsD7DsVsKq1AsMyHl8rrYpmtNF3fNrugy3kFJK/+1ZCoeRVgD1ErGs1IY2
vQQUc3RZ8ccpeX39O3Z3VHhYnqZgUFSkUOg8AuXyCThECHuloA4DGBj/mv7BiIpT
1tgQGt12kwaazHJPmDhbsSFs+ZDplBqhNCRzmyjHP/zFlopZQdwNQbULyVDeLrqR
R86xIIduH7UyBQEKmTiwzImMrKtNzyRZJM2yyDCNk4Y2guJIDpy3/0Ss3mAXZTw=
=r3WR
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
