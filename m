From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: xmemdup patches
Date: Mon, 17 Sep 2007 18:14:20 +0200
Message-ID: <20070917161420.GC460@artemis.corp>
References: <20070917161113.GB460@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="R+My9LyyhiUvIEro";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJEy-000627-3h
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXIQQOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbXIQQOW
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:14:22 -0400
Received: from pan.madism.org ([88.191.52.104]:48354 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbXIQQOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:14:21 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D26026AB
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 18:14:20 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7CE7D344C06; Mon, 17 Sep 2007 18:14:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070917161113.GB460@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58458>


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On lun, sep 17, 2007 at 04:11:13 +0000, Pierre Habouzit wrote:
>   There were 41 of those places.

  I forgot to say, I replaced _some_ xstrndup uses with a xmemdup when
it was clear to me that xmemdup was Okay. I left some alone when it
wasn't obvious in the first 10 seconds that xmemdup would work the same
way.

  The real goal is code brevity and readability, xstrndup or xmemdup are
the same in that regard, and I don't think the small performance gain is
really worth the headache.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7qfcvGr7W6HudhwRAii/AJwIt+ZJG2CHRBt/kxIUIeIjoV/32QCgoUc/
bHNQfWrCtumC9p7K9BoSxwA=
=1KxC
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
