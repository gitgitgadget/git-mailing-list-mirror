From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 14:42:53 +0200
Message-ID: <20070907124253.GB27754@artemis.corp>
References: <1189115308.30308.9.camel@koto.keithp.com> <7vsl5r8jer.fsf@gitster.siamese.dyndns.org> <1189133898.30308.58.camel@koto.keithp.com> <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org> <46E145BF.4070403@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZfOjI3PrQbgiZnxM";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITdAq-0002tY-TY
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 14:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbXIGMm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 08:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbXIGMm4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 08:42:56 -0400
Received: from pan.madism.org ([88.191.52.104]:43630 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965304AbXIGMmz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 08:42:55 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E6B4419763;
	Fri,  7 Sep 2007 14:42:53 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 13D274F76; Fri,  7 Sep 2007 14:42:53 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@eudaptics.com>,
	Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46E145BF.4070403@eudaptics.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58035>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 12:36:15PM +0000, Johannes Sixt wrote:
> Junio C Hamano schrieb:
> >But he has a stray .git/master file,
> >perhaps created by hand by mistake (it would be very interesting
> >to find how that file got there in the first place),
>=20
> It is easy to get one there if, in a brave moment, you try
>=20
>    git update-ref master $some_other_ref
>=20
> instead of the correct
>=20
>    git update-ref refs/heads/master $some_other_ref

  I was about to say the same :)
  I'd have added though that maybe update-ref should print a warning for
the references that do not match the restriction Junio added. This could
be done using the function Junio proposed un update_ref() in refs.c

  note that it's a sane thing to do anyways, I would not bet a lot of
money on what happens if you ask git to:

  git update-ref $foo $sha

  for foo in (completely random :P): index config packed-refs ...

  If a tool needs a new reference namespace, it can create a
subdirectory under refs/ so it does not really causes harm IMHO.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4UdNvGr7W6HudhwRAkXpAJ9LsVhxjZOhNpZ1l1xukp9VwBtBbQCePdIp
vOkbtuVC/U6SrYwruGxVCvE=
=XMIn
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
