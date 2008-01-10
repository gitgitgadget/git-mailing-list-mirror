From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 10:17:33 +0100
Message-ID: <20080110091733.GB17944@artemis.madism.org>
References: <874pdmhxha.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ftEhullJWpWg/VHq";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 10:18:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCtY4-0007tS-8G
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 10:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbYAJJRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 04:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbYAJJRf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 04:17:35 -0500
Received: from pan.madism.org ([88.191.52.104]:39945 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbYAJJRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 04:17:34 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D92742E39E;
	Thu, 10 Jan 2008 10:17:33 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2617E4CDE99; Thu, 10 Jan 2008 10:17:33 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874pdmhxha.fsf@rho.meyering.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70053>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2008 at 08:54:25AM +0000, Jim Meyering wrote:
>=20
> I noticed some unchecked writes.  This fixes them.

  Yeah, while we're at it, compiling git with -D_FORTIFY_SOURCE=3D2 isn't
really brilliant right now, there are quite many places with unchecked
writes, fwrites and chdirs.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHheKtvGr7W6HudhwRAsvkAJ0ZMg+8DVHZnSsOB6URw4EGA1FVLQCgowOL
Sv+B6Few1U7Fd3sfvE17tCY=
=sNsq
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
