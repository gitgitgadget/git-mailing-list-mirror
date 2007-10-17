From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-apply segfault
Date: Wed, 17 Oct 2007 13:10:35 +0200
Message-ID: <20071017111035.GC4350@artemis.corp>
References: <200710171100.01247.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="dkEUBIird37B8yKS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 13:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii6nk-0006IQ-J8
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 13:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761960AbXJQLKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 07:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759248AbXJQLKi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 07:10:38 -0400
Received: from pan.madism.org ([88.191.52.104]:51981 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755532AbXJQLKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 07:10:37 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5437F25380;
	Wed, 17 Oct 2007 13:10:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DD15C357D00; Wed, 17 Oct 2007 13:10:35 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200710171100.01247.andyparkins@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61367>


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2007 at 10:00:01AM +0000, Andy Parkins wrote:
> Hello,
>=20
> I've not got time to investigate this further just now, I'll try later.  =
In=20
> case anyone else wants to though; I just got this core dump when running =
git=20
> rebase using current git master (1.5.3.4.206.g58ba4):

  It's not the current master, it's an old one, the fix is in:
90d16ec032b20f9f1146f3aceca12165aba3b6d6

  You must fetch from spearce.git[0] that has taken maintainance interim
until junio comes back.

Cheers,

  [0] git://repo.or.cz/git/spearce.git
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFe2rvGr7W6HudhwRAqs6AJ4w7h27lhqtqj78YNOGebGJUSzDdgCgniAC
NJwA6kPVo7XNgXnhkIn7QAw=
=9YSI
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
