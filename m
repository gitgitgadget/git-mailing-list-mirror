From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Errors GITtifying GCC and Binutils
Date: Wed, 22 Mar 2006 14:33:37 +0100
Message-ID: <20060322133337.GU20746@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWIFStbFpmlD00Pf"
X-From: git-owner@vger.kernel.org Wed Mar 22 14:34:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM3T4-00061v-AO
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 14:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWCVNdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 08:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWCVNdj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 08:33:39 -0500
Received: from lug-owl.de ([195.71.106.12]:63629 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751238AbWCVNdi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 08:33:38 -0500
Received: by lug-owl.de (Postfix, from userid 1001)
	id 82486F0037; Wed, 22 Mar 2006 14:33:37 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17814>


--QWIFStbFpmlD00Pf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently working a lot with Binutils and GCC and wanted to import
those two projects into GIT trees, but both of them failed. If anybody
wants to have access to the half-finished GIT trees, please let me
know:

This is with GIT as of yesterday evening:

Binutils
~~~~~~~~
$ /home/jbglaw/bin/git cvsimport -v -d :pserver:anoncvs@sourceware.org:/cvs=
/src -C src src
[...]
Update gdb/testsuite/ChangeLog: 230971 bytes
Fetching gdb/testsuite/gdb.base/annota1.exp   v 1.1.1.2
Update gdb/testsuite/gdb.base/annota1.exp: 14656 bytes
Fetching gdb/testsuite/gdb.base/annota2.cc   v 1.1.1.3
Update gdb/testsuite/gdb.base/annota2.cc: 238 bytes
Fetching gdb/testsuite/gdb.base/annota2.exp   v 1.1.1.2
Update gdb/testsuite/gdb.base/annota2.exp: 8639 bytes
Fetching sim/mcore/ChangeLog   v 1.1.1.5
Update sim/mcore/ChangeLog: 1325 bytes
Fetching sim/mcore/interp.c   v 1.1.1.5
Update sim/mcore/interp.c: 47368 bytes
Tree ID 640f8ff80e14257bc73fa0c3344504c4db960655
Parent ID ac9471abd876476724dc0205272b0565c18b1a7c
Committed patch 102 (SNAPSHOT 1999-05-25 18:00:33)
Commit ID 5847cc095ce0445eb6bf9df1203ccdad35f501fe
Created tag 'gdb-1999-05-25' on 'SNAPSHOT'
Switching from SNAPSHOT to origin
Fetching bfd/ChangeLog   v 1.19
Update bfd/ChangeLog: 118751 bytes
Fetching bfd/elf32-arm.h   v 1.4
Update bfd/elf32-arm.h: 90491 bytes
Tree ID 5100b5c49ef78e1027b476f4dbdebeca0b01f113
Parent ID 8d35c43246f8d9693203ef6a87aabf378593bceb
Committed patch 103 (origin 1999-05-26 08:27:37)
Commit ID bb18137d43506ccc7f78da63b18d9f6b6749264d
Fetching include/opcode/ChangeLog   v 1.4
Update include/opcode/ChangeLog: 63395 bytes
Fetching include/opcode/hppa.h   v 1.2
Update include/opcode/hppa.h: 23271 bytes
Tree ID 7b211af5cb99cbe307d02d72c1e144f3c1aac7e9
Parent ID bb18137d43506ccc7f78da63b18d9f6b6749264d
Committed patch 104 (origin 1999-05-26 16:04:10)
Commit ID 4da3ef4d311fc62a1a0bba8b680595ad824a7e2c
Fetching ld/ChangeLog   v 1.11
Update ld/ChangeLog: 328968 bytes
Fetching ld/emulparams/armelf_oabi.sh   v 1.2
Update ld/emulparams/armelf_oabi.sh: 585 bytes
Tree ID fcc05a0f9c66693e5b26a5fb4821f6bbeadf4c31
Parent ID 4da3ef4d311fc62a1a0bba8b680595ad824a7e2c
Committed patch 105 (origin 1999-05-26 17:23:31)
Commit ID ddaaceeede7f9bb938188c4f72ddce420d08efad
Switching from origin to gdb-4_18-branch
usage: git-read-tree (<sha> | -m [--aggressive] [-u | -i] <sha1> [<sha2> [<=
sha3>]])
read-tree failed: 33024

$ /home/jbglaw/bin/git cvsimport -v -d :pserver:anoncvs@sourceware.org:/cvs=
/src -C src src
usage: git-read-tree (<sha> | -m [--aggressive] [-u | -i] <sha1> [<sha2> [<=
sha3>]])
read-tree failed: 33024




GCC
~~~
$ /home/jbglaw/bin/git svnimport -C gcc -v svn://gcc.gnu.org/svn/gcc
[...]
=2E.. 3930 trunk/gcc/combine.c ...
Tree ID 2af6a2f6e28835fec0aaf60d278e356d12d9ae5f
Merge parent branch: 587bbd00ea5b0f8c18d8ca58bbfcaa4b6b62ff92
Committed change 3930:/ 1993-03-30 20:37:29)
Commit ID 3ed4cebd349a2c98c7a06d6333b014bd4fe23d6d
Writing to refs/heads/origin
DONE: 3930 origin 3ed4cebd349a2c98c7a06d6333b014bd4fe23d6d
=2E.. 3931 trunk/gcc/config/mips/mips.h ...
Tree ID f173f836adf4d8efb42c180d7cd5a786a3acf361
Merge parent branch: 3ed4cebd349a2c98c7a06d6333b014bd4fe23d6d
Committed change 3931:/ 1993-03-30 21:50:50)
Commit ID 7c132f1464d27bd8198c51913b17a0534376e3e6
Writing to refs/heads/origin
DONE: 3931 origin 7c132f1464d27bd8198c51913b17a0534376e3e6
=2E.. 3932 trunk/gcc/config/pa/pa.md ...
Tree ID a88f5523f982dbac1334b78c47fd56a685640a46
Merge parent branch: 7c132f1464d27bd8198c51913b17a0534376e3e6
Committed change 3932:/ 1993-03-30 22:02:05)
Commit ID 9a8ddfa77f6735c8ba87ab98bc3ac7b056a09d96
Writing to refs/heads/origin
DONE: 3932 origin 9a8ddfa77f6735c8ba87ab98bc3ac7b056a09d96
=2E.. 3933 trunk/gcc/real.c ...
Tree ID 7d25a64013b301e0e575587a5adfd8b540b4c5a7
Merge parent branch: 9a8ddfa77f6735c8ba87ab98bc3ac7b056a09d96
Committed change 3933:/ 1993-03-31 05:30:24)
Commit ID 70cc7d27f3a4e5117df4e4d2f6e5a2aa4c4a89a6
Writing to refs/heads/origin
DONE: 3933 origin 70cc7d27f3a4e5117df4e4d2f6e5a2aa4c4a89a6
=2E.. 3934 trunk/gcc/real.h ...
Tree ID fce52e724f0f1543abd5bd430a11822c3977e803
Merge parent branch: 70cc7d27f3a4e5117df4e4d2f6e5a2aa4c4a89a6
Committed change 3934:/ 1993-03-31 05:39:37)
Commit ID f8dad6fb5af69122823800ca974e16d4f09906c2
Writing to refs/heads/origin
DONE: 3934 origin f8dad6fb5af69122823800ca974e16d4f09906c2
=2E.. 3935 trunk/gcc/Makefile.in ...
Tree ID 7c2cd41d922407ab1df47954fb82964ad7511328
Merge parent branch: f8dad6fb5af69122823800ca974e16d4f09906c2
Committed change 3935:/ 1993-03-31 05:41:37)
Commit ID eb99aa0ad37564c2071fe4b2f539fe072a72ad4c
Writing to refs/heads/origin
DONE: 3935 origin eb99aa0ad37564c2071fe4b2f539fe072a72ad4c
=2E.. 3936 trunk/gcc/c-lex.c ...
Tree ID 90547e4ef900e45f4354aa036f216a3bff93c8dd
Merge parent branch: eb99aa0ad37564c2071fe4b2f539fe072a72ad4c
Committed change 3936:/ 1993-03-31 05:44:03)
Commit ID ceff85145f8671fb2a9d826a761cedc2a507bd1e
Writing to refs/heads/origin
DONE: 3936 origin ceff85145f8671fb2a9d826a761cedc2a507bd1e
=2E.. 3937 trunk/gcc/final.c ...
Can't fork at /home/jbglaw/bin/git-svnimport line 379.

$ /home/jbglaw/bin/git svnimport -C gcc -v svn://gcc.gnu.org/svn/gcc
Use of uninitialized value in system at /home/jbglaw/bin/git-svnimport line=
 295.
usage: git-read-tree (<sha> | -m [--aggressive] [-u | -i] <sha1> [<sha2> [<=
sha3>]])
read-tree failed: 33024



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

--QWIFStbFpmlD00Pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEIVIxHb1edYOZ4bsRAvRMAKCQk2mR1sebeYSYld0ckiE18eFdBQCgjgJK
NkGY7HVxznEAWEMVFlE2/fA=
=FsBq
-----END PGP SIGNATURE-----

--QWIFStbFpmlD00Pf--
