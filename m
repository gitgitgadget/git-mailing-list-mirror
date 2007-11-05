From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Mon, 05 Nov 2007 19:19:16 +0100
Message-ID: <20071105181916.GE6205@artemis.corp>
References: <20071105175654.GD6205@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="KlAEzMkarCnErv5Q";
	protocol="application/pgp-signature"; micalg=SHA1
To: Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 19:19:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip6Xu-0000d3-Ux
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 19:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbXKESTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 13:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbXKESTS
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 13:19:18 -0500
Received: from pan.madism.org ([88.191.52.104]:51725 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbXKESTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 13:19:17 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BF8466C47;
	Mon,  5 Nov 2007 19:19:16 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6A07B20E809; Mon,  5 Nov 2007 19:19:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071105175654.GD6205@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63533>


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 05:56:54PM +0000, Pierre Habouzit wrote:
> With the current tip of next[0], I have this bizare issue:
>=20
>   * I have two branches say master, and next, I'm on next.
>=20
>   * my master lags behind origin/master, but next is a fast-forward wrt
>     origin/next.
>=20
> Now I git push:
>=20
>     =E2=94=8C=E2=94=80(18:16)=E2=94=80=E2=94=80<~/some/repo next>=E2=94=
=80=E2=94=80
>     =E2=94=94[artemis] git push
>     error: remote 'refs/heads/master' is not an ancestor of
>      local  'refs/heads/master'.
>      Maybe you are not up-to-date and need to pull first?
>     updating 'refs/heads/next'
>       from xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>       to   yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
>     Counting objects: 24, done.
>     Compressing objects: 100% (14/14), done.
>     Writing objects: 100% (14/14), done.
>     Total 14 (delta 12), reused 0 (delta 0)
>     refs/heads/next: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -> yyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
>     updating local tracking ref 'refs/remotes/origin/master'
>     updating local tracking ref 'refs/remotes/origin/next'
[...]
> I believe there is something rotten in the kingdom of Denmark=E2=80=A6 th=
ough
> my heads seems to always be OK, I think it's just an output issue.

  Okay I'm wrong. it happened again, in fact after the git-push I don't
have a origin/master anymore.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL16kvGr7W6HudhwRAj3UAJ9HMXAg1mlSDguyNamdEt8BBcsRbQCeNII6
elypCfCoCtVLvGk52n9PSvU=
=ipsE
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
