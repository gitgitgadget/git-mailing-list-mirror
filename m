From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: StGIT 0.12.1: pulling up to specific commit (tag)
Date: Thu, 8 Mar 2007 11:23:08 +0300
Message-ID: <200703081123.09281.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5386361.qlMOLclkP9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 08 09:24:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPDvB-0003qk-2k
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 09:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbXCHIYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 03:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbXCHIYR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 03:24:17 -0500
Received: from mx28.mail.ru ([194.67.23.67]:9180 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030190AbXCHIYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 03:24:17 -0500
Received: from mx27.mail.ru (mx27.mail.ru [194.67.23.64])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 3CC2F769E13
	for <git@vger.kernel.org>; Thu,  8 Mar 2007 11:23:32 +0300 (MSK)
Received: from [85.141.127.19] (port=25091 helo=cooker.local)
	by mx27.mail.ru with asmtp 
	id 1HPDu2-000HHL-00; Thu, 08 Mar 2007 11:23:10 +0300
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41716>

--nextPart5386361.qlMOLclkP9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

After update to 0.12 I am a bit lost how to do it.

I have local branch for kernel tree that contains several patches. I do not=
=20
want this tree to be up-to-date with the latest commits upstream, rather I=
=20
need it on (sub-)version basis. But there is apparently no way to say in=20
stgit "please pull up to specific commit".

What I did before 0.12 was

git branch b2.6.21-rc3 v2.6.21-rc3
stg pull . b2.6.21-rc3

Now "stg pull" no more accepts branch name; but I cannot figure how to to t=
he=20
same using git config. I have:

branch.cooker.merge=3Dstgit
branch.cooker.remote=3Dstgit

then I do

git branch stgit v2.6.21-rc3
stg pull .

This always results in "up to date" message and nothing is actually merged =
in=20
current branch. But if I do

stg pop -a
git pull . stgit

then changes *are* merged as expected

So for now I have a workaround, but it is rather awkward. May be I am doing=
 it=20
the wrong way and I should just do "stg pull; git reset" but I had bad=20
experience with mixing stgit and git tree/index manipulation commands in th=
e=20
past.

TIA

=2Dandrey

--nextPart5386361.qlMOLclkP9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBF78ftR6LMutpd94wRAmhPAKDTmE5fpiimQzsEEEXhk+jclhUAgQCcCdC4
6KFSYjXaDNqtqk7cQiKx7Lk=
=ceLQ
-----END PGP SIGNATURE-----

--nextPart5386361.qlMOLclkP9--
