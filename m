From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [RFC PATCH v2 2/3] Introduce git-discard
Date: Sat, 25 Jul 2009 16:58:20 +0200
Message-ID: <20090725145819.GC18545@artemis.corp>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
 <cf51e6aa92ea98fc9409826cc0468a01fdf7b01e.1248452530.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:58:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUii0-0000eY-9j
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbZGYO6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbZGYO6a
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:58:30 -0400
Received: from pan.madism.org ([88.191.52.104]:44642 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbZGYO61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:58:27 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7B7B542346;
	Sat, 25 Jul 2009 16:58:26 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 52BA02AEA0; Sat, 25 Jul 2009 16:58:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cf51e6aa92ea98fc9409826cc0468a01fdf7b01e.1248452530.git.trast@student.ethz.ch>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124018>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2009 at 06:24:35PM +0200, Thomas Rast wrote:
> +*WARNING:* All unstaged changes to the 'paths' are *irreversibly*
> +lost.

FWIW, as git checkout -- <path> is already doing that, and that
git-discard is clearly something meant as some UI sugar, I would make
that operation a "safe" porcelain by puting the discarded hunks in a
stash.

I'm shamelessly stealing this idea from Jeff, but it's probably an
excellent idea to have a strash=C2=B9. It makes git even safer to use,
especially to beginners, to whom we would talk about git-discard instead
of git checkout.

=C2=B9: stash-trash
--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
Fax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkprHYsACgkQvGr7W6HudhzUBwCfZi4eGk716fxLu6iH9Vq4Tbnm
WIIAn1707g4/m9pfBPwhbRzuQEnTcspI
=0clm
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
