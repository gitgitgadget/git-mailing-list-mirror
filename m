From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: strbuf API
Date: Mon, 03 Sep 2007 13:53:28 +0200
Message-ID: <20070903115328.GC21759@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <vpqk5r8m9nz.fsf@bauges.imag.fr> <20070903084927.GB21759@artemis.corp> <7vejhgksza.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="2JFBq9zoW8cOFH7v";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISAUp-0003C1-EQ
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXICLxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755072AbXICLxb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:53:31 -0400
Received: from pan.madism.org ([88.191.52.104]:34555 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165AbXICLxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:53:30 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 856971DA5F;
	Mon,  3 Sep 2007 13:53:29 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 856A61123; Mon,  3 Sep 2007 13:53:28 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejhgksza.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57475>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2007 at 09:18:01AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Mon, Sep 03, 2007 at 08:32:16AM +0000, Matthieu Moy wrote:
> >>  ...
> >> For example, it would be very tempting to compare files with
> >> "strcmp(buf1, buf2)", but that would just fail silently when the file
> >> contains a '\0' byte.
> >
> >   Indeed, OTHO doing that would be pretty silly, as embending NULs in a
> > strbuf is wrong, it's a _str_buf, not a random-binary-buffer. It's meant
> > to make the use of strings easier, not to use as generic purpose byte
> > buffers. Of course they can, but well, it's not what they are designed
> > for in the first place.
>=20
> People, please realize strbuf "API" is not a serious API. =20
>=20
> It wasn't even intended to be anything more than just a
> quick-and-dirty implementation of fgets that can grow
> dynamically.  The other callers added by people to have it do
> general string manipulations were just bolted-on, not designed.
> I haven't taken a serious look at bstring nor any of the
> alternatives yet, but defending strbuf as if it was designed to
> be a sane API is just silly.

  actually I was defending the "enhanced" strbuf API I was proposing
before, sorry if that was unclear.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG2/W4vGr7W6HudhwRAuTfAJ4ovFkfxiJ08mfRGiSNryMGdeoEwACfTjUE
6pSx42+K2HQj9IEvkFahf20=
=OGG0
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
