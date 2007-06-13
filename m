From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: tags and patches
Date: Wed, 13 Jun 2007 13:04:01 +0200
Message-ID: <20070613110401.GG21684@artemis.intersec.eu>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="kbCYTQG2MZjuOjyn";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 13:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyQe2-0002oj-MR
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 13:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757244AbXFMLEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 07:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbXFMLEF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 07:04:05 -0400
Received: from pan.madism.org ([88.191.52.104]:57053 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757023AbXFMLEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 07:04:04 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 57829D541;
	Wed, 13 Jun 2007 13:04:02 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CECCB99B31; Wed, 13 Jun 2007 13:04:01 +0200 (CEST)
Mail-Followup-To: Geoff Russell <geoffrey.russell@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50044>


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2007 at 08:22:23PM +0930, Geoff Russell wrote:
> Dear gits,
>=20
> (I'm on 1.5.0.5)
>=20
> The last tag made seems to be missing from a patch ... eg.
>=20
>        cd ~ ; mkdir myrepo ; cd myrepo
>        git init-db ; echo STUFF > xxx ; git add xxx
>        # work, work, work on xxx
>        git commit -a
>        git tag v1.0
>        # work work work on xxx
>        # then I clone this repository
>        cd /tmp ; git clone ~/myrepo newmyrepo
>        # go back and work some more
>        cd ~/myrepo
>        echo YYY >>xxx
>        git commit -a
>        git tag v1.1
>        # is git commit -a required to commit the tag???
>        git format-patch v1.0
>        cd /tmp/newmyrepo
>        git am ~/myrepo/THEPATCHNAME
>        git tag ls

  git tag ls is not the proper way to list tags. Afaict there isn't any
yet, except: ls .git/refs/tags/

  git tag ls just tagged your HEAD with the name 'ls' which is obviously
not what you meant :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGb88hvGr7W6HudhwRAnnDAJ9wLjPSFF43HHY9aU2yZIHIW508MACfWIBB
lo+zjIxCYvQoDLrUn+K4we8=
=AQts
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
