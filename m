From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted .git/objects/pack))
Date: Wed, 10 Dec 2008 22:00:54 -0600
Message-ID: <200812102200.59820.bss03@volumehost.net>
References: <1228867861.14165.19.camel@starfruit.local> <alpine.LFD.2.00.0812102031440.14328@xanadu.home> <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1386855.T3lyNHfthL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 05:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAcky-00071f-Jf
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 05:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbYLKEBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 23:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbYLKEA7
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 23:00:59 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42445 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbYLKEA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 23:00:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081211040058.SYRR2342.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Dec 2008 23:00:58 -0500
Received: from [10.0.0.123] ([72.204.50.125])
	by fed1rmimpo02.cox.net with bizsmtp
	id pg0x1a0092i4SyG04g0xd5; Wed, 10 Dec 2008 23:00:58 -0500
X-Authority-Analysis: v=1.0 c=1 a=z6zUUghr1H4A:10 a=Nvmop8DIsoEA:10
 a=gu6fZOg2AAAA:8 a=nEQGfrJnAAAA:8 a=pk-JEowyX2zNJSrnjugA:9
 a=TKOPGdU9IvhwR-lfkNczV9tJVBYA:4 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10
 a=D2dWcbkqGdQcu6NT3AwA:9 a=f3jqUWSCmsz3GFpI_ix4XhtB2eMA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0812101854230.3340@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102772>

--nextPart1386855.T3lyNHfthL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2008 December 10 21:28:15 Linus Torvalds wrote:
>On Wed, 10 Dec 2008, Nicolas Pitre wrote:
>> 	http://marc.info/?l=3Dgit&m=3D122889563424786&w=3D2
>
>Not very pretty. The basic notion is ok, but wouldn't it be nicer to at
>least use a "struct object_array" instead?

As Junio pointed out, we may want to make similar changes with other calls =
in=20
fsck_walk with the function itself as a callback.  It might even make sense=
=20
to have a fsck_walk_full that handles managing the object_array itself.

While we are making changes, there appears to be a copy and paste error fro=
m=20
line 74 to line 76 -- the second "broken link from" should probably be "   =
          =20
to".

I'd have already submitted a patch for that, but I can't figure out how to=
=20
tell kmail to not do quoted-printable.  :(  [And, if I can beat this client=
=20
into submission I will.]

Linus, sorry about the reply with no snipping or original content.  I=20
mis-clicked. :(
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart1386855.T3lyNHfthL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklAkHsACgkQdNbfk+86fC1qKwCdF1zzeX7YKqbxacWBbJlazyHO
a08An2IFMlSYDXhtUvx8TIU9txWtQnsw
=5XFO
-----END PGP SIGNATURE-----

--nextPart1386855.T3lyNHfthL--
