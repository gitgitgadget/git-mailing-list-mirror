From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 19:25:04 +0100
Message-ID: <20060324182504.GI31387@lug-owl.de>
References: <20060322133337.GU20746@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
X-From: git-owner@vger.kernel.org Fri Mar 24 19:25:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMqyF-0002VV-Oe
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 19:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWCXSZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 13:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWCXSZI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 13:25:08 -0500
Received: from lug-owl.de ([195.71.106.12]:34753 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932428AbWCXSZG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 13:25:06 -0500
Received: by lug-owl.de (Postfix, from userid 1001)
	id 0736BF003D; Fri, 24 Mar 2006 19:25:04 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060322133337.GU20746@lug-owl.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17933>


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-22 14:33:37 +0100, Jan-Benedict Glaw <jbglaw@lug-owl.de> wr=
ote:

Since it seems nobody looked at the GCC import run (which means to use
the svnimport), I ran it again, under strace control:

> GCC
> ~~~
> $ /home/jbglaw/bin/git svnimport -C gcc -v svn://gcc.gnu.org/svn/gcc

> Committed change 3936:/ 1993-03-31 05:44:03)
> Commit ID ceff85145f8671fb2a9d826a761cedc2a507bd1e
> Writing to refs/heads/origin
> DONE: 3936 origin ceff85145f8671fb2a9d826a761cedc2a507bd1e
> ... 3937 trunk/gcc/final.c ...
> Can't fork at /home/jbglaw/bin/git-svnimport line 379.

=2E.. 4279 trunk/gcc/config/i386/xm-sco.h ...

This time it broke at a different revision, so I guess it's not a SVN
or git / git-svnimport problem, but rather a problem of my Perl
installation or the kernel itself?

Tree ID 5b04fbc98f8dc9d50506b6dbc8f31567eea2e225
Committed change 4279:/ 1993-04-29 21:13:46)
Merge parent branch: eeb742d8ffd78d58f05d0b9c80bb55e1dc25ad13
Commit ID e85129f5e8af0b93a41d5bf294f17a9c9bf9fa21
Writing to refs/heads/origin
DONE: 4279 origin e85129f5e8af0b93a41d5bf294f17a9c9bf9fa21
=2E.. 4280 trunk/gcc/config/mips/mips.h ...
Tree ID 3feb45ec3ee93e8a6d75b8ce552281e0ed2d7215
Committed change 4280:/ 1993-04-30 00:53:35)
Merge parent branch: e85129f5e8af0b93a41d5bf294f17a9c9bf9fa21
Commit ID 34b473ffc0e05419c50be848d5349592b7c48ee3
Writing to refs/heads/origin
DONE: 4280 origin 34b473ffc0e05419c50be848d5349592b7c48ee3
readline() on closed filehandle H at /home/jbglaw/bin/git-svnimport line 56=
2.
4281: cannot find commit 'origin'!
readline() on closed filehandle H at /home/jbglaw/bin/git-svnimport line 56=
2.
4282: cannot find commit 'origin'!
readline() on closed filehandle H at /home/jbglaw/bin/git-svnimport line 56=
2.
4283: cannot find commit 'origin'!
readline() on closed filehandle H at /home/jbglaw/bin/git-svnimport line 56=
2.
4284: cannot find commit 'origin'!
readline() on closed filehandle H at /home/jbglaw/bin/git-svnimport line 56=
2.
4285: cannot find commit 'origin'!
=2E.. 4286 trunk/gcc/fixincludes ...
Can't fork at /home/jbglaw/bin/git-svnimport line 379.


strace of this:

read(3, "rintf decl"..., 4096)          =3D 2896
write(6, "superfluou"..., 4096)         =3D 4096
read(3, "$file ${LI"..., 4096)          =3D 1448
read(3, "m -f ${LIB"..., 4096)          =3D 1448
read(3, "LIB}/machi"..., 4096)          =3D 1448
write(6, " 2>/dev/nu"..., 4096)         =3D 4096
read(3, "memory\\.h"..., 4096)          =3D 2896
read(3, "h>\") > ${"..., 4096)          =3D 1448
write(6, "&& [ ! -r "..., 4096)         =3D 4096
read(3, " char *__n"..., 4096)          =3D 3438
write(6, "claim to h"..., 4096)         =3D 4096
write(6, "ymbolic no"..., 446)          =3D 446
close(6)                                =3D 0
pipe([6, 7])                            =3D 0
clone(child_stack=3D0,
flags=3DCLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=3D0xb7ddf708) =3D -1 ENOMEM (Cannot allocate memory)
close(6)                                =3D 0
close(7)                                =3D 0
write(2, "Can\'t for"..., 55)           =3D 55
close(4)                                =3D 0
close(3)                                =3D 0

What are possible reasons for clone() to fail with -ENOMEN? I have to
admit that the box _is_ loaded a bit all the time:

jbglaw@bixie:~/vax/git-conversion$ uptime
 19:23:58 up 136 days,  7:46, 20 users,  load average: 4.45, 4.25, 3.05
jbglaw@bixie:~/vax/git-conversion$ free
             total       used       free     shared    buffers     cached
Mem:        507308     501760       5548          0       2184      16900
-/+ buffers/cache:     482676      24632
Swap:      2441872    1295512    1146360

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEJDmAHb1edYOZ4bsRAq6vAJ4sbWc88fFbVwCkX13olaAyCUGuPQCeLv1Z
LIeIbFB5w8/wmWJ1npkZKWA=
=Ss77
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
