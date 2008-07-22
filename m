From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Enable threaded delta search on *BSD and Linux.
Date: Tue, 22 Jul 2008 08:51:25 +0200
Message-ID: <20080722065125.GA8331@artemis.madism.org>
References: <1216632223-14655-1-git-send-email-madcoder@debian.org> <7vwsjeplhl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="7JfCtLOvnd9MIVvH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLBji-0007Ll-Gx
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYGVGvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 02:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbYGVGvg
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:51:36 -0400
Received: from pan.madism.org ([88.191.52.104]:38698 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbYGVGvf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 02:51:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3B40934F2C;
	Tue, 22 Jul 2008 08:51:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 71C0329EA53; Tue, 22 Jul 2008 08:51:25 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsjeplhl.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89448>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2008 at 04:54:14AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >
> >   Following the discussion we had 10 days ago, here is a proposal to en=
able
> >   threaded delta search on systems that are likely to behave properly w=
rt
> >   memory and CPU usage.
>=20
> Hmmm.
>=20
> I do not want to do this kind of thing very close to the release (like
> now), but rather immediately after 1.6.0.  Will queue for 'next'.
>=20
> Distro people can decide for themselves and their users, but I am of
> conservative kind.

  makes sense to me.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiFg2sACgkQvGr7W6HudhxlcACeNcweIu6QlR1c8FgbW4q0JbtE
Im8Anj7DBK8BDOCtYIKf6iSoKQNsG7E3
=h7Mg
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
