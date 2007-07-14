From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] git-svn init/clone --stdlayout option to default-init
	trunk/tags/branches
Date: Sat, 14 Jul 2007 14:04:50 +0200
Message-ID: <20070714120450.GA21890@piper.oerlikon.madduck.net>
References: <1184405128718-git-send-email-madduck@madduck.net> <20070714105010.GA14842@muzzle> <20070714110431.GA3854@piper.oerlikon.madduck.net> <20070714113435.GC14842@muzzle>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 14:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9gN3-0001ga-BO
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 14:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbXGNMEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 08:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756535AbXGNMEx
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 08:04:53 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:48176 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbXGNMEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 08:04:52 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id BB8C3895D73
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 14:04:51 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 19740-04 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 14:04:51 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 87B05895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 14:04:51 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 1BCF09F121
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 14:04:51 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E0BEA43FC; Sat, 14 Jul 2007 14:04:50 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070714113435.GC14842@muzzle>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52473>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Eric Wong <normalperson@yhbt.net> [2007.07.14.1334 +0200]:
> I have highlighting search set in my editor (vim :set hls)
> and usually just search for spaces vs tabs to make sure I'm clean.

Try:

  :se lcs=3Dtab:>-,trail,-

  augroup listinsert
    autocmd InsertEnter * set nolist
    autocmd InsertLeave * set list
  augroup end

> Of course, maintaining a consistent whitespace style helps a *lot*
> with the git/Linux patch exchange development style because it
> avoids needless patch application conflicts that arise from
> whitespace differences.

Using tabs also makes it impossible to X-cut-paste patches from
emails; you *have* to use git-am and/or a temporary file, which
i don't like at all.

But thanks for the explanation.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
Most Intelligent Customers Realise Our Software Only Fools Them.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmLviIgvIgzMMSnURAmacAJ9PgYvAXDbPMbhhU0aUg0O4zfZfWgCdHX2z
0pw+2/S3uY3itdTnfPy6eAs=
=5tHy
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
