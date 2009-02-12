From: martin f krafft <madduck@madduck.net>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 10:32:27 +0100
Message-ID: <20090212093227.GC20248@piper.oerlikon.madduck.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 10:34:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXXxW-0006mc-QO
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 10:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbZBLJcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 04:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755720AbZBLJcr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 04:32:47 -0500
Received: from clegg.madduck.net ([193.242.105.96]:53693 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690AbZBLJcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 04:32:46 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 883FD1D409B;
	Thu, 12 Feb 2009 10:32:29 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 622AE9F13D;
	Thu, 12 Feb 2009 10:32:28 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E65514454; Thu, 12 Feb 2009 10:32:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090212092558.GB21074@skywalker>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8981/Thu Feb 12 01:28:11 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109590>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> [2009.02.12.=
1025 +0100]:
> Latest git and topgit. Moving to git version v1.6.1.3 fixed the issue.
> I can reproduce the problem on any test repo. Just do a tg update after
> committing something in the dependent branch.

This is not helpful. Please provide a complete transcript of
a session reproducing the problem.

I can't:

piper:~|master|.tmp/cdt.GydvBgiR% echo foo > bar                           =
                      #10002
piper:~|master|.tmp/cdt.GydvBgiR% giti                                     =
                      #10003
Initialized empty Git repository in /home/madduck/.tmp/cdt.GydvBgiR/.git/
Created initial commit 0f189f3: initial checkin
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar
piper:~/.tmp/cdt.GydvBgiR|master|% tg create test                          =
                      #10004
tg: Automatically marking dependency on master
tg: Creating test base from master...
Switched to a new branch "test"
tg: Topic branch test set up. Please fill .topmsg now and make initial comm=
it.
tg: To abort: git rm -f .top* && git checkout master && tg delete test
cached/staged changes:
 .topdeps |    1 +
 .topmsg  |    6 ++++++
piper:~/.tmp/cdt.GydvBgiR|master|% git commit -minit                       =
                      #10005
Created commit d49ea41: init
 2 files changed, 7 insertions(+), 0 deletions(-)
 create mode 100644 .topdeps
 create mode 100644 .topmsg
piper:~/.tmp/cdt.GydvBgiR|test|% echo bar >> bar                           =
                      #10006
changes on filesystem:
 bar |    1 +
piper:~/.tmp/cdt.GydvBgiR|test|% git add bar                               =
                      #10007
cached/staged changes:
 bar |    1 +
piper:~/.tmp/cdt.GydvBgiR|test|% git commit -m'append'                     =
                      #10008
Created commit e85457e: append
 1 files changed, 1 insertions(+), 0 deletions(-)
piper:~/.tmp/cdt.GydvBgiR|test|% tg update                                 =
                      #10009
tg: The base is up-to-date.
tg: The test head is up-to-date wrt. the base.
piper:~/.tmp/cdt.GydvBgiR|test|% git --version                             =
                      #10010
git version 1.6.0.2
piper:~/.tmp/cdt.GydvBgiR|test|% tg --version                              =
                      #10011
Unknown subcommand: --version
TopGit v0.5 - A different patch queue manager
Usage: tg [-r REMOTE] (create|delete|depend|export|import|info|mail|patch|r=
emote|summary|update|help) ...

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
this space intentionally left blank.
=20
spamtraps: madduck.bogus@madduck.net

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmT7KsACgkQIgvIgzMMSnUXBwCbBbvBDqWUMMcJSKGCJqE8P5V9
srsAnRhiD+b6tSaEp5RaEGpA1VKWefvJ
=mcDk
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
