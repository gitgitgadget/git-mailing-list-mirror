From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: rebase from ambiguous ref discards changes
Date: Fri, 07 Sep 2007 08:55:46 +0200
Message-ID: <20070907065546.GA21418@artemis.corp>
References: <1189115308.30308.9.camel@koto.keithp.com> <7vsl5r8jer.fsf@gitster.siamese.dyndns.org> <1189133898.30308.58.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="C7zPtVaVf+AK4Oqc";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXkw-0007hH-PE
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbXIGGzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbXIGGzu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:55:50 -0400
Received: from pan.madism.org ([88.191.52.104]:39749 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932656AbXIGGzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 02:55:49 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0865D1E102;
	Fri,  7 Sep 2007 08:55:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 03048E618; Fri,  7 Sep 2007 08:55:46 +0200 (CEST)
Mail-Followup-To: Keith Packard <keithp@keithp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1189133898.30308.58.camel@koto.keithp.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57992>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 02:58:18AM +0000, Keith Packard wrote:
> On Thu, 2007-09-06 at 16:26 -0700, Junio C Hamano wrote:
>
> > Perhaps you have ".git/master" by mistake?
>
> oops.
>
> $ find .git -name master
> ..git/master
> ..git/refs/heads/master
> ..git/refs/remotes/kyle/master
> ..git/refs/remotes/origin/master
> ..git/refs/remotes/otc/master
> ..git/logs/refs/heads/master
> ..git/logs/refs/remotes/fdo/master
> ..git/logs/refs/remotes/kyle/master
> ..git/logs/refs/remotes/origin/master
> ..git/logs/refs/remotes/otc/master
>=20
> So, I think that explains where the ambiguous master came from.  Seems
> like rebase should be able to bail out before breaking things though.

  Actually if I get this right, it didn't broke anything, it just
rebased your ".git/master" :) It just chose the wrong desambiguation for
some reason.



--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4PXyvGr7W6HudhwRAsXwAJ9de2u3R0BBz5ruXHGiT3Yd78CO7QCfV+kx
yc4KJWKLvDTrBeR6CTM0JxM=
=2MZj
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
