From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Mon, 29 May 2006 22:31:45 -0700
Message-ID: <447BD8C1.6090402@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>	 <44720C66.6040304@gentoo.org>	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>	 <447215D4.5020403@gentoo.org>	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>	 <447B7669.8050805@gentoo.org> <46a038f90605291719r292269bct61bf2817a9791e3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB7724E4C276BADA583C8C4BD"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 30 07:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkwpt-0004O1-7p
	for gcvg-git@gmane.org; Tue, 30 May 2006 07:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWE3Fbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 01:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWE3Fbz
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 01:31:55 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:62160 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1750959AbWE3Fby (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 01:31:54 -0400
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id CCD6164514;
	Tue, 30 May 2006 05:31:53 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605291719r292269bct61bf2817a9791e3d@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21015>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7724E4C276BADA583C8C4BD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Martin Langhoff wrote:
> On 5/30/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
>> Looking closer, I see that the memory suckers do appear to be git, fro=
m
>> dmesg:
>>
>> Out of Memory: Kill process 17230 (git-repack) score 97207 and childre=
n.
>> Out of memory: Killed process 17231 (git-rev-list).
>=20
> That would mean that you do have Linus' patch then. Grep cvsimport for
> repack and remove the -a -- and consider using his recent patch to
> rev-list.

You certainly would think so, and I did as well, but available evidence
indicates otherwise. I'm not sure how the repack got in there.

donnie@supernova ~ $ type git-cvsimport
git-cvsimport is /usr/bin/git-cvsimport
donnie@supernova ~ $ grep repack /usr/bin/git-cvsimport
donnie@supernova ~ $

All I can think of is that I somehow OOM'd when I manually ran a repack
and didn't notice it. But that should've at least made me unable to
resume the cvsimport process, which happily kept chugging along later on.=


> My dmesg talks about an earlier cvs segfault. Nasty tree you have here
> -- it's breaking all sorts of things... and teaching us a thing or two
> about the import process.
>=20
>> Committed patch 249100 (origin 2005-08-20 05:05:58)
>=20
> Hmmm? How can you be at patch 249100 and still be a good year ahead of
> me? Have you told cvsps to cut off old history?

Nope. I ran the exact cvsps flags you posted earlier to create it.

Thanks,
Donnie


--------------enigB7724E4C276BADA583C8C4BD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEe9jEXVaO67S1rtsRAkFpAKCFCrZQMtqs0l2utFGwL0hXU0xbfACfb1xM
xeVZXvO9cNvrIX1pmU/Ytuc=
=G/96
-----END PGP SIGNATURE-----

--------------enigB7724E4C276BADA583C8C4BD--
