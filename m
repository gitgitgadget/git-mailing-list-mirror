From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git blame with valgrind massif
Date: Tue, 11 Dec 2007 22:20:52 +0100
Message-ID: <20071211212052.GC29110@artemis.madism.org>
References: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="0lnxQi9hkpPO77W3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CXU-0002pp-Qj
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbXLKVUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXLKVUy
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:20:54 -0500
Received: from pan.madism.org ([88.191.52.104]:37359 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbXLKVUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:20:53 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 080092F70B;
	Tue, 11 Dec 2007 22:20:52 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0C8062AD730; Tue, 11 Dec 2007 22:20:52 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67946>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 08:57:24PM +0000, Jon Smirl wrote:
> I ran:
>  valgrind --tool=3Dmassif --heap=3Dyes git blame gcc/ChangeLog
> it used about 2.25GB
>=20
> How do you interpret the massif output?

  would you mind putting the postscript it generated somewhere too ?
it's usually pretty informative, because the amount of data allocated is
not all, its liveness is an important information too.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXv80vGr7W6HudhwRAn8lAJ9prtdXRIxD1pNc5EJubjNPag/8ggCff33G
WrQn+q5Kpe4VwYOH8jmp0Gg=
=ihcH
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
