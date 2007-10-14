From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sun, 14 Oct 2007 09:17:51 +0200
Message-ID: <20071014071751.GC1198@artemis.corp>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <20071014021149.GO27899@spearce.org> <Pine.LNX.4.64.0710140348550.25221@racer.site> <20071014025857.GQ27899@spearce.org> <20071014071239.GB1198@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="jy6Sn24JjFx/iggw";
	protocol="application/pgp-signature"; micalg=SHA1
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 09:18:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igxjf-0003X6-6X
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 09:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbXJNHRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 03:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbXJNHRx
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 03:17:53 -0400
Received: from pan.madism.org ([88.191.52.104]:40624 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbXJNHRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 03:17:52 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 731EA244A4;
	Sun, 14 Oct 2007 09:17:51 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 137D239B17D; Sun, 14 Oct 2007 09:17:51 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071014071239.GB1198@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60801>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On dim, oct 14, 2007 at 07:12:39 +0000, Pierre Habouzit wrote:
>   The trivial way is to add a __thread keyword to make them TLS
> variables, though, it's not really a step in the direction of
> portability, and last time I looked at it, mingw didn't had TLS support,
> not sure if msys has. Though, if Msys has, it's worth using, and we

  Okay forget it, mingw and msys are one and the same *g*.
  So well, maybe threading isn't such a so great idea :/

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEcKfvGr7W6HudhwRAk+iAJ0T7wED1rmGMB74aUhyk8/swb8kywCgi4z/
Qjp7sOWBj6Sx0y6ph3OXk1U=
=8Qyd
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
