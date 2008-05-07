From: martin f krafft <madduck@madduck.net>
Subject: Re: inconsistent detached worktree handling: several bugs
Date: Wed, 7 May 2008 19:06:37 +0100
Message-ID: <20080507180637.GA2282@lapse.madduck.net>
References: <20080505160643.GA28318@lapse.madduck.net> <8aa486160805070115k676b03a6s59d3a74d48d44254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 20:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jto3D-0004Rb-Ew
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 20:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861AbYEGSGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 14:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbYEGSGq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 14:06:46 -0400
Received: from clegg.madduck.net ([82.197.162.59]:42689 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbYEGSGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 14:06:44 -0400
Received: from lapse.madduck.net (chiu.ifi.unizh.ch [130.60.75.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 4D0BCA802D;
	Wed,  7 May 2008 20:06:33 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id CC13B4FD87; Wed,  7 May 2008 19:06:37 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <8aa486160805070115k676b03a6s59d3a74d48d44254@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7046/Wed May  7 05:35:44 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81471>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Santi B=E9jar <sbejar@gmail.com> [2008.05.07.0915 +0100]:
> I don't know if it resolves all the issues, but:
>=20
> - If run outside of the working copy =3D> equivalent to run it from the
> top of the wc.
>   (for the normal case it just fails)

This is not what the output of git-status suggests:

lapse:~|master|.fgits/zsh.git% git status                                #1=
,801
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   ../../.zsh/zshrc/30_aliases
#
no changes added to commit (use "git add" and/or "git commit -a")

If, what you said were the case, it'd be .zsh/zshrc/30_aliases.
=2E./.. is the setting of core.worktree.

> - It is not recommended (supported?) to have the repository inside
> the working directory (unless it is .git, of course)

Why not?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"'oh, that was easy,' says Man, and for an encore goes on to prove
 that black is white and gets himself killed on the next zebra
 crossing."
            -- douglas adams, "the hitchhiker's guide to the galaxy"
=20
spamtraps: madduck.bogus@madduck.net

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIIe+tIgvIgzMMSnURAvhqAJ9NPHr9wWOVZMh6W4/VSknoXKLSAQCfaUIj
7S12y55fhNqN2bHNL3Edio8=
=qwvx
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
