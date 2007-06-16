From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFT] Format our Documentation/ with both AsciiDoc 7 & 8
Date: Sat, 16 Jun 2007 10:49:39 +0200
Message-ID: <20070616084939.GA9118@artemis>
References: <11810823561507-git-send-email-madcoder@debian.org> <7vfy4t915f.fsf@assigned-by-dhcp.pobox.com> <20070615080935.GB28554@artemis.intersec.eu> <7vy7ik7rvq.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HcAYCG3uE/tztfnV";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 10:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzTyb-0002c9-3B
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 10:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbXFPItn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 04:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbXFPItn
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 04:49:43 -0400
Received: from pan.madism.org ([88.191.52.104]:35091 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbXFPItm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 04:49:42 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6DF64E3DC;
	Sat, 16 Jun 2007 10:49:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D0FA11AAA6; Sat, 16 Jun 2007 10:49:39 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy7ik7rvq.fsf@assigned-by-dhcp.pobox.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50288>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2007 at 03:52:09PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   sadly, it does not fixes the issue I reported with git-pull.1 (e.g.)
> > that reads:
> >
> >    <refspec>
> >        The canonical format of a <refspec> parameter is ?<src>:<dst>; t=
hat
> >
> > whereas it should be:
> >
> >    <refspec>
> >        The canonical format of a <refspec> parameter is +?<src>:<dst>; =
that
>=20
> That is very unexpected, especially as your e-mail address is in
> debian.org.

  Well I'm running unstable, with asciidoc 8.2.1.

>  * I updated my notebook that runs Debian with AsciiDoc 8.2.1
>    and tested with the patch.  The formatted result matches the
>    above.

  AAAAND I'M AN IDIOT. I tested it in the wrong branch, without the
patch. do'h.

  I confirm that it works perfectly. Now, does someone knows a hole
where I can hide into ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGc6QjvGr7W6HudhwRAkfsAJ9zie+eu0ycGnU/CqwGaCgRkE09IACgmHG1
d0cBlfz9cT9trVp6kDZGwOw=
=SfSP
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
