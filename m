From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sun, 20 Nov 2005 08:32:44 +0100
Message-ID: <20051120073244.GA7902@kiste.smurf.noris.de>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de> <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 08:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edjhi-0001In-ED
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 08:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVKTHde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 02:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVKTHdd
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 02:33:33 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:31104 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1750820AbVKTHdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 02:33:33 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Edjgq-0008Sc-PC; Sun, 20 Nov 2005 08:32:56 +0100
Received: (nullmailer pid 7986 invoked by uid 501);
	Sun, 20 Nov 2005 07:32:44 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12373>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin:
> Then, I'd merge the new development's HEAD, and it would be fine:
>=20
Why not simply use info/grafts?

ORIG1 .. ORIG2 .. .. ORIG_HEAD
                            \\
                             GIT1 .. GIT2 .. .. GIT_HEAD

where the \\ link is the graft entry.

If we want (need, these days -- the history is so long that gitk draws
spurious lines becase of 16-bit window coordinate overflow) to chop off
history at some point, we can use the newfangled date parser + config
file stuff to set a sane default.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
July 4.  Statistics show that we loose more fools on this day than in all t=
he
other days of the year put together.  This proves, by the number left in st=
ock,
that one Fourth of July per year is now inadequate, the country has grown s=
o.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDgCac8+hUANcKr/kRAsDAAJ9Vq92X2T+Tfyw1/lHmQHbXoRZDZQCeLgKi
TK525f3PjdyG0PITYFiFzS0=
=YrQt
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
