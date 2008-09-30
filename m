From: Andres Freund <andres@anarazel.de>
Subject: Bug?  git svn fetch: "unable to create temporary sha1 filename /home/andres/git/public/crystal.git/objects/96: File exists"
Date: Tue, 30 Sep 2008 02:09:55 +0200
Message-ID: <200809300210.00285.andres@anarazel.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5194179.qNKBtYBQIR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 02:21:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkSzP-0003eb-6a
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 02:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbYI3AUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 20:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYI3AUH
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 20:20:07 -0400
Received: from mail.anarazel.de ([217.115.131.40]:50554 "EHLO smtp.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbYI3AUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 20:20:06 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Sep 2008 20:20:05 EDT
Received: from alap2.localnet (e178198138.adsl.alicedsl.de [85.178.198.138])
	by smtp.anarazel.de (Postfix) with ESMTPSA id 6C142248001
	for <git@vger.kernel.org>; Tue, 30 Sep 2008 02:10:02 +0200 (CEST)
User-Agent: KMail/1.10.1 (Linux/2.6.27-rc7; KDE/4.1.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97060>

--nextPart5194179.qNKBtYBQIR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I regularly run git-svn fetch on some mirrors of svn repositories - which=20
works quite well.
But now I started to get this error:

Last successfull git svn fetch:
        M       src/z3c/form/browser/file-testing.txt
r91613 =3D 27c991067847b4a54a4d8bc71d440c74893475af (trunk)
=46rom .
   c7c32b3..27c9910  trunk      -> trunk

=46irst failing svn fetch:
        M       plugins/cscript/pycore/coremod.cpp
        M       plugins/cscript/cspython/pytocs.cpp
error: unable to create temporary sha1 filename=20
/home/andres/git/public/crystal.git/objects/96: File exists

fatal: Unable to add /tmp/Git_zIIUG4 to database
hash-object -w --stdin-paths: command returned error: 128

error closing pipe: Bad file descriptor at /usr/local/libexec/git-core/git-=
svn=20
line 0
error closing pipe: Bad file descriptor at /usr/local/libexec/git-core/git-=
svn=20
line 0
        M       src/z3c/form/tests/test_doc.py
r91624 =3D 6a9a5c03c44618ca1cc34cf428c94b25009c6fc4 (trunk)
        A       src/z3c/form/testing.txt
r91625 =3D a10508daf71d4e8aaad5531f5bcf8cb4ef0695e8 (trunk)
=46rom .
   27c9910..a10508d  trunk      -> trunk

All further git svn fetch invocation result in something alike:

Index mismatch: c8858cc0b587ab638af9ed52e7c03c8966b7db63 !=3D=20
c32a46c51a046500a3765fe573b95e2eb2f44b2a
rereading 87e2a16d8c259eba290bde0512af4d6bc1f64d1f
        M       plugins/cscript/pycore/coremod.cpp
        M       plugins/cscript/cspython/pytocs.cpp
error: unable to create temporary sha1 filename=20
/home/andres/git/public/crystal.git/objects/96: File exists

fatal: Unable to add /tmp/Git_YSlrAs to database
hash-object -w --stdin-paths: command returned error: 128

error closing pipe: Bad file descriptor at /usr/local/libexec/git-core/git-=
svn=20
line 0
error closing pipe: Bad file descriptor at /usr/local/libexec/git-core/git-=
svn=20
line 0

svn fetch is always invocated as "git --bare svn fetch".

Git repository is located at:
git://git.anarazel.de/crystal.git
http://git.anarazel.de/git/crystal.git

Original svn repository is located at:=20
https://crystal.svn.sourceforge.net/svnroot/crystal

Any idea?

Thanks,

Andres


--nextPart5194179.qNKBtYBQIR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjhblMACgkQporPraT14igQAQCaAxY+i8+oBw4fOVbcgIfLYFWZ
JzcAn3qp8msrhymbVX3xVoOIOfKCnbA1
=lr+3
-----END PGP SIGNATURE-----

--nextPart5194179.qNKBtYBQIR--
