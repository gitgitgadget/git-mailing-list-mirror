From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-clean: correct printing relative path
Date: Wed, 05 Mar 2008 16:53:59 +0100
Message-ID: <20080305155359.GA15843@artemis.madism.org>
References: <20080305094058.GF4793@artemis.madism.org> <20080305141720.GA11542@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qMm9M+Fa2AknHoGS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:56:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvxB-00079U-HJ
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072AbYCEPyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 10:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756751AbYCEPyE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:54:04 -0500
Received: from pan.madism.org ([88.191.52.104]:54358 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756143AbYCEPyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 10:54:02 -0500
Received: from madism.org (def92-8-82-236-12-71.fbx.proxad.net [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 749FC319DF;
	Wed,  5 Mar 2008 16:54:00 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 438FB2BEB5D; Wed,  5 Mar 2008 16:53:59 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Dmitry Potapov <dpotapov@gmail.com>, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080305141720.GA11542@dpotapov.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76233>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2008 at 02:17:20PM +0000, Dmitry Potapov wrote:
> When the given path contains '..' then git-clean incorrectly printed names
> of files. This patch changes cmd_clean to use quote_path() from wt-status.
> Also, "failed to remove ..." message used absolutely path, but not it is
> corrected to use relative path.
>=20
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
> I resend this patch, because it got filtered by vger.kernel.org
> when I used git-send-email from 1.5.4.

  It didn't FWIW.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHzsIXvGr7W6HudhwRAkKDAJ4oh/UTDLzV7uoxNWRhGjHtzVGfKgCgg+s6
xUDdxsUZKYCCU4z0Atd15N0=
=0J/q
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
