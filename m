From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Any way to get complete diff up to a tag?
Date: Thu, 06 May 2010 14:38:31 -0400
Message-ID: <rmiwrvgana0.fsf@fnord.ir.bbn.com>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
	<20100506094212.GB9921@atjola.homenet>
	<A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
	<4BE2BE2C.8050403@viscovery.net>
	<A612847CFE53224C91B23E3A5B48BAC74482E50F03@xmail3.se.axis.com>
	<alpine.LFD.2.00.1005060955000.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 20:46:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA65f-0004kQ-90
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 20:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961Ab0EFSqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 14:46:24 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:56663 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404Ab0EFSqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 14:46:24 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2010 14:46:23 EDT
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id DA229572D; Thu,  6 May 2010 14:38:31 -0400 (EDT)
X-Hashcash: 1:20:100506:git@vger.kernel.org::rYercGBjMf2aKJb6:0000000000000000000000000000000000000000003hti
X-Hashcash: 1:20:100506:torvalds@linux-foundation.org::0ptyKuIIdtICtQRO:000000000000000000000000000000004ooy
X-Hashcash: 1:20:100506:b.steinbrink@gmx.de::rYercGBjMf2aKJb6:0000000000000000000000000000000000000000006dl4
X-Hashcash: 1:20:100506:j.sixt@viscovery.net::rYercGBjMf2aKJb6:000000000000000000000000000000000000000009vYv
X-Hashcash: 1:20:100506:peter.kjellerstedt@axis.com::UB5J8pjIqoSsAJfm:0000000000000000000000000000000000AS+V
In-Reply-To: <alpine.LFD.2.00.1005060955000.901@i5.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 6 May 2010 10:08:39 -0700 (PDT)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146487>

--=-=-=
Content-Transfer-Encoding: quoted-printable


Linus Torvalds <torvalds@linux-foundation.org> writes:

> Well, you don't strictly speaking have to "remember" it, you can always=20
> just re-generate it. The most straightforward way to do that is probably
>
> 	git hash-object -t tree --stdin < /dev/null
>
> although I admit that maybe we could have some syntax for "git diff" that=
=20
> would do the "diff against empty tree" automatically. It does seem to be=
=20
> conceptually a reasonable thing to do.

How about=20

  git diff empty..

as if empty is a tag for the empty revision?  It works for 'git
checkout' already.


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iEYEARECAAYFAkvjDKcACgkQ+vesoDJhHiXZ2ACghtB+LxDu3qa2BI9lGzRlTPAK
ua4An1k9e29AXOEddztRMeC1ehD9/4e1
=D1d3
-----END PGP SIGNATURE-----
--=-=-=--
