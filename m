From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 7/7] git-tag: fix -l switch handling regression.
Date: Mon, 17 Dec 2007 19:56:52 +0100
Message-ID: <20071217185652.GE22554@artemis.madism.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org> <1197915797-30679-2-git-send-email-madcoder@debian.org> <1197915797-30679-3-git-send-email-madcoder@debian.org> <1197915797-30679-4-git-send-email-madcoder@debian.org> <1197915797-30679-5-git-send-email-madcoder@debian.org> <1197915797-30679-6-git-send-email-madcoder@debian.org> <1197915797-30679-7-git-send-email-madcoder@debian.org> <1197915797-30679-8-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OZkY3AIuv2LYvjdk";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:58:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4L9U-0005u4-54
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794AbXLQS4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758305AbXLQS4y
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:56:54 -0500
Received: from pan.madism.org ([88.191.52.104]:42763 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757852AbXLQS4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:56:54 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6C63A3097F;
	Mon, 17 Dec 2007 19:56:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id C150837DE7C; Mon, 17 Dec 2007 19:56:52 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1197915797-30679-8-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68599>


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  And I managed to resend the broken version, hurray myself.

> +		OPT_INTEGER('l', NULL, &list, "list tag names"),
                OPT_BOOLEAN



Both these last minute fixes are applied to my public git.git.

Let's now write 1000 times: I will run the test-suite before I send
patches, I will rune the test-suite before I send patches, =E2=80=A6
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZsZ0vGr7W6HudhwRAm+7AJ4pz0IdYVTivSKmJz3vniGQYAEN/QCgjRsA
3Vx7QDS8up2kdSyDvsyOCOo=
=zKIL
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
