From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Sun, 27 Aug 2006 13:40:32 +0200
Organization: Polytechnique.org
Message-ID: <200608271340.32792.madcoder@debian.org>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net> <200608271228.09718.madcoder@debian.org> <7v64gexxgl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2074706.XT4Fk8xhPA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 13:40:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHJ0I-00027Q-Tv
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 13:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWH0Lkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 07:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWH0Lkf
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 07:40:35 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:8663 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S932091AbWH0Lkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 07:40:35 -0400
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id B799433199;
	Sun, 27 Aug 2006 13:40:33 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v64gexxgl.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Sun Aug 27 13:40:33 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.001697, queueID=D22E2332C9
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26095>

--nextPart2074706.XT4Fk8xhPA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le dim 27 ao=FBt 2006 12:52, Junio C Hamano a =E9crit :
> About vger potentially throwing things away, I use this script
> (called "taboo.perl") to check my messages before sending them
> out.

that was not it, I was biten (again) by git-send-mail that uses strftime=20
(localized) to generate rfc822 dates, making them unparseable :|

I've resent the aggregated patch, that should work right now.
=2D-=20
=B7O=B7  Pierre Habouzit
=B7=B7O                                                madcoder@debian.org
OOO                                                http://www.madism.org

--nextPart2074706.XT4Fk8xhPA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE8YSwvGr7W6HudhwRAq7qAJ995k4IFu/QRRn3yInG6GA4qcFddgCdG0Vh
m/BtD9d/OPDx2dFUG6+egxI=
=YGMW
-----END PGP SIGNATURE-----

--nextPart2074706.XT4Fk8xhPA--
