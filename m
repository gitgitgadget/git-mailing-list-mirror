From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git version not changed after installing new version
Date: Wed, 25 Jan 2012 20:58:09 +0100
Message-ID: <1327521489.31804.85.camel@centaur.lab.cmartin.tk>
References: <loom.20120125T173801-500@post.gmane.org>
	  <loom.20120125T181639-351@post.gmane.org>
	 <1327517841.31804.75.camel@centaur.lab.cmartin.tk>
	 <loom.20120125T202642-92@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-RG2Yl45L3i7dbns/2utj"
Cc: git@vger.kernel.org
To: freefly <free.fly@live.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 20:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq8z2-0000fz-7b
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 20:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab2AYT6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 14:58:11 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:43007 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2AYT6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 14:58:10 -0500
Received: from [192.168.1.17] (brln-4dbc4241.pool.mediaWays.net [77.188.66.65])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 4053D46092;
	Wed, 25 Jan 2012 20:58:05 +0100 (CET)
In-Reply-To: <loom.20120125T202642-92@post.gmane.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189123>


--=-RG2Yl45L3i7dbns/2utj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Please don't cull the CC list. It's customary in the git ML to send a
copy of the message to each participant.

On Wed, 2012-01-25 at 19:32 +0000, freefly wrote:
>=20
> > What do `which git` and `type git` say? Bash remembers where it ran a
> > command so if you install a binary to a new location, it might not find
> > it straight away.
>=20
> which git =3D> /usr/bin/git
>=20
> type git =3D> git is hashed (/usr/bin/git)
>=20
> > So the script detected that no change was needed presumably. What's you=
r
> > $PATH and is /usr/local/bin/ before /usr/bin/?
> =20
> echo $PATH =3D> /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:
>                          /usr/X11/bin:/usr/local/git/bin:/opt/local/bin
>=20
> from the above output it is not before /usr/bin :(

There you go then. That should get set in ~/.bashrc so edit that file to
change the order.

   cmn


--=-RG2Yl45L3i7dbns/2utj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPIF7RAAoJEHKRP1jG7ZzTUHYH/0TVosP8AlPyBgimZbZvT/Lt
xXPnVBAFi3iuCuwPhzhkwSPdlak/DlkoIL22JnzojBiL/8udsNLaVF1Riofb2le8
ZQ1LfGSWl6VLhVplVL4xBlczWEzT8dNtsboXqqiUJafh75t1siv+32q5Q1mkCyC/
gYOOVVqGjVkoKflfsom/J2rIO6IAYo1ByAXHiIYtzVtwMQfVVb/DVmdFArVANqpx
UjV6ksnLz+Im6Kr7HAWplIARKB5M84yGFassJqF/+jFE9Gop/9Uqe2jAVhUSB19B
GIixTKM/rOdgQBFvl7K3RZe2UA7j8RzbvEO/zEkMLpSgoUl/92Nb33Mp9Hd/QAM=
=Klnf
-----END PGP SIGNATURE-----

--=-RG2Yl45L3i7dbns/2utj--
