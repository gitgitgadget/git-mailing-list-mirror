From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Add a documentat on how to revert a faulty merge
Date: Sat, 20 Dec 2008 16:12:33 -0600
Message-ID: <200812201612.37455.bss@iguanasuicide.net>
References: <20081220202702.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3409644.548nd8MPUH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 23:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEA4v-0001Gi-Fw
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 23:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYLTWM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 17:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbYLTWM1
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 17:12:27 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:46262 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYLTWM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 17:12:26 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEA3b-0008W0-J5; Sat, 20 Dec 2008 22:12:23 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <20081220202702.6117@nanako3.lavabit.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103670>

--nextPart3409644.548nd8MPUH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2008 December 20 05:27:02 Nanako Shiraishi wrote:
> +Date: Fri, 19 Dec 2008 00:45:19 -0800
> +From: Linus Torvalds <torvalds@linux-foundation.org>, Junio C Hamano
> <gitster@pobox.com> +Subject: Re: Odd merge behaviour involving reverts
> +Abstract: Sometimes a branch that was already merged to the mainline
> + is later found to be faulty.  Linus and Junio give guidance on
> + recovering from such a premature merge and continuing development
> + after the offending branch is fixed.
> +Message-ID: <7vocz8a6zk.fsf@gitster.siamese.dyndns.org>
> +References: <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
> +
> +Alan <alan@clueserver.org> said:

I don't like the email headers as part of the documentation.  It would be=20
better to have a title and abstract in prose.

Also, your email gave me some errors from 'git am':
=2Edotest/patch:40: indent with spaces.
               /
=2Edotest/patch:57: indent with spaces.
               /
=2Edotest/patch:91: indent with spaces.
               /
=2Edotest/patch:103: indent with spaces.
               /
=2Edotest/patch:110: indent with spaces.
               /                       /
warning: squelched 3 whitespace errors
warning: 8 lines add whitespace errors.

Those errors aside, I think it's better formatted than what I had ready.  I=
=20
also think it would be nice to also modify the git-revert manpage to=20
reference this documentation in the description on the -m option.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3409644.548nd8MPUH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklNbdUACgkQdNbfk+86fC1oUgCcC6YGgoo8fRBqhrEMISBO/59f
5dIAn1Ob79J4WCR8Xv+lzRuUGn41gVIO
=mPuc
-----END PGP SIGNATURE-----

--nextPart3409644.548nd8MPUH--
