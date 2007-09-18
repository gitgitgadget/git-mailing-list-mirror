From: Pierre Habouzit <madcoder@debian.org>
Subject: let's refactor quoting ...
Date: Wed, 19 Sep 2007 00:39:47 +0200
Message-ID: <20070918223947.GB4535@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="p4qYPpj5QlsIQJ0K";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:40:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXljj-0007Hs-Lc
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbXIRWjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbXIRWjt
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:39:49 -0400
Received: from pan.madism.org ([88.191.52.104]:54819 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691AbXIRWjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:39:48 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AE4BD208A9;
	Wed, 19 Sep 2007 00:39:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 59E6B344AC1; Wed, 19 Sep 2007 00:39:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58646>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Here comes a series dedicated to quote. I just can't resist the simple
pleasure to show:

$ git diff --shortstat HEAD~5.. ^strbuf*; git diff --shortstat HEAD~5.. str=
buf*
 19 files changed, 523 insertions(+), 716 deletions(-)
 2 files changed, 41 insertions(+), 16 deletions(-)

  So it's an overall ~200 sloc reductions for a gain of 30 lines in
the strbuf module.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8FOzvGr7W6HudhwRAiD2AJ9dKu8Ncah+QE2EfdC10dAAH8MOPwCglLzK
5oz4MEDPp3ildwIwJP5iZdU=
=uB6T
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
