From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Tue, 30 May 2006 19:49:33 -0700
Message-ID: <447D043D.1020609@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>	 <447215D4.5020403@gentoo.org>	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>	 <447B7669.8050805@gentoo.org>	 <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org> <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig268FCFECD5591FBF531B52D6"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alec Warner <antarus@gentoo.org>
X-From: git-owner@vger.kernel.org Wed May 31 04:49:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlGmJ-00054C-9J
	for gcvg-git@gmane.org; Wed, 31 May 2006 04:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWEaCto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 22:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWEaCto
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 22:49:44 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:38034 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1751563AbWEaCtn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 22:49:43 -0400
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 042B1642C0;
	Wed, 31 May 2006 02:49:42 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21055>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig268FCFECD5591FBF531B52D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Martin Langhoff wrote:
> On 5/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> That gentoo repo has a lot of "duplicate" commits that cvsps will mark=
 as
>> two separate commits because there's one commit for the files, and one=

>> commit for whatever the "Manifest" file is. I wonder if those commits
>> should generally be merged or something.
>>
>> That said, things like that are most easily fixed as a git->git update=

>> (along with adding name translation), which can avoid re-writing the
>> trees.
>=20
> Yep, large projects often have good reasons to run custom imports,
> merging certain commits, rewriting log messages (like the X.org guys
> were doing). It can be done at the cvsimport stage or later -- I think
> Pasky has a rewritehistory tool hidden somewhere in Cogito, but I
> haven't used it.

We've got a guy who got a Summer of Code project to work on CVS
migration, so this could be something along his lines.

Thanks,
Donnie


--------------enig268FCFECD5591FBF531B52D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEfQRAXVaO67S1rtsRAl5/AJ9k6LmNuR+jLhg+o2mQNH/nFA60iACfWbvT
ft5lVKRxm3LkcEgRG+/1zcY=
=hPOm
-----END PGP SIGNATURE-----

--------------enig268FCFECD5591FBF531B52D6--
