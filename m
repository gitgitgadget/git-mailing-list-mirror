From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: That new progress meter
Date: Sat, 03 Nov 2007 13:09:53 +0100
Message-ID: <20071103120953.GC13417@artemis.corp>
References: <Pine.LNX.4.64.0711021836000.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="QRj9sO5tAVLaXnSD";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:10:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHq0-0004Sn-UZ
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbXKCMJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbXKCMJ4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:09:56 -0400
Received: from pan.madism.org ([88.191.52.104]:46376 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbXKCMJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:09:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9D20B27EBA;
	Sat,  3 Nov 2007 13:09:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2F2118550; Sat,  3 Nov 2007 13:09:53 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711021836000.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63246>


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2007 at 06:36:35PM +0000, Johannes Schindelin wrote:
> Hi Nico,
>=20
> that new progress meter sure is amazing and useful!

  I do agree. There seems to be some glitches though, here is how my
output looks after a git fetch I just did on git.git:

    remote: Generating pack...
    remote: Done counting 310 objects.
    remote: Deltifying 310 objects...           | Here we have a glitch |
    remote:  100% (310/310) done                 `-------vvvv----------'
    remote: Total 310 (delta 160), reused 178 (delta 112)iB/s
    Receiving objects: 100% (310/310), 379.98 KiB | 136 KiB/s, done.
    Resolving deltas: 100% (160/160), done.
    * refs/remotes/origin/html: fast forward to branch 'html' of git://git.=
kernel.org/pub/scm/git/git
      old..new: 1c70883..7ae0ab2
    * refs/remotes/origin/maint: fast forward to branch 'maint' of git://gi=
t.kernel.org/pub/scm/git/git
      old..new: 136e631..f45e867
    * refs/remotes/origin/man: fast forward to branch 'man' of git://git.ke=
rnel.org/pub/scm/git/git
      old..new: 9850e2e..44dd7e0
    * refs/remotes/origin/master: fast forward to branch 'master' of git://=
git.kernel.org/pub/scm/git/git
      old..new: 3e4bb08..e3d6d56
    * refs/remotes/origin/next: fast forward to branch 'next' of git://git.=
kernel.org/pub/scm/git/git
      old..new: a93d0b0..536f64a
    * refs/remotes/origin/pu: forcing update to non-fast forward branch 'pu=
' of git://git.kernel.org/pub/scm/git/git
      old...new: eb57be8...bf1284a

FWIW, maybe instead using spaces to erase lines we could use minimal
vt100 codes[0] like:

Erase End of Line       <ESC>[K
    Erases from the current cursor position to the end of the current line.=
=20
Erase Start of Line     <ESC>[1K
    Erases from the current cursor position to the start of the current lin=
e.=20
Erase Line              <ESC>[2K
    Erases the entire current line.

  [0] http://www.termsys.demon.co.uk/vtansi.htm

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLGURvGr7W6HudhwRAvySAJ4iRs5f1UGHJgI4b2uZevytm1UzLQCdFVSD
O2X/d4S+qPtFUYgYpA8kJ8M=
=8Jiu
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
