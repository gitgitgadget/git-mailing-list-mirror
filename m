From: Nico -telmich- Schottelius <nico-git-20080317@schottelius.org>
Subject: Re: New script: git-archiv-tarbz2.sh
Date: Mon, 17 Mar 2008 12:44:10 +0100
Message-ID: <20080317114410.GA3399@denkbrett.schottelius.org>
References: <20080317110058.GA2513@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Cc: Nico -telmich- Schottelius <nico-git-20080317@schottelius.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 12:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbDlh-0003pd-66
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 12:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbYCQLn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 07:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYCQLn5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 07:43:57 -0400
Received: from creme.schottelius.org ([62.65.138.66]:55972 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751976AbYCQLn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 07:43:56 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id 333E925A7F4;
	Mon, 17 Mar 2008 12:43:51 +0100 (CET)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id 3A62F16897; Mon, 17 Mar 2008 12:44:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080317110058.GA2513@denkbrett.schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.24.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77428>


--DIOMP1UsTsWJauNi
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ups, in that version was a "!" missing, attached corrected version.

Nico

Nico -telmich- Schottelius [Mon, Mar 17, 2008 at 12:00:58PM +0100]:
> Hello list!
>=20
> I coded git-archiv-tarbz2.sh, which I use to create tars bzip2ed and
> without compression for my projects (especially gpm and ccollect),
> because I am to lazy to call git-archive every time.
>=20
> If you want, you can include it as a script into git.
>=20
> It is currently included in gpms git:
>=20
> http://unix.schottelius.org/cgi-bin/gitweb.cgi?p=3Dgpm;a=3Dblob;f=3Dscrip=
ts/git-archiv-tarbz2.sh;h=3Db5641946b804b4a15e063c9416831f77b58c973b;hb=3DH=
EAD
>=20
> which is available at http://unix.schottelius.org/git/gpm/.
>=20
> If you have comments, just drop me a message directly, as I am not
> subscribed anymore.
>=20
> Sincerly
>=20
> Nico
>=20
> --=20
> Think about Free and Open Source Software (FOSS).
> http://nico.schottelius.org/documentations/foss/the-term-foss/
>=20
> PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C





--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--LpQ9ahxlCli8rRTG
Content-Type: application/x-sh
Content-Disposition: attachment; filename="git-archiv-tarbz2.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# =0A# 2008      Nico Schottelius (nico-git-dev at schottelius.=
org)=0A# =0A#=0A# This file is free software: you can redistribute it and/o=
r modify=0A# it under the terms of the GNU General Public License as publis=
hed by=0A# the Free Software Foundation, either version 3 of the License, o=
r=0A# (at your option) any later version.=0A# =0A# This file is distributed=
 in the hope that it will be useful,=0A# but WITHOUT ANY WARRANTY; without =
even the implied warranty of=0A# MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE.  See the=0A# GNU General Public License for more details.=0A# =
=0A# You should have received a copy of the GNU General Public License=0A# =
along with ccollect. If not, see <http://www.gnu.org/licenses/>.=0A#=0A# Wr=
itten on: 20080314=0A#=0A=0Aversion=3D"$1"=0Ame=3D${0##*/}=0A=0Aif [ ! "$ve=
rsion" ]; then=0A   echo "${me}: Version"=0A   exit 1=0Afi=0A=0Aif [ ! -d .=
git ]; then=0A   echo "There is no .git in here."=0A   exit 2=0Afi=0A=0Apwd=
=3D$(pwd)=0Aname=3D${pwd##*/}=0A=0Agit archive --format=3Dtar --prefix=3D${=
name}-${version}/ HEAD | \=0A   tee ../${name}-${version}.tar | bzip2 -9 > =
=2E./${name}-${version}.tar.bz2=0A
--LpQ9ahxlCli8rRTG--

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH3lmKuL75KpiFGIwRAnvIAKDS27U3yFtwWQtWq4FZt0zO1xBCbgCgw3xK
ujpLzrYeccj4nP3TdhAeTp0=
=2JAN
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
