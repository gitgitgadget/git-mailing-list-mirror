From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Use of strbuf.buf when strbuf.len == 0
Date: Thu, 27 Sep 2007 13:37:18 +0200
Message-ID: <20070927113718.GF10289@artemis.corp>
References: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org> <20070927112204.GE10289@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="xaMk4Io5JJdpkLEb";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 13:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IargN-0001IJ-4g
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbXI0LhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbXI0LhU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:37:20 -0400
Received: from pan.madism.org ([88.191.52.104]:53104 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbXI0LhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:37:20 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8E18922052;
	Thu, 27 Sep 2007 13:37:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 44D22BC7; Thu, 27 Sep 2007 13:37:18 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070927112204.GE10289@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59286>


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 11:22:04AM +0000, Pierre Habouzit wrote:
> (it's arguable > that it's a right thing to assume though)

  I find this ugly, so I've even checked if we did assume that, which is
easy now that such places all use strbuf_detach. One place seemed to,
but wasn't, so I patched it so that it's not the case anymore.

  All other places that use strbuf_detach don't use the fact that it can
return NULL to detect error cases, so we are safe.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+5XuvGr7W6HudhwRAsppAJ9Mtgz2Hj1nNkjDxAA9yBpQSCg8hQCglFzd
lq5BugzeQqSw8Y8bKlaMfcQ=
=LHPw
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
