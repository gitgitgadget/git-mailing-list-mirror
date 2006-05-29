From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Mon, 29 May 2006 15:32:09 -0700
Message-ID: <447B7669.8050805@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>	 <44720C66.6040304@gentoo.org>	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>	 <447215D4.5020403@gentoo.org>	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org> <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46724435B3CEAE6CAE4DE309"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 30 00:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkqHd-0000w7-K3
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWE2WcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWE2WcS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:32:18 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:57773 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1751442AbWE2WcS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 18:32:18 -0400
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 5537B644F0;
	Mon, 29 May 2006 22:32:17 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20991>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46724435B3CEAE6CAE4DE309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Martin Langhoff wrote:
> On 5/30/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
>> Finally hit an OOM sometime in the past day (yep, a week later) =3D\. =
Not
>> sure whether it was cvsimport or cvs. Anyone else had more luck?
>=20
> It seemed like it had finished on the machine I was running it, and I
> assumed it was alright in yours too. Looking closer it only made it
> till April 2004 -- but it may have been killed by a sysadmin, the
> captured log talks about 'signal 9', I have no idea what the OOM
> sends.

Looking closer, I see that the memory suckers do appear to be git, from
dmesg:

Out of Memory: Kill process 17230 (git-repack) score 97207 and children.
Out of memory: Killed process 17231 (git-rev-list).

Just ends like this:

Tree ID 2cc632e5e1d3a430a2cc891bf33c4a12f19a4d0e
Parent ID ad92d7073a52458e0581633bbd8ccbbec838d9e6
Committed patch 249100 (origin 2005-08-20 05:05:58)
Commit ID 28941f00d714f57ab49f1fd725d1c3ce8a5d0b93
Fetching sys-kernel/ck-sources/ChangeLog   v 1.113
Update sys-kernel/ck-sources/ChangeLog: 25425 bytes
Fetching sys-kernel/ck-sources/Manifest   v 1.164
Update sys-kernel/ck-sources/Manifest: 252 bytes
Delete sys-kernel/ck-sources/ck-sources-2.6.12_p5-r1.ebuild
Fetching sys-kernel/ck-sources/ck-sources-2.6.12_p6.ebuild   v 1.1
New sys-kernel/ck-sources/ck-sources-2.6.12_p6.ebuild: 1438 bytes
Delete sys-kernel/ck-sources/files/digest-ck-sources-2.6.12_p5-r1
Fetching sys-kernel/ck-sources/files/digest-ck-sources-2.6.12_p6   v 1.1
New sys-kernel/ck-sources/files/digest-ck-sources-2.6.12_p6: 279 bytes
Can't fork at /usr/bin/git-cvsimport line 592, <CVS> line 3810053.
cat: write error: Broken pipe

> It had done 285070 of 343822 patchsets.
>=20
> Have you dropped the -a from the git-repack invocation? That should
> help. Try also Linus' patch for git-rev-list. The other thing hurting
> us is that the commits are _huge_. I wonder how you guys were managing
> this with CVS. Now _this_ explains why cvsimport grows humongous.

I wasn't running with a version that did repacks; I just suspended the
cvsimport a couple of times and ran a repack manually.

> I'll try to rework the commit loop so that we don't need to hold all
> the filenames in memory. It seems to be choking with the commits after
> April 2004. But that will have to wait till tonight.

Thanks,
Donnie


--------------enig46724435B3CEAE6CAE4DE309
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEe3ZrXVaO67S1rtsRAueXAJ9v4VEQNBBSMN3/vslh1XEghhuEBQCg9guF
cyROa3vGmbcsdZU0WR2XVs4=
=q/gu
-----END PGP SIGNATURE-----

--------------enig46724435B3CEAE6CAE4DE309--
