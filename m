From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 02:07:57 +0200
Message-ID: <20070919000757.GC4535@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224122.2B55D344AB3@madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="B4IIlcmfBL/1gGOG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXn7E-0002SN-Jl
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbXISAIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXISAIA
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:08:00 -0400
Received: from pan.madism.org ([88.191.52.104]:54400 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbXISAH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:07:59 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CA50520A4D;
	Wed, 19 Sep 2007 02:07:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 599D8344AFC; Wed, 19 Sep 2007 02:07:57 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070918224122.2B55D344AB3@madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58662>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2007 at 10:00:51PM +0000, Pierre Habouzit wrote:
> +		cp =3D strchr(qname.buf + qname.len + 3 - max, '/');
> +		if (cp)
> +			cp =3D qname.buf + qname.len + 3 - max;

  OMG, this is supposed to be if (!cp) of course...

  I wonder how this passed the testsuite.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8GhdvGr7W6HudhwRAsc6AJwLEGRzej0fIi2OcBmRM9uGHlnLeACdGxFe
bzOW+f3IjbL5Xn0qf3yCSkw=
=w6SV
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
