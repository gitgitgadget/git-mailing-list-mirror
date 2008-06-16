From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 17:57:47 +0200
Message-ID: <20080616155747.GB6938@artemis.madism.org>
References: <20080616110113.GA22945@elte.hu> <20080616110918.GA30856@glandium.org> <20080616154851.GA6938@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="QTprm0S8XgL7H0Dt";
	protocol="application/pgp-signature"; micalg=SHA1
To: Mike Hommey <mh@glandium.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 17:58:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8H6T-000348-Id
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 17:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbYFPP5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYFPP5u
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 11:57:50 -0400
Received: from pan.madism.org ([88.191.52.104]:51626 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbYFPP5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 11:57:50 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DB106362A0;
	Mon, 16 Jun 2008 17:57:48 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CBD66464CF1; Mon, 16 Jun 2008 17:57:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080616154851.GA6938@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85198>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2008 at 03:48:51PM +0000, Pierre Habouzit wrote:
> On Mon, Jun 16, 2008 at 11:09:18AM +0000, Mike Hommey wrote:
> > - At least, compress the data in the rr-cache. It can grow big quite
> >   easily. Also, I wonder if keeping the entire files is not overkill...
>=20
>   Actually it would be rather straightforward to put it in the usual git
> store, and represent the current rr-cache with a flat file that points
> to the in-git preimage/postimages, and make git-gc aware of those.

  Actually, this is probably a required step in the direction of sharing
such things btw.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhWjXsACgkQvGr7W6Hudhy4OQCeK0j8aCx/6pUCQxjx6apXyYXh
BQMAn0SQdGBHm++Ud4xHcyItWj3/wsEV
=pwdP
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
