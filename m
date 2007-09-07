From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] HEAD, ORIG_HEAD and FETCH_HEAD are really special.
Date: Fri, 07 Sep 2007 23:04:33 +0200
Message-ID: <20070907210433.GD23483@artemis.corp>
References: <1189115308.30308.9.camel@koto.keithp.com> <7vsl5r8jer.fsf@gitster.siamese.dyndns.org> <1189133898.30308.58.camel@koto.keithp.com> <7vd4wu67qs.fsf_-_@gitster.siamese.dyndns.org> <46E145BF.4070403@eudaptics.com> <20070907124253.GB27754@artemis.corp> <7vabry43cg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="zbGR4y+acU1DwHSi";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITl0L-0000iS-QJ
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 23:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495AbXIGVEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 17:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbXIGVEg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 17:04:36 -0400
Received: from pan.madism.org ([88.191.52.104]:40178 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758435AbXIGVEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 17:04:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AB0AC1E882;
	Fri,  7 Sep 2007 23:04:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 41C348477; Fri,  7 Sep 2007 23:04:33 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@eudaptics.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vabry43cg.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58075>


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 08:39:43PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > I'd have added though that maybe update-ref should print a warning for
> > the references that do not match the restriction Junio added. This could
> > be done using the function Junio proposed un update_ref() in refs.c
>=20
> I would even suggest making it into an error, even if we do not
> error out on the reading side (being liberal when reading but
> more strict when creating, that is).
>=20
> That confused_ref() needs to be tightened further, by the way.
> It is called only when we are considering to tack the user
> string immediately below $GIT_DIR/ so the only valid cases are
> (1) the string begins with "refs/", or (2) the string is all
> uppercase (or underscore), especially without slash.  The one in
> the proposed patch is not strict enough and does not enforce the
> former.

  I reckon I didn't checked what the function did in detail, just the
code layout :) And I agree an error is event better, I just don't have
enough knowledge of the scripts that used refs in git for a long time
that such a change could break. I mean, I only use git since the 1.2
(maybe even 1.3) series :)

  I'm always all for refusing dangerous layouts rather than trying too
hard to support cumbersome things that are 99% of the times issues :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4bzhvGr7W6HudhwRAmtKAJsEJDFwTnB1PzfjcxoDRx+1/+Hq6wCdHsnT
RqA9bP2tvam8C6Xjjlpv2IQ=
=ufAP
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
