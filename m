From: =?UTF-8?B?TWF0ZXVzeiBKb8WEY3p5aw==?= <mat.jonczyk@o2.pl>
Subject: [Feature request] git add -i should have option for showing more
 context
Date: Tue, 05 Aug 2014 20:29:58 +0200
Message-ID: <53E122A6.8040608@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 21:10:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEk7w-0003Fi-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 21:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbaHETKY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2014 15:10:24 -0400
Received: from tur.go2.pl ([193.17.41.50]:58510 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558AbaHETKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 15:10:22 -0400
X-Greylist: delayed 2417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Aug 2014 15:10:22 EDT
Received: from moh3-ve3.go2.pl (moh3-ve3.go2.pl [193.17.41.87])
	by tur.go2.pl (Postfix) with ESMTP id 6548BA9033C
	for <git@vger.kernel.org>; Tue,  5 Aug 2014 20:30:40 +0200 (CEST)
Received: from moh3-ve3.go2.pl (unknown [10.0.0.158])
	by moh3-ve3.go2.pl (Postfix) with ESMTP id 09BBFB5A78B
	for <git@vger.kernel.org>; Tue,  5 Aug 2014 20:30:01 +0200 (CEST)
Received: from unknown (unknown [10.0.0.42])
	by moh3-ve3.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Tue,  5 Aug 2014 20:30:01 +0200 (CEST)
Received: from asd224.neoplus.adsl.tpnet.pl [83.26.215.224]
	by poczta.o2.pl with ESMTP id lWWAIx;
	Tue, 05 Aug 2014 20:30:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
OpenPGP: id=2C64C488
X-O2-Trust: 2, 68
X-O2-SPF: notchecked
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254823>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,
In git add -i when staging the modifications piecemail by patching ther=
e
should be a command for showing more context.
It can be sometimes difficult to determine whether any hunk should be s=
taged
without refering to more source code.


As a command I mean a choice in the following list:
Stage this hunk [y,n,q,a,d,/,e,?]? ?
y - stage this hunk
n - do not stage this hunk
q - quit; do not stage this hunk nor any of the remaining ones
a - stage this hunk and all later hunks in the file
d - do not stage this hunk nor any of the later hunks in the file
g - select a hunk to go to
/ - search for a hunk matching the given regex
j - leave this hunk undecided, see next undecided hunk
J - leave this hunk undecided, see next hunk
k - leave this hunk undecided, see previous undecided hunk
K - leave this hunk undecided, see previous hunk
s - split the current hunk into smaller hunks
e - manually edit the current hunk
? - print help


- --=20
Pozdrawiam,
Mateusz Jo=C5=84czyk
AEI, Informatyka, Semestr 3 Magisterskich, BDiIS

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: My public key: 0x2C64C488 on hkp://pool.sks-keyservers.net

iQEcBAEBAgAGBQJT4SKmAAoJELLT9LcsZMSI+WMH/1DoOuBFsDLjDF9zMFmeGbGf
bYDEgpMgCWVHT+v9YMoY41ZMLOABni+7E4yvym/x5mO00Q4LPsXfDTNeHC7LEcgJ
uDLS9Lx3A3eXoqZFsIsXKY6+SHr8RU8UJRdppVakMq2novitzJrAjt3HZUO5ai8n
bmWIF3HBNZcKHfVQSGuBCNB1ZWxlKv7gRPl/RFeCv+Z9kiYKUO/TXMEya3mxXFd3
3u7XEJw5G4KyN7ySVH6kRKcCIp6L0cRhKtyuFILs7EMO5e59HYr2JKpParnc0CXd
gU1rVCwYW2GL6cDekabWoffxuKSCTg74IeI5Gu0oTyYeK3N93yPJudGgTLMqHGM=3D
=3DKl4N
-----END PGP SIGNATURE-----
