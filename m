From: martin f krafft <madduck@debian.org>
Subject: Re: TopGit: ensure worktree (was: [TopGit PATCH] Check for help
	invocation before setup)
Date: Fri, 21 Nov 2008 13:23:47 +0100
Organization: The Debian project
Message-ID: <20081121122347.GA19916@piper.oerlikon.madduck.net>
References: <1227110623-4474-1-git-send-email-madduck@debian.org> <1227110623-4474-2-git-send-email-madduck@debian.org> <36ca99e90811210119s215513a8m7c12c8d55fd54d70@mail.gmail.com> <20081121120609.GA10326@piper.oerlikon.madduck.net> <36ca99e90811210415g7b50c5c1m3185bf19cab104aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: git@vger.kernel.org, petr baudis <pasky@suse.cz>,
	501982@bugs.debian.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3V4i-0003Yr-0o
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYKUMYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYKUMYG
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:24:06 -0500
Received: from clegg.madduck.net ([193.242.105.96]:42088 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbYKUMYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:24:04 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 39D1A1D40A9;
	Fri, 21 Nov 2008 13:23:49 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id ED87D9F355;
	Fri, 21 Nov 2008 13:23:47 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 8B17345F5; Fri, 21 Nov 2008 13:23:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <36ca99e90811210415g7b50c5c1m3185bf19cab104aa@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8658/Fri Nov 21 11:54:22 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101519>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.11.21.1315 +0100=
]:
> I CC'ed Junio, because I think this git rev-parse --git-dir is
> a bug. For example you can try starting git gui inside a .git dir.

You might want to let him know of your intention. :)

> A patch would depent on your --help patch, Because help should
> work everywhere. So either I wait for you or do do it.

No, not depend, but the patch makes the --help situation slightly
worse, for now you cannot call --help inside .git anymore either.
This will force us to fix the --help situation quicker.

I've run out of time, for a while at least. If you want to pick up
the pieces and convert argument parsing to POSIX getopt, or maybe
even better, git-rev-parse --parseopt, then please go for it. You
can find my current TopGit branch at

  http://git.debian.org/?p=3Dcollab-maint/topgit.git;a=3Dshortlog;h=3Drefs/=
heads/fixes/independent-help
  git://git.debian.org/git/collab-maint/topgit.git, branch fixes/independen=
t-help

If you use Debian: debcheckout topgit (requires devscripts 2.10.40)

Thanks,

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"heuristic is computer science jargon for 'doesn't actually work.'"
                                                     -- charlie reiman

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkmqFMACgkQIgvIgzMMSnVwxACeOOJHp6dat4DVmqpI0/zWwlg+
C4cAoIRW+owKEFDmwx84wwpZS0azfklk
=Y64h
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
