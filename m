From: martin f krafft <madduck@madduck.net>
Subject: Re: reviving a git-svn clone
Date: Tue, 21 Apr 2009 13:58:15 +0200
Message-ID: <20090421115815.GC7967@piper.oerlikon.madduck.net>
References: <20090420104316.GA11433@lapse.rw.madduck.net> <1240296712.3424.8.camel@maia.lan> <86d4c5e00904210209v3f1b8fd3t6a991fe44455941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
To: Deskin Miller <deskinm@gmail.com>, Sam Vilain <sam@vilain.net>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 14:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwEe6-00036l-46
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 14:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbZDUL6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 07:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZDUL6g
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 07:58:36 -0400
Received: from clegg.madduck.net ([193.242.105.96]:43968 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbZDUL6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 07:58:35 -0400
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "piper.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id A0CD21D409B;
	Tue, 21 Apr 2009 13:58:16 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id F182C43F3; Tue, 21 Apr 2009 13:58:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86d4c5e00904210209v3f1b8fd3t6a991fe44455941@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.29-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9266/Tue Apr 21 12:05:25 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117124>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Deskin Miller <deskinm@gmail.com> [2009.04.21.1109 +0200]:
> If you have access to the svn remote, you should be able to avoid
> hacking config and .metadata entirely by entering
>=20
> $ git svn init --stdlayout --prefix=3Dupstream/
> svn+ssh://svn.suspend2.net/svn/hibernate-script

This worked nicely, so thanks to you, Sam, and Thomas Rast (who
helped on IRC). Here is what I ended up doing:

alioth:~|master|% git clone /git/collab-maint/hibernate.git hibernate-svnsy=
nc
Initialized empty Git repository in /srv/alioth.debian.org/chroot/home/user=
s/madduck/hibernate-svnsync/.git/
alioth:~|master|% cd hibernate-svnsync=20
total 204
drwx------ 2  4096 20090421.1013 admin
drwx------ 3  4096 20090421.1013 debian
drwx------ 2  4096 20090421.1013 init.d
drwx------ 2  4096 20090421.1013 scriptlets.d
-rw------- 1 21417 20090421.1013 CHANGELOG
-rw------- 1 17992 20090421.1013 COPYING
-rw------- 1  6902 20090421.1013 README
-rw------- 1  1470 20090421.1013 README.xfs
-rw------- 1  6891 20090421.1013 SCRIPTLET-API
-rw------- 1  2020 20090421.1013 blacklisted-modules
-rw------- 1  4004 20090421.1013 common.conf
-rw------- 1   310 20090421.1013 disk.conf
-rw------- 1  7047 20090421.1013 gen-manpages.sh
-rw------- 1   518 20090421.1013 hibernate.conf
-rw------- 1 26637 20090421.1013 hibernate.sh
-rw------- 1  4165 20090421.1013 hibernate.spec
-rw------- 1 13822 20090421.1013 hibernate.vim
-rwx------ 1  4664 20090421.1013 install.sh
-rw------- 1    79 20090421.1013 logrotate.d-hibernate-script
-rwx------ 1   608 20090421.1013 mktarball.sh
-rw------- 1   837 20090421.1013 ram.conf
-rw------- 1  1288 20090421.1013 suspend2.conf
-rw------- 1   345 20090421.1013 sysfs-disk.conf
-rw------- 1   289 20090421.1013 sysfs-ram.conf
-rw------- 1     8 20090421.1013 tuxonice-binary-signature.bin
-rw------- 1   509 20090421.1013 ususpend-both.conf
-rw------- 1   501 20090421.1013 ususpend-disk.conf
-rw------- 1  1324 20090421.1013 ususpend-ram.conf
alioth:~/hibernate-svnsync|master|% git svn init --stdlayout --prefix=3Dups=
tream/ svn+ssh://svn.suspend2.net/svn/hibernate-script                     =
                                                              alioth:~/hibe=
rnate-svnsync|master|% git update-ref refs/remotes/upstream/trunk refs/remo=
tes/origin/upstream
alioth:~/hibernate-svnsync|master|% git show-ref refs/remotes/upstream/trun=
k refs/remotes/origin/upstream
1784ac6d733527ea65c2e9515df30c7a77d8f90b refs/remotes/origin/upstream
1784ac6d733527ea65c2e9515df30c7a77d8f90b refs/remotes/upstream/trunk
alioth:~/hibernate-svnsync|master|% git checkout -b upstream upstream/trunk
Switched to a new branch "upstream"
alioth:..bernate-svnsync|upstream|% git svn info
Rebuilding .git/svn/upstream/trunk/.rev_map.c12ee44c-9ede-0310-94ea-d4716f4=
f7118 ...
r840 =3D 56b969c867a8480521c25e7f943634a865d4ac33
[=E2=80=A6]
r1195 =3D 1784ac6d733527ea65c2e9515df30c7a77d8f90b
Done rebuilding .git/svn/upstream/trunk/.rev_map.c12ee44c-9ede-0310-94ea-d4=
716f4f7118
Use of uninitialized value within @_ in localtime at /usr/bin/git-svn line =
4277.
No such file or directory at /usr/bin/git-svn line 897.



Now I can turn to changing the URL, since upstream wants to drop
svn.suspend2.net in favour of svn.tuxonice.net. This does not seem
to be as straight-forward as it should be. I hate SVN!

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
god is real, unless declared integer.
                                          (dedicated to gabriel g=C3=B3mez)
=20
spamtraps: madduck.bogus@madduck.net

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknttNcACgkQIgvIgzMMSnVw+ACgph9v+YHFJ+DTFGqUOGDewzuf
UikAnjiA/MuHtSyhCMwq7f1GiMnRbIJc
=i6ZJ
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
