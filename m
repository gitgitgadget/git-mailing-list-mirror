From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a guilt-export(1) command to export a guilt series to quilt.
Date: Wed, 13 Jun 2007 17:16:40 +0200
Message-ID: <20070613151640.GI5311@artemis.intersec.eu>
References: <1181743313509-git-send-email-madcoder@debian.org> <1621f9fa0706130810n17bc3f67h1c539d75b3aed4ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="9jHkwA2TBA/ec6v+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Josef Jeff Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
To: Benjamin Sergeant <bsergean@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUaT-000271-F5
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757968AbXFMPQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758010AbXFMPQn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:16:43 -0400
Received: from pan.madism.org ([88.191.52.104]:33614 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757758AbXFMPQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:16:42 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 87177D644;
	Wed, 13 Jun 2007 17:16:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0049F1AF29; Wed, 13 Jun 2007 17:16:40 +0200 (CEST)
Mail-Followup-To: Benjamin Sergeant <bsergean@gmail.com>,
	Josef Jeff Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1621f9fa0706130810n17bc3f67h1c539d75b3aed4ed@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50076>


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2007 at 08:10:36AM -0700, Benjamin Sergeant wrote:
> For the shebang:
> #!/usr/bin/env bash
> should works well and should work on non-linux boxes that did not
> added a link in /bin/bash.

  FWIW it would spawn a process for nothin, and every other guilt
command uses that. People using it on non linux box would have to run a
sed on every shebang at install time, that's not _that_ hard anyways,
and is common practice with python or perl scripts e.g. IMHO it's not a
problem.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcApYvGr7W6HudhwRApYmAKCVvCACqWjBNx+CjP0A97yfvQ8EgQCghtgQ
VZk9LQZGqC+N9nAxoxas6tw=
=oHlR
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
