From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/5] Rework unquote_c_style to work on a strbuf.
Date: Wed, 19 Sep 2007 02:14:57 +0200
Message-ID: <20070919001457.GD4535@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224121.24C3B344AB3@madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AbQceqfdZEv+FvjW";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:15:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXnDc-00045K-Cu
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbXISAO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXISAO7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:14:59 -0400
Received: from pan.madism.org ([88.191.52.104]:54206 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbXISAO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:14:58 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7428220323;
	Wed, 19 Sep 2007 02:14:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 22016344AC2; Wed, 19 Sep 2007 02:14:57 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070918224121.24C3B344AB3@madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58663>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2007 at 09:22:47PM +0000, Pierre Habouzit wrote:
> +			for (cp =3D name.buf; p_value; p_value--) {
> +				cp =3D strchr(name.buf, '/');

  And I forgot to fix this, as cp =3D strchr(cp...) like the patch I
proposed for integration in maint.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8GoBvGr7W6HudhwRAkT0AJ0bobBeBdZOK6OI551TNoCVLRnbVQCfcIAq
69wSkYqFqdG2F3zU6nHdGyg=
=foqw
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
