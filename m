From: Gavin Kistner <gkistner@nvidia.com>
Subject: unpacker error on push
Date: Wed, 16 Jun 2010 08:36:51 -0700
Message-ID: <C52ABCE5-15AF-4988-9496-DFA6D6331A59@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 16 17:43:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOuli-0004gF-8Y
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 17:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240Ab0FPPnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jun 2010 11:43:06 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:13468 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136Ab0FPPnF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 11:43:05 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jun 2010 11:43:05 EDT
Received: from hqnvupgp03.nvidia.com (Not Verified[172.17.102.18]) by hqemgate03.nvidia.com
	id <B4c18f02c0001>; Wed, 16 Jun 2010 08:39:24 -0700
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp03.nvidia.com (PGP Universal service);
  Wed, 16 Jun 2010 08:36:53 -0700
X-PGP-Universal: processed;
	by hqnvupgp03.nvidia.com on Wed, 16 Jun 2010 08:36:53 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.12]) by hqemhub02.nvidia.com
 ([172.17.98.27]) with mapi; Wed, 16 Jun 2010 08:36:53 -0700
Thread-Topic: unpacker error on push
Thread-Index: AcsNab5n0fshBypjRjaVUSaZLXLQ3w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149262>

Local: OS X 10.6.3, git 1.7.1
Remote: Ubuntu Lucid, git 1.7.0.4

How can I fix whatever is broken so that I can push again, and=97more i=
mportantly=97get the important changes I made last night over to the re=
mote, by hook or by crook?

-_-_-_-_-_-_-_-_-_-_
On the local machine
-_-_-_-_-_-_-_-_-_-_

Slim2:bugbot3 phrogz$ git push
Counting objects: 70, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (31/31), done.
Writing objects: 100% (40/40), 26.91 KiB, done.
Total 40 (delta 11), reused 37 (delta 8)
error: unpack failed: unpack-objects abnormal exit
To git://10.20.16.110/bugbot3.git
 ! [remote rejected] planning -> planning (n/a (unpacker error))
error: failed to push some refs to 'git://10.20.16.110/bugbot3.git'


Slim2:bugbot3 phrogz$ cat .git/config=20
[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
	ignorecase =3D true
[remote "origin"]
	url =3D git://10.20.16.110/bugbot3.git
	fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master


Slim2:bugbot3 phrogz$ git status
# On branch planning
nothing to commit (working directory clean)


Slim2:bugbot3 phrogz$ git pull origin planning
=46rom git://10.20.16.110/bugbot3
 * branch            planning   -> FETCH_HEAD
Already up-to-date.


Slim2:bugbot3 phrogz$ git fsck --full
(no output)


-_-_-_-_-_-_-_-_-_-_
On the remote
-_-_-_-_-_-_-_-_-_-_
phrogz@gitbox:/pub/scm/bugbot3$ git config -l
user.name=3DGavin Kistner
user.email=3D!@phrogz.net
core.repositoryformatversion=3D0
core.filemode=3Dfalse
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
core.ignorecase=3Dtrue


phrogz@gitbox:/pub/scm/bugbot3$ git fsck --full
(no output)

-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
