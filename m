From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-opt: do not pring errors on unknown options,  return -2 intead.
Date: Tue, 24 Jun 2008 00:13:26 +0200
Message-ID: <20080623221326.GG13395@artemis.madism.org>
References: <20080623210935.GC13395@artemis.madism.org> <1214255482-2086-1-git-send-email-madcoder@debian.org> <1214255482-2086-2-git-send-email-madcoder@debian.org> <1214255482-2086-3-git-send-email-madcoder@debian.org> <1214255482-2086-4-git-send-email-madcoder@debian.org> <7vd4m7hkjf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nhYGnrYv1PEJ5gA2";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuIq-0001oG-RK
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbYFWWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbYFWWN3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:13:29 -0400
Received: from pan.madism.org ([88.191.52.104]:54147 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbYFWWN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:13:28 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1E6B037DC4;
	Tue, 24 Jun 2008 00:13:27 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B54ADBDB25; Tue, 24 Jun 2008 00:13:26 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	peff@peff.net, Johannes.Schindelin@gmx.de
Content-Disposition: inline
In-Reply-To: <7vd4m7hkjf.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85943>


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 10:08:04PM +0000, Junio C Hamano wrote:
> You'd need something like this on top.
>=20
> Documentation/technical/api-parse-options says that non-zero return is
> used to signal an error.

Oh right, like said, it's still rough on the edges :)

I'm not 100% convinced by the current usage generation yet. But I'll
sleep on it first.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhgIAYACgkQvGr7W6HudhzD3QCeO3YrFfJ8R+Jo0Y1tHLlCpg23
ARAAn3Wd78PK93Dup595cuTWK9mMJsEM
=vdLc
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
