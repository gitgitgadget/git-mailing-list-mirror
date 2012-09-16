From: Paul Wise <pabs3@bonedaddy.net>
Subject: status of git interop with other VCS
Date: Sun, 16 Sep 2012 19:45:04 +0800
Message-ID: <1347795904.22408.20.camel@chianamo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-G6tD/+wmI50axYCIMgWc"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 14:02:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDDY2-0004pc-2H
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 14:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab2IPMBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 08:01:18 -0400
Received: from ns1.bonedaddy.net ([70.91.141.202]:40586 "EHLO
	ns1.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab2IPMBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 08:01:17 -0400
X-Greylist: delayed 965 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2012 08:01:17 EDT
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by ns1.bonedaddy.net (8.14.5/8.14.4) with ESMTP id q8GBj84x031462
	for <git@vger.kernel.org>; Sun, 16 Sep 2012 07:45:10 -0400
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205608>


--=-G6tD/+wmI50axYCIMgWc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I thought I would summarise current status of interop between git and
other remote VCSen. In particular I am interested in good git remote
helpers for cvs, svn, hg, darcs and bzr. git-svn and the like are useful
but git remote helpers are better because they map everything onto the
git model better.

cvs: there seems to have been a project but it was never merged:

http://marc.info/?l=3Dgit&m=3D127279549623477&w=3D2
http://thread.gmane.org/gmane.comp.version-control.git/131620/focus=3D13163=
2

svn: there was a gsoc project for this but it was never merged:

http://git.wiki.kernel.org/index.php/SoC2011Projects#Remote_helper_for_Subv=
ersion_and_git-svn

hg: there are a few projects for this, none are merged:

git://github.com/SRabbelier/git.git
http://marc.info/?l=3Dgit&m=3D134153749521450&w=3D2

darcs: can't find any project to add this, please let me know of one

bzr: git-remote-bzr is part of bzr-git but it is quite buggy, hopefully
this will improve over time though.

--=20
bye,
pabs

http://bonedaddy.net/pabs3/

--=-G6tD/+wmI50axYCIMgWc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQVbvAAAoJEDEWul6f+mmjghQQALvXkhtM8X0IFqhmkBaht8pi
dzeLcESRYnLr6nJMyB24EZ08BPHzTUIeI73aA+Om0j5hj1hp9TMyGAHV4WsBPcbt
b8uhHWi1o4AdJ+091baxSSg6D2Rl2QxtUmUgtaGtxMZpSN9YyqaC9hECFimxLHN0
vjiAqp3i295BozO+8TZZFZVrjIB3VYiwntcIhBJzwigYekV6ah45WMNH8JHGe+oe
ZmSfytYvXJBlcsv4bbo49mrcd27FQTsrLuX7N+eXrQbnF0rJayq1J7+n2FcCj0ru
SFy4CItfwNKn0zfU93TNdz0MKBPkLyryx2AxqGGzqUdiinnw9+KQaRac+bgx35mJ
Vjh5eFfqvQsZ6CMlALUecdywnnrWBupr7otlLxlMVXNivmdJNp1w7B9VIH6HpKq5
kp+0eXHKNpZmvS4AMPovwZoOS7C/fDDHw3MKOO9sLv2817RM3JP7Wk4BBZGxuMrc
SpD8JRsHpu6GBhTr1ADgCU7cqFOgAH7O4C8+vtsUSKem5LtyK6J/tgYUhzViUako
/A8rrv/lKIirEl8fBURD7rPly1vDBWZ9NDj95QZaYQ/Ii2OVQHS3EJWaZxoIdoMx
b7NzLSYodYJy4fhNQNzp77rLdISfPXFXGoc6hbUW15UGToWqia50lQgEM3o6kBzt
0cESc6FRDuS8kZSt4Zi8
=fqLY
-----END PGP SIGNATURE-----

--=-G6tD/+wmI50axYCIMgWc--
