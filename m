From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [bug] generic issue with git_config handlers
Date: Thu, 31 Jan 2008 11:10:37 +0100
Message-ID: <20080131101037.GG24403@artemis.madism.org>
References: <20080131091627.GB24403@artemis.madism.org> <7v1w7ye48j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="APlYHCtpeOhspHkB";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWOV-0005vD-Bf
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762062AbYAaKKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757219AbYAaKKl
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:10:41 -0500
Received: from pan.madism.org ([88.191.52.104]:50037 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765900AbYAaKKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:10:39 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 815A63164D;
	Thu, 31 Jan 2008 11:10:38 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E5A364DF025; Thu, 31 Jan 2008 11:10:37 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v1w7ye48j.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72118>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2008 at 09:25:32AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   One of my co-workers stumbled upon a misfeature of the git config
> > parser. The following syntax is allowed:
> >
> >     [section]
> > 	 foo
>=20
> Yeah, that is how "truth" value of boolean is spelled.
>=20
> > [user]
> >     name
>=20
> That's very unfortunate.  Whatever is expecting string value
> should check for NULL.  Fix should probably be easy enough for
> any git-hacker-wannabe to tackle ;-)

  I think so too, though my count is something like 40 functions to
investigate (the 40 handlers) and where it recurses into ;) Too much
work for the time I have right now.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHoZ6dvGr7W6HudhwRAlwbAJ9aSinSfKZkH311I0wz80V3xpFQagCdExtV
veLPDaKzWYZjzMqhfXdSk78=
=osxv
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
