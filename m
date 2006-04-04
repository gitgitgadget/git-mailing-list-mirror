From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: [BUG] git-http-fetch segfault
Date: Tue, 04 Apr 2006 19:11:40 +0200
Message-ID: <4432A8CC.5020200@o2.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD4464707F867A7233A3270DE"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 04 19:17:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQp9I-0006zv-8H
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 19:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWDDRQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 13:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDDRQv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 13:16:51 -0400
Received: from mx2.go2.pl ([193.17.41.42]:64168 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750769AbWDDRQu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 13:16:50 -0400
Received: from zen.localdomain (host-81-190-200-101.gorzow.mm.pl [81.190.200.101])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 20330748076;
	Tue,  4 Apr 2006 19:16:41 +0200 (CEST)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FQp4T-0000Yv-BL; Tue, 04 Apr 2006 19:12:01 +0200
User-Agent: Mail/News 1.5 (X11/20060404)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18397>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4464707F867A7233A3270DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have some problems cloning stgit repository (maybe something's broken t=
here).

The repository seems to be using symlink HEAD.
Possibly the problem is because of a non-existent tag commit.

Yes, it has that broken HTTP error message bug.

Git version:
astralstorm@zen /home/devel/git $ git log -n 1 | head -n 1
commit fc9957b0052df6a8248420395bc9febd66194252

Session log (slightly linewrapped):

astralstorm@zen /home/devel $ git clone
http://homepage.ntlworld.com/cmarinas/stgit.git stgit
got 52f3900c0c7dec8581fa907495a09c900a3d39d7
walk 52f3900c0c7dec8581fa907495a09c900a3d39d7
got c82395b46d238948882045e76e7770319a4f40e8
got aa78d4ed34d262b6f811e7e47415c8c4ac6d80a2
walk c82395b46d238948882045e76e7770319a4f40e8
got 098c1d3e9fe5c39b859ccff6c7d36d2c193d1b62
got 4ebca0e1cabe90ecdcd29aab6fa16521d4999fb5
got 8d2bebd9d1824f1b7af5cfe6fbd11f9cbfde6d74
got 184ded8e08cb92a14b79c79f9919469ba352ab70
got d60c31a97a544b53039088d14fe9114583c0efc3
got e5affe07bf8b39e2aa0309299dbc9532e05940b5
got c2514fd418472dc173a5fef09c82ccf666c9555f
got 3c900ce9dae0959a9e4479b55b8a71d1b92d170d
got 7888f29f97452f8db39f4a9e857b7f1d2c913765
got 4359033a665b7943f2a7579e8329a715fd2fdc57
got def843c5d5fd4dee9a54504512b4308cb3a84018
got 0c3ad3951bb8cf368c70b13240665495e19a98a9
got 32977d8fae38a542b15dd9c5e39d64076a35227b
got 8847a11b3bbf5406f37a360e5466f0e392c56383
got 07704b8331d6d78a132c731874f66749dfa0f85c
got 5b8d95f20b8989fde6b0731c55b3f985ed01630a
got 6a8557477abde3f1368304e6fb8d890e2982267e
got de7bd13bae9eec619ae4baf46e65475602d52979
got 5899c38225df2244c7b09015f5b754d9735415d5
got ebd09f908d165c7aa3a135ddc8bbd5a05787df93
walk 8847a11b3bbf5406f37a360e5466f0e392c56383
got 6480a2a7f279002c3daf5a56ece16636cd5df26f
got 568bc169d53ee40ef5dc7481e7cab8078141fa9e
Getting alternates list for http://homepage.ntlworld.com/cmarinas/stgit.g=
it/
got 4b03e3a6440883cf8ef6092426b3d932b8b0c73a
got ee90cfb41de9e3a589fc688ba1350e9c8b846c20
got c394572a81d9b3322a7a7cdccec0c1846d445dcc
got 66e9f41044631264c2740f61ddafbc4bd01ec71a
got c603ff88fcd21f1e4b806413d195c90f29ea547f
got a0569457816c345e8c7fa92135fd664dd67ea97c
got 5749b3bd8476df9e2808a3723e23d7acd4e4c71d
got f4d749004ac695720ab883c338fdc3df5da394bb
got e7f3481a23600c969a3cdf9bf793e8239546c1d1
got 1317788c088c3f621f83ceae657e0d1f6f34af54
got 7881993b68ead8678545516fa8e04f8919569b8e
got 44cd19e162f9ff976df475bccecd63a42e04a244
Getting pack list for http://homepage.ntlworld.com/cmarinas/stgit.git/
got 694ea0c23cc88422d923104b04832df48865dae6
got 938ce9bb5812cac4d0902ae6f87a276d51a58cd9
got 9534f1c94a19e5521bbb7a5664d587400eb55905
got fc9c5a73a29673f06b683a85134531ad6d9520ea
got f80bef4918840e4290f03f291d8b4dbb98b12d80
error: Unable to find adad46f365219e9bcc1a212826ca65eaac09729c under
http://homepage.ntlworld.com/cmarinas/stgit.git/
Cannot obtain needed blob adad46f365219e9bcc1a212826ca65eaac09729c
while processing commit 8847a11b3bbf5406f37a360e5466f0e392c56383.
Waiting for
http://homepage.ntlworld.com/cmarinas/stgit.git/objects/d5/68cd60c5759cfd=
84d4148f3c3d5bf9f5b85d41
/usr/bin/git-clone: line 29: 13000 Naruszenie ochrony pami=C4=99ci   git-=
http-fetch
-v -a -w "$tname" "$name" "$1/"

(Naruszenie ochrony pami=C4=99ci =3D Segmentation fault)

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enigD4464707F867A7233A3270DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEMqjUlUMEU9HxC6IRAl7cAJ9yZcZIBeiKKCF4asEQsIppVush5QCffr78
NwAoUyz08aBTKzCI88+pG3s=
=MFOG
-----END PGP SIGNATURE-----

--------------enigD4464707F867A7233A3270DE--
