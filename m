From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] revisions: refactor handle_revision_opt into  parse_revision_opt.
Date: Thu, 10 Jul 2008 09:40:12 +0200
Message-ID: <20080710074012.GC24819@artemis.madism.org>
References: <1215639514-1612-1-git-send-email-madcoder@debian.org> <1215639514-1612-2-git-send-email-madcoder@debian.org> <20080710071418.GD3195@sigill.intra.peff.net> <20080710073450.GA24819@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qtZFehHsKgwS5rPz";
	protocol="application/pgp-signature"; micalg=SHA1
To: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 10 09:41:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqmB-0004Mw-QJ
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYGJHkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbYGJHkP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:40:15 -0400
Received: from pan.madism.org ([88.191.52.104]:60130 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845AbYGJHkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:40:14 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B90C51BA;
	Thu, 10 Jul 2008 09:40:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D15443211; Thu, 10 Jul 2008 09:40:12 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20080710073450.GA24819@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87954>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2008 at 07:34:50AM +0000, Pierre Habouzit wrote:
> and have a full parse-opt thing from top to bottom. the "--reverse" hack
> could be done really differently, because we really know what
> "--children" does and we could directly do what the revision option
> parser does.

  I mean in a clean way, given what --children does, it would probably
implemented by a callback in revision.c, so it's easy for git-blame to
call it too.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh1vNwACgkQvGr7W6HudhzydQCfXoiuShX+hPTon628Uy+psyK1
sI0AoI7fBiWPnAL6FHbS7hIGT66YkPUr
=+D7Y
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
