From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] files given on the command line are relative to $cwd
Date: Wed, 06 Aug 2008 22:40:02 +0200
Message-ID: <20080806204002.GB903@artemis.madism.org>
References: <48997D2E.9030708@obry.net> <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net> <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net> <7vy73aqe9m.fsf@gitster.siamese.dyndns.org> <7vr692oufw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PmA2V3Z32TCmWXqI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git list <git@vger.kernel.org>,
	Luciano Rocha <luciano@eurotux.com>, pascal@obry.net,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQpom-0001gk-1w
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 22:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757664AbYHFUkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 16:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756975AbYHFUkH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 16:40:07 -0400
Received: from pan.madism.org ([88.191.52.104]:43960 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649AbYHFUkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 16:40:05 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 17CB03D743;
	Wed,  6 Aug 2008 22:40:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B724835561D; Wed,  6 Aug 2008 22:40:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr692oufw.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91539>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2008 at 06:43:47PM +0000, Junio C Hamano wrote:
> When running "git commit -F file" and "git tag -F file" from a
> subdirectory, we should take it as relative to the directory we started
> from, not relative to the top-level directory.
>=20
> This adds a helper function "parse_options_fix_filename()" to make it more
> convenient to fix this class of issues.  Ideally, parse_options() should
> support a new type of option, "OPT_FILENAME", to do this uniformly, but
> this patch is meant to go to 'maint' to fix it minimally.

  I'm going in vacation tomorrow so I'm not likely to do that soon, but
I agree it's sensible.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiaDCIACgkQvGr7W6HudhxLHQCgqmDGcPd9d6mqIE0tYpYn/nDy
K2YAoIGztFgt8WUjzNkPIJQE0zt+9x9X
=Lzwz
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
