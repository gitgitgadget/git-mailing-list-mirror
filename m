From: martin f krafft <madduck@debian.org>
Subject: TopGit: ensure worktree (was: [TopGit PATCH] Check for help
	invocation before setup)
Date: Fri, 21 Nov 2008 13:06:09 +0100
Organization: The Debian project
Message-ID: <20081121120609.GA10326@piper.oerlikon.madduck.net>
References: <1227110623-4474-1-git-send-email-madduck@debian.org> <1227110623-4474-2-git-send-email-madduck@debian.org> <36ca99e90811210119s215513a8m7c12c8d55fd54d70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Cc: git@vger.kernel.org, petr baudis <pasky@suse.cz>,
	501982@bugs.debian.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3UnX-00062H-6D
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbYKUMG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbYKUMG2
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:06:28 -0500
Received: from clegg.madduck.net ([193.242.105.96]:34063 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYKUMG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:06:27 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 78F6D1D40A9;
	Fri, 21 Nov 2008 13:06:10 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 7E4B89F355;
	Fri, 21 Nov 2008 13:06:09 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 3F43145F5; Fri, 21 Nov 2008 13:06:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <36ca99e90811210119s215513a8m7c12c8d55fd54d70@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8658/Fri Nov 21 11:54:22 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101515>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think you wanted to CC Petr, not Junio. It's also useful to CC
Debian bugs if you know of them. :)

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.11.21.1019 +0100=
]:
> I really second this. Plus, I think its crucial to check that we are
> not inside the .git directory before setting up topgit. Because git
> rev-parse --git-dir only works in the top .git dir, not deeper (i.e.
> inside .git/refs) and will always return ".".
>=20
> 	$(git rev-parse --is-inside-work-tree) ||
> 		die "Not in a git working directory"

Thanks, noted. I am still working on this patch, since
evaluating $argv/checking for --help at this early stage basically
requires a rewrite of the CLI parsing, ideally using POSIX getopt or
something similar, which takes much of the load away.

Anyway, Patch for your proposal forthcoming.

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
(a)bort, (r)etry, (p)retend this never happened

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkmpDAACgkQIgvIgzMMSnUSKgCghXE+J9KegZ03tetnM3TIcyeM
zn0AoJmYVzh/Kjxk7NFEpQw7USR0daXy
=xl31
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
