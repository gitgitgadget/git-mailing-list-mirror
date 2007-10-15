From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-fast-import crashes
Date: Mon, 15 Oct 2007 09:33:07 +0200
Message-ID: <20071015073307.GA1508@artemis.corp>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com> <20071013032916.GL27899@spearce.org> <20071013033407.GM27899@spearce.org> <20071013073640.GC7110@artemis.corp> <20071013075027.GD7110@artemis.corp> <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="u3/rZRmxL6MmkK24";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Shun Kei Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 09:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhKS3-0000vo-3D
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 09:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbXJOHdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 03:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbXJOHdL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 03:33:11 -0400
Received: from pan.madism.org ([88.191.52.104]:45259 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbXJOHdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 03:33:09 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4A13224FD1;
	Mon, 15 Oct 2007 09:33:08 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 840F83ACFDD; Mon, 15 Oct 2007 09:33:07 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60957>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2007 at 04:53:38AM +0000, Shun Kei Leung wrote:
> Hi,
>=20
> Sorry for the late reply. I was away from my computer in the weekend.
>=20
>=20
> Hi Pierre,
>=20
> I didn't try:
> http://git.madism.org/?p=3Dgit.git;a=3Dcommit;h=3D7406e83342cd445ac38c175=
3c5fce75377737e2f
>=20
> because the bad commit turns out to be b449f4c according to `git bisect'.

  I don't get the reason for your "because" but so be it. The commit you
show is not obviously broken to me, especially not in fast-import.c, so
I'll need more input.  Could you please run your test in valgrind and
report the output please? Or if the data to reproduce the bug are online
or shareable, it'd be great to share, so that I can reproduce the issue
here.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHExezvGr7W6HudhwRAm9hAJ4liAZAazWB8kJfToGt8ODjtmK7fgCfXOTa
VBtl8NTBRYHeeCmx/RU05Po=
=fs0s
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
