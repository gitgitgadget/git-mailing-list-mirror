From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: git show and the --quiet option
Date: Sun, 29 May 2011 15:24:10 +0200
Message-ID: <20110529132410.GC28708@centaur.lab.cmartin.tk>
References: <4DE12888.1040506@isy.liu.se>
 <20110528172611.GB28708@centaur.lab.cmartin.tk>
 <4DE13906.9030806@isy.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Sun May 29 15:24:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQfyb-0007AB-8Q
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 15:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab1E2NYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 09:24:12 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48739 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497Ab1E2NYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 09:24:11 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9cec2.pool.mediaWays.net [77.185.206.194])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A9AE1461D9;
	Sun, 29 May 2011 15:23:43 +0200 (CEST)
Received: (nullmailer pid 8782 invoked by uid 1000);
	Sun, 29 May 2011 13:24:10 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4DE13906.9030806@isy.liu.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174690>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 28, 2011 at 08:03:50PM +0200, Gustaf Hendeby wrote:
> Hi Carlos,
>=20
> thanks for the detailed answer.
>=20
> On 05/28/2011 07:26 PM, Carlos Mart=C3=ADn Nieto wrote:
> > On Sat, May 28, 2011 at 06:53:28PM +0200, Gustaf Hendeby wrote:
> >> Hello everyone,
> >>
> >> I was playing around with "git show" lately and realized it has changed
> >> its behavior regarding the --quiet option, which no longer suppresses
> >> the diff output as it used to.  The behavior change happened in
> >> 1c40c36b ("log: convert to parse-options").  Was this intentional?
> >  How are you using the --quiet option and why would you even need it?
>=20
> I used
>=20
> git show --quiet --pretty=3D"format:%ci" HEAD
>=20
> to extract the commit date of HEAD, and I simply replaced it with
>=20
> git log -1 --quiet --pretty=3D"format:%ci" HEAD
>=20
> Though, the email from Junio suggests I should use (and this works)
>=20
> git show -a --pretty=3D"format:%ci" HEAD
>=20

I'm assuming you meant -s instead of -a

> still, I wonder if there is no better/more efficient solution to this.
>=20

There is --format, so that line would look like

    git show -s --format=3D"%ci" HEAD

which IMO is quite compact and self-explanatory. Depending on how much
control you have over the environment, you could set up an alias like

    git config alias.show-commit 'show -s'

or even

    git config alias.show-commit-date 'show -s --format=3D"%ci"'

   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN4kj6AAoJEHKRP1jG7ZzTJVYH/03RZs3iSlu5oxUb4i9ygyGM
VM8xKyW6Fsd2/ryhB+R1xiKxcMzLQ4qs8aPOdZ7su3WKHlG8UyncWHZYPRDWqm9/
zfbwJv7CHJQjbzxJi42F/+brBG468+k7NLyVmX20ZB+zTuvSWJcqmrpmDpC4kf6Z
o3OAvE29aqIyAAKhy+tmHS+66iY/brtgdapiWec8tE3jFtu4tUqBpBaEWlEHNFR7
p9XIPvG14unFYbVi74dibhLvD+1lzxtpfGuFKmh1q+6T4jhadMytCCSCyWs62BD6
BKVNyPnAl/aATdyA78uxhFpmSNFbPsraDCzBaU/l2r1tXYj+gIA7AHqZ0Z3yZNw=
=AoDX
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
