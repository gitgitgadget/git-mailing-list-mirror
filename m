From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Bug report: git log --[num|short]stat sometimes counts lines
 wrong
Date: Mon, 15 Aug 2011 17:26:39 +0200
Message-ID: <1313422005.26123.2.camel@bee.lab.cmartin.tk>
References: <45CC44BC-03FF-4C5F-97B7-7ED03CB68BC2@inf.fu-berlin.de>
	 <91324E9A-3134-455D-B7CA-ABBDA88FC7B7@inf.fu-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-gXM2tF1BA5vjdt6uIXY0"
Cc: git@vger.kernel.org
To: Alexander Pepper <pepper@inf.fu-berlin.de>
X-From: git-owner@vger.kernel.org Mon Aug 15 17:26:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsz40-0007MM-8K
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 17:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab1HOP0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 11:26:47 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38014 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab1HOP0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 11:26:46 -0400
Received: from [192.168.1.21] (brln-4db9ee8e.pool.mediaWays.net [77.185.238.142])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 38A5346217;
	Mon, 15 Aug 2011 17:26:36 +0200 (CEST)
In-Reply-To: <91324E9A-3134-455D-B7CA-ABBDA88FC7B7@inf.fu-berlin.de>
X-Mailer: Evolution 3.1.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179372>


--=-gXM2tF1BA5vjdt6uIXY0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-08-15 at 10:24 +0200, Alexander Pepper wrote:
> Am 12.08.2011 um 17:21 schrieb Alexander Pepper:
> > Hi there.
> > This is my first contribution to git (if you count a bug report as a co=
ntribution) and I'm not really familiar where to report bugs. In the irc ch=
annel #git at freenode somebody pointed me to this mailing list.
> >=20
> > First of: I'm running git version 1.7.6 on OS X 10.6.8.
> >=20
> > Let me describe what I observed.
> > repository: https://github.com/voldemort/voldemort.git
> > The command "git log --numstat c21ad764ea1bae7f7bd83b5e2cb015dcbc44d586=
" shows for the commit c21ad764 and file '.../readonly/mr/HadoopStoreBuilde=
rReducer.java' 25 lines added and 22 lines removed. But the patch of Hadoop=
StoreBuilderReducer.java that I get with "git show c21ad764ea1bae7f7bd83b5e=
2cb015dcbc44d586 -- contrib/hadoop-store-builder/src/java/voldemort/store/r=
eadonly/mr/HadoopStoreBuilderReducer.java" adds 30 lines and removes 27.
> >=20
> > Why does "git log --numstat" drops 5 added lines and 5 removed lines? T=
his also holds true for "git log --stat" and "git log --shortstat".
> >=20
> > Is this a bug or am I missing an option to git log or git show?
> >=20
> > More commits where I observed this problem on the same repository:
> > 7e00fb6d2cf131dfed59c180f2171952808cc336 src/java/voldemort/client/reba=
lance/MigratePartitions.java
> > 78ad6f2a6ea327dbae2110f4530a5bd07e5deaac src/java/voldemort/client/reba=
lance/MigratePartitions.java (same commit on another branch)
> > 7871933f0f0f056e2eeac03a01db1e9cf81f8bda src/java/voldemort/client/prot=
ocol/admin/AdminClient.java
> > 2d6f68b09c3bdc23dcf3ae1f91c9285fbd668820 src/java/voldemort/store/reado=
nly/ExternalSorter.java
> > 6fcacee866307ec34eb32b268e2c2b885a949319 build.xml
> >=20
> > Greetings from Berlin
> > Alex
>=20
> Hello again.
>=20
> I also observed this behavior with git version 1.7.4.1 on Gentoo.
>=20
> Any ideas how to fix this?

I've just checked and `git show --stat` does give different numbers from
`git show | diffstat`. Git ignores (or can ignore) empty lines in
several contexts, have you checked to see if there are 5 empty lines
added and removed?

Cheers,
   cmn

--=-gXM2tF1BA5vjdt6uIXY0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOSTqvAAoJEHKRP1jG7ZzTpQQH/j3sZwywSLCjMYzfFIrwpGF6
Vswekre+nTuY17Av/ngQtGfdDyb2D+N2N8xLrb6qnZuwMLGBJOGNhpZonLpyPk5S
ASsYjDoWyyj1dkDsP9kpcgJ1k2E2CMmzyG/1yW+mEvLln97ds05YFDh8uqgX5H/n
iL+VVpNQub3hxaKpZpS79ibFHi6cE38FD9UQTyqKYUW0j3kkHR/5A/a9v533yXv/
8BU8YxinpDWFZB7zEasS7850dAp0Ra5AuTCd7bQO9pVS4lRvYXA0l/M6VjlGvPJk
I1EY6+PapOeBerXKerqXxwPFiXkub6HJV1LdhQ+OFLXeYuxQYBmJ0Ltrl+z3YPI=
=2yIH
-----END PGP SIGNATURE-----

--=-gXM2tF1BA5vjdt6uIXY0--
