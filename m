From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 06 Dec 2007 15:22:54 +0100
Message-ID: <20071206142254.GD5959@artemis.madism.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> <20071205.202047.58135920.davem@davemloft.net> <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> <Pine.LNX.4.64.0712061201580.27959@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NklN7DEeGtkPCoo3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 06 15:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0HdS-0004jR-Hl
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 15:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbXLFOXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 09:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXLFOXG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 09:23:06 -0500
Received: from pan.madism.org ([88.191.52.104]:50389 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbXLFOXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 09:23:05 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 24E502E47A;
	Thu,  6 Dec 2007 15:22:55 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id F10EBFEED9; Thu,  6 Dec 2007 15:22:54 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712061201580.27959@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67290>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2007 at 12:03:38PM +0000, Johannes Schindelin wrote:
>=20
> The default was not to change the window or depth at all.  As suggested
> by Jon Smirl, Linus Torvalds and others, default to
>=20
> 	--window=3D250 --depth=3D250

  well, this will explode on many quite reasonnably sized systems. This
should also use a memory-limit that could be auto-guessed from the
system total physical memory (50% of the actual memory could be a good
idea e.g.).

  On very large repositories, using that on the e.g. linux kernel, swaps
like hell on a machine with 1Go of ram, and almost nothing running on it
(less than 200Mo of ram actually used)

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHWAW+vGr7W6HudhwRAkAvAJ4mPfVoZkyMDmNknfHPPbI1l4HatACgiD85
nj/U9KGR/mYxLCUOJnTg7yQ=
=B6Ea
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
