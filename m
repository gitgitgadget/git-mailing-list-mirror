From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 12:02:45 +0100
Message-ID: <20081031110245.GA22633@artemis.corp>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Qxx1br4bt0+wmkIi";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Thanassis Tsiodras <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 12:04:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvrnZ-0003bi-Aq
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 12:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbYJaLCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 07:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYJaLCs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 07:02:48 -0400
Received: from pan.madism.org ([88.191.52.104]:55563 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbYJaLCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 07:02:47 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 56FDD3B56E;
	Fri, 31 Oct 2008 12:02:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 476D45EE236; Fri, 31 Oct 2008 12:02:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99574>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 09:43:43AM +0000, Thanassis Tsiodras wrote:
> So even though the xdelta is just 8KB, and git-gc actually finds out
> that indeed
> the new file is very similar to the old one, the initial commit of the
> new version
> in the repos is not taking advantage.

Have you tried to git repack with aggressive options, like:

    git repack --window=3D500 --depth=3D500 \
      --window-memory=3D<fair amount of your physical RAM>

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkK5dUACgkQvGr7W6HudhzjuACfZWifmSNZWhG/dIgW1R5HF3EY
6VYAoIwOTvKzbBA9y9Q4kd+6obIyhq8Z
=mtLn
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
