From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] make git-filter-branch use parse-options.
Date: Fri, 31 Oct 2008 09:22:09 +0100
Message-ID: <20081031082209.GB21015@artemis.corp>
References: <20081030132623.GC24098@artemis.corp> <1225383538-23666-1-git-send-email-madcoder@debian.org> <1225383538-23666-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="s2ZSL+KKDSLx8OML";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: pasky@suse.cz, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 09:23:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvpHy-00084l-KH
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYJaIWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 04:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbYJaIWN
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:22:13 -0400
Received: from pan.madism.org ([88.191.52.104]:39355 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbYJaIWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 04:22:12 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D86BB3B4F4;
	Fri, 31 Oct 2008 09:22:11 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 071ED5EE23C; Fri, 31 Oct 2008 09:22:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225383538-23666-2-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99563>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Okay this patch prevents us to use rev-list options in fact, which is
broken I guess, since it prevents --not and a few similar arguments that
can make sense. Please do not apply, I'll try to rework the next patch
though since nobody complained, it's that it looks fine :p

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkKwDAACgkQvGr7W6HudhzKgQCfS3hbqrrnk1FbfUhrJIAapTUz
QBYAn2QoJUu11xOyl8U0D+5BrhOKyjwB
=W7S7
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
