From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-opt: bring PARSE_OPT_HIDDEN to git-rev-parse  --parseopt
Date: Sun, 24 Feb 2008 09:49:58 +0100
Message-ID: <20080224084953.GA7623@artemis.madism.org>
References: <20080221230101.27644.49229.stgit@gandelf.nowhere.earth> <20080222093558.GC29114@artemis.madism.org> <7vbq68ap1c.fsf@gitster.siamese.dyndns.org> <20080222181927.GA4555@artemis.madism.org> <20080223140926.GD10967@artemis.madism.org> <7vbq66ycct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qDbXVdCdHGoSgWSk";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:50:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTCZF-0002sO-VK
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbYBXIuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbYBXIuF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:50:05 -0500
Received: from pan.madism.org ([88.191.52.104]:34397 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbYBXIuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:50:03 -0500
Received: from madism.org (ctse34.ulb.ac.be [164.15.3.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 57B3C26AD3;
	Sun, 24 Feb 2008 09:50:01 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0229753755B; Sun, 24 Feb 2008 09:49:58 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbq66ycct.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74913>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2008 at 08:42:26AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >       I also made the parsing more extensible wrt new flags if needed.
> >
> >       We should definitely write tests too.
> > ...
> > +			case '*':
> > +				o->flags &=3D PARSE_OPT_HIDDEN;
> > +				break;
>=20
> I have a slight suspicion that this is not what you meant.
> You probably meant either |=3D or perhaps ^=3D.

  oooh boy of course it's a |=3D...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwS+xvGr7W6HudhwRAj4cAJ97CwJY0lBfz1m62TLBXIqE8OL3mgCghrwe
gEsfya9fUZTWaEb3O7ZThzk=
=FgM3
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
