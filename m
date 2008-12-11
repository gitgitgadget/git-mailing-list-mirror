From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted .git/objects/pack))
Date: Wed, 10 Dec 2008 19:03:53 -0600
Message-ID: <200812101903.58980.bss03@volumehost.net>
References: <1228867861.14165.19.camel@starfruit.local> <1228949523.27061.20.camel@starfruit.local> <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3840698.OFGW6FlOrF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 02:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZzP-0004dE-Ei
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 02:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbYLKBD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 20:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbYLKBD4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 20:03:56 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60788 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYLKBD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 20:03:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081211010354.KBSB2342.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Dec 2008 20:03:54 -0500
Received: from [10.0.0.123] ([72.204.50.125])
	by fed1rmimpo01.cox.net with bizsmtp
	id pd3u1a0032i4SyG03d3ugB; Wed, 10 Dec 2008 20:03:55 -0500
X-Authority-Analysis: v=1.0 c=1 a=z6zUUghr1H4A:10 a=Nvmop8DIsoEA:10
 a=nEQGfrJnAAAA:8 a=z18a5qkaNK_4w2E6jZoA:9 a=3RBEwtYs0U3_e-v5neggFnM8-OMA:4
 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=DYF0OqecL0PKz01nnx0A:9
 a=XAxze4G7GJXZWpnbZE7dtjWqcH0A:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102761>

--nextPart3840698.OFGW6FlOrF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2008 December 10 17:40:28 Linus Torvalds wrote:
>On Wed, 10 Dec 2008, R. Tyler Ballance wrote:
>Anyway, that's a really annoying problem, and it's a bug in git.
>
>That stupid fsck commit walker walks the parents recursively.
>
>And judging by the fact that gdb also SIGSEGV's for you when
>doing the backtrace, it looks like the gdb backtrace tracer is _also_
>recursive, and _also_ hits the same issue ;)
>
>So you have definitely found a real bug.
>
>But we should definitely fix this braindamage in fsck. Rather than
>recursively walk the commits, we should add them to a commit list and just
>walk the list iteratively.

Suppose I fixed this tonight.  Would you need anything other than a patch=20
(series) from me?  (E.g. copyright assignment or something else legal [vs.=
=20
technical])
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart3840698.OFGW6FlOrF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklAZv4ACgkQdNbfk+86fC2HXACfev9ByrYD+UFfSs9zBtG/HRJc
IpsAn3hjGihozxMnydfAOvvrZ/U7HRNu
=uKBm
-----END PGP SIGNATURE-----

--nextPart3840698.OFGW6FlOrF--
