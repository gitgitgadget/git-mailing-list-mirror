From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 5/6] builtin-commit: resurrect behavior for multiple -m   options
Date: Sun, 11 Nov 2007 23:13:14 +0100
Message-ID: <20071111221314.GE13200@artemis.corp>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> <Pine.LNX.4.64.0711111736310.4362@racer.site> <20071111194228.GC13200@artemis.corp> <Pine.LNX.4.64.0711112039130.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="KlAEzMkarCnErv5Q";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrL3b-0008Nh-5Z
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbXKKWNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755069AbXKKWNQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:13:16 -0500
Received: from pan.madism.org ([88.191.52.104]:46012 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969AbXKKWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:13:15 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 116832991B;
	Sun, 11 Nov 2007 23:13:15 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B68E9FEEE4; Sun, 11 Nov 2007 23:13:14 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711112039130.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64525>


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2007 at 08:42:48PM +0000, Johannes Schindelin wrote:
> Well, I meant to mention it in the cover letter.  My preference is to do=
=20
> away with the extra empty line.  But this might break existing setups=20
> depending on that behaviour.

  In fact I believe what matters is that if there is more than one -m,
you have a \n\n between the first and the second one, else it'll break
subjects, and that sucks, so I'd say we have to stay with "\n\n" at
least for the first aggregation, and I'm unsure if it's worth the hassle
to count how many times we aggregated to use '\n' then.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHN356vGr7W6HudhwRAjLEAJ9z21OngMTriG5vlmAIv8C2rZ3z8wCcDL1q
PJ8OpD3W2ZScfHI13VWm23E=
=MQrj
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
