From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git push (mis ?)behavior
Date: Wed, 03 Oct 2007 09:35:54 +0200
Message-ID: <20071003073554.GA8110@artemis.corp>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OXfL5xGRrasGEqWY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 09:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icymn-0001Ye-K9
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 09:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXJCHgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 03:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXJCHgE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 03:36:04 -0400
Received: from pan.madism.org ([88.191.52.104]:44466 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbXJCHgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 03:36:01 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 18F8522E60;
	Wed,  3 Oct 2007 09:35:54 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 426FA359B4D; Wed,  3 Oct 2007 09:35:54 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Miles Bader <miles@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <buoprzwn5qm.fsf@dhapc248.dev.necel.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59800>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 05:10:09AM +0000, Miles Bader wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I think it is sensible to have an option to make it push only the
> > current branch.  I am not sure if it is sensible to make that the
> > default.
>=20
> I really like the current default, it matches my mental model well:  I
> generally use "push" to mean "synchronize the remote repository with my
> current one"; if multiple branches have changed, I want those changes
> propagated too.

  I understand that =E2=80=A6 and I know some people rely on the current
behavior=E2=80=A6

> I think changing it would be a bad idea, it just seems a pointlessly
> incompatible change.

  There definitely is a point: with the current behaviour you sometimes
end up pushing more than what you meant, with sometimes WIP that you
intend to rebase, and it hurts. Git porcelains should help you avoid to
shoot yourself in the foot, hence I think that (especially to git
newcomers), the current default _is_ dangerous.

  Though, OTOH, I believe that git push <remote> could keep the current
behavior. I'm also okay with the fact that git push could be
configurable in that regard.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHA0ZavGr7W6HudhwRApcUAJ0VYeoDjYKMfYByJsA+v9h2zD+6WQCgpDvf
zmkF3HQzAEe8lTuCaYrhlpY=
=qTNZ
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
