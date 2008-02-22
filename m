From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Improve documentation for git-sh-setup.
Date: Fri, 22 Feb 2008 10:35:58 +0100
Message-ID: <20080222093558.GC29114@artemis.madism.org>
References: <20080221230101.27644.49229.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="kVXhAStRUZ/+rrGn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:36:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSUKe-00066E-9J
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 10:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYBVJgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 04:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYBVJgD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 04:36:03 -0500
Received: from pan.madism.org ([88.191.52.104]:41769 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbYBVJgA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 04:36:00 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D6C6011D5F;
	Fri, 22 Feb 2008 10:35:58 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 68383533368; Fri, 22 Feb 2008 10:35:58 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080221230101.27644.49229.stgit@gandelf.nowhere.earth>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74710>


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2008 at 11:01:28PM +0000, Yann Dirson wrote:
> Signed-off-by: Yann Dirson <ydirson@altern.org>
> Cc: Pierre Habouzit <madcoder@debian.org>


> +If the constraints imposed by the use of `git rev-parse` do not fit
> +for a particular tool, `USAGE` (and `LONG_USAGE`, if any) can be used
> +to define message given by `usage()` shell function; no command-line
> +pre-processing occurs, the script has entire control over it.

  Actually, new scripts should be written using git rev-parse if
possible, the USAGE/LONG_USAGE were there _before_ and I'd like to call
them the deprecated interface if other git hackers don't mind.

  git rev-parse --parseopt gives consistency in how git parses options,
and it's A Good Thing=E2=84=A2

  That makes me think that git-sh-setup(1) use should be documented in
gitcli(5), maybe even included, and git-sh-setup(1) should *definitely*
link to gitcli(5). We wondered where to link gitcli from, this is
definitely the place !

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHvpd+vGr7W6HudhwRAjNWAKCCgq1lIoLJgmOesuE/gWDddsdh0gCcDcDB
r/OHGuYffsXbOa630ZFU85I=
=wLej
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
