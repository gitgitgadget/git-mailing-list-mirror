From: Baoyin <shanbaoyin@gmail.com>
Subject: HELP!! "git push"error!
Date: Mon, 8 Aug 2011 01:05:49 +0000 (UTC)
Message-ID: <loom.20110808T025926-500@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 03:10:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqEMD-0002dy-Ia
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 03:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab1HHBKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 21:10:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:60718 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab1HHBKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 21:10:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QqEM0-0002bD-9N
	for git@vger.kernel.org; Mon, 08 Aug 2011 03:10:05 +0200
Received: from 210.13.71.68 ([210.13.71.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 03:10:04 +0200
Received: from shanbaoyin by 210.13.71.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 03:10:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 210.13.71.68 (Opera/9.80 (Windows NT 6.1; U; en) Presto/2.9.168 Version/11.50)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178930>

Hi, all

Git reports error when I did "git push", following is part of error mes=
sage:

error: packfile ./objects/pack/
pack-54b383e85f2e93a2c2ed4bf439808ecebd23986a.pack cannot be accessed
error: packfile ./objects/pack/pack-
a2105c2321aaf311826fe8148d56528536a3e38a.pack cannot be accessed
error: refs/changes/87/6687/1 does not point to a valid object!
error: packfile ./objects/pack/pack-
ce47b0d7b5fba35cc7764bfce061e673a401d775.pack cannot be accessed
error: refs/changes/87/7987/3 does not point to a valid object!
error: packfile ./objects/pack/
pack-25c5e425895d1f9333aa02a1ee0050de4ede5189.pack cannot be accessed
error: refs/changes/87/8687/1 does not point to a valid object!
error: packfile ./objects/pack/
pack-6eaaf27b51be41b1301a0e921d6609d05304d9a3.pack cannot be accessed
error: refs/changes/87/8987/1 does not point to a valid object!
error: packfile ./objects/pack/
pack-2064289922b9f0f403262adb94ad932c2684639c.pack cannot be accessed
error: refs/changes/87/8987/2 does not point to a valid object!
=2E..........

some error messages show that "error: refs/changes/87/8987/1 does not p=
oint to =20
a valid object! ", but  refs/changes/87/8987/1 dose point to a valid co=
mmit=20
"3cbba537".=20
Then I did "git show 3cbba537", result is ok, no error.=20
I don't know why there is conflict.

I also did "git fsck" on git server, git reports errors too, following =
is part=20
of error message:

error: packfile ./objects/pack/pack-
 d8c9cd1bdfdd458b7a53977c3544a54a26de8d30.pack cannot be accessed
 missing tree e2aa6890223d9cc186b53764752bc3531650aa1f
 error: packfile ./objects/pack/
 pack-29df930a4d5cae218ecd1a1bed6b1a662dec3253.pack cannot be accessed
 error: packfile ./objects/pack/pack-
d8c9cd1bdfdd458b7a53977c3544a54a26de8d30.pack cannot be accessed
 broken link from commit 1fad8edbaf7651e924681550da36e29419910c00
 to tree e2aa6890223d9cc186b53764752bc3531650aa1f
 error: packfile ./objects/pack/pack-
f62ed9d45bd82e735758a2fa750e2432734383e5.pack cannot be accessed
 missing tree 53ad32be22811bf4c351b3ec911905bbda016346
error: packfile ./objects/pack/pack-
f0724f223ec7d0501dcb9d350304e893ec06fb4b.pack cannot be accessed
error: packfile ./objects/pack/pack-
d17aa5efdbed08d0a59ceefc942e31d43694dfb4.pack cannot be accessed
 error: packfile ./objects/pack/
 pack-04644913e5cb6c9663e54c9e7fd4385182a87b15.pack cannot be accessed
 missing tree 6eaf3d97dbd2ce915c9b3ba83d9810e052016b6b
error: packfile ./objects/pack/pack-
ac7c3cd6124f4329159da2358690d34ff0182bbc.pack cannot be accessed
 missing tree d3b0de15d4ff4484195ec7342a1ffdb3ba6ddfc0
 dangling tree 03b18cf447ca33bd2d8a3ff765db03a469c0007c
 error: packfile ./objects/pack/
 pack-63e3e1673dc7d59c5ff90615fbf82f10512284e4.pack cannot be accessed
 missing tree 25b1d39e3736ca5a2ea9b766b549c615a8d19f84

error message shows that some objects missing, but they do exist. what'=
s the=20
problem?????

PS. merge patches by gerrit is work, I just can not "git push" to remot=
e=20
repository directly. it's takes me too much time to maintain four branc=
hes =20
by cherry-pick each patch to local, use =E2=80=9Cgit-commit --amend=E2=80=
=9D to modify and push=20
to gerrit again.
