From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 05 Oct 2010 10:41:27 +0100
Message-ID: <87aamtq8mw.fsf@fox.patthoyts.tk>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
	<201010041851.46838.ComputerDruid@gmail.com>
	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
	<201010041959.48336.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephan Hugel <urschrei@gmail.com>, git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 11:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P341o-000722-FR
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 11:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334Ab0JEJlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 05:41:32 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:52747 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754619Ab0JEJlb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 05:41:31 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P341Z-0004hD-V0; Tue, 05 Oct 2010 10:41:30 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P341Y-0000Ci-AX; Tue, 05 Oct 2010 10:41:28 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 751E025205; Tue,  5 Oct 2010 10:41:27 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <201010041959.48336.ComputerDruid@gmail.com> (Daniel Johnson's
	message of "Mon, 4 Oct 2010 19:59:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158181>

>On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:=20
>> Daniel,
>> Those are the exact steps I'm using.
>>=20
>> When I run tag -v on existing tags, I don't see the
>>=20
>> -----BEGIN PGP MESSAGE-----
>> Version: GnuPG v1.4.9 (Darwin)
>>=20
>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
>> yZeXw/EddYrfdad/VvOrL1o=3D
>> =3D/0PJ
>> -----END PGP MESSAGE=97=97
>>=20
>> block. It's only present on tags created using the current version.
>> I've also just upgraded to GnuPG 1.4.10, but the result is the same.
>> I'm not sure how else I can determine where the problem arises; I'm
>> using the git and GnuPG versions for OS X built by homebrew, and Gnu=
PG
>> is happy to use the same key for en/decryption and signing. I've als=
o
>> verified that none of the subkeys are expired, and that the trust db
>> is OK.

When I try this using 1.7.3.1 the tag signature header says "PGP
SIGNATURE" and not "PGP MESSAGE". I wonder if you just have some odd
gpg settings.

C:\src\git-gui>git version
git version 1.7.2.3.msysgit.0

C:\src\git-gui>git tag -s -a -m "test" test1

You need a passphrase to unlock the secret key for
user: "Pat Thoyts <patthoyts@googlemail.com>"
1024-bit RSA key, ID F084E489, created 1995-04-11


C:\src\git-gui>git cat-file tag test1
object 00e9de72c8f9b7c048bb56a59be9567d69dc1e01
type commit
tag test1
tagger Pat Thoyts <patthoyts@users.sourceforge.net> 1286268190 +0100

test
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)

iQCVAwUATKrlHmB90JXwhOSJAQJx2QP+OVRpcPyGgi2HF3OyOQ7immsMHpXb4ySx
nhvt7iWEfMlzm/8/+LlW6NnYkcTkAW3g3pgECXTAzXgUqhj9ectrprLg5XFT717O
SHJ4qyai08stlC86kHVLyYhdi2C96rgtN9+63CQUl4R7Ofv/l+IRE22IYES5942Z
LZgpbtPyp7w=3D
=3DOydf
-----END PGP SIGNATURE-----

C:\src\git-gui>git verify-tag test1
gpg: Signature made 10/05/10 09:43:10 using RSA key ID F084E489
gpg: Good signature from "Pat Thoyts <patthoyts@googlemail.com>"
gpg:                 aka "Pat Thoyts <patthoyts@users.sourceforge.net>"

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
