From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [REPLACEMENT PATCH] parse-opt: fake short strings for callers to believe in.
Date: Thu, 26 Jun 2008 10:35:06 +0200
Message-ID: <20080626083506.GA7237@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <20080624205801.GG9189@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="r5Pyd7+fXNt84Ff3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 26 10:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBmxc-0006kF-59
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYFZIfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbYFZIfL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:35:11 -0400
Received: from pan.madism.org ([88.191.52.104]:33994 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbYFZIfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:35:09 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D510BDAC7;
	Thu, 26 Jun 2008 10:35:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 60B91D7DA; Thu, 26 Jun 2008 10:35:06 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080624205801.GG9189@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86415>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  Hi Junio,

  I saw that you merged this series into pu, for which I'm really glad,
though I believe that the version that works on top of the "leaky()"
series is better, since everyone agrees that the small leaks in the
option parser are better than the limitations the one you merged has.

  I won't flood the list again with the patches, but you can find them
in git://git.madism.org/~madcoder/git.git#ph/parseopt (based on current
next). This includes the two leaky() patches (with the remarks that have
been made to me incorporated), the current state of the parse-options
improvements, and the current builtin-blame.c proof of concept (without
the ugly strdup).

  I really don't like the strbuf thingy, and I'd be glad to never see it
merged in next, it will cause more harm than it helps.

TIA.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhjVLgACgkQvGr7W6HudhwBRACgkb8Kh1I0tfM6PABpNpDNWCoF
+/4AoKJ4x9Yv+02Fned6qMRgrBIo5n08
=UfZJ
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
