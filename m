From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a pack file
Date: Wed, 7 Jan 2009 20:52:54 -0600
Message-ID: <200901072053.00492.bss@iguanasuicide.net>
References: <20081209093627.77039a1f@perceptron> <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain> <885649360901071821t2ea481b5k83ab800f6aeb897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2339357.pePy5STpr4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git ML" <git@vger.kernel.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Jan =?utf-8?q?Kr=C3=BCger?=" <jk@jk.gs>, kb@slide.com,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "James Pickens" <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 03:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKl1u-0004VE-4u
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbZAHCwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 21:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbZAHCwa
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 21:52:30 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:38098 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbZAHCw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 21:52:29 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LKl0V-0006wx-Bi; Thu, 08 Jan 2009 02:52:27 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <885649360901071821t2ea481b5k83ab800f6aeb897@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104878>

--nextPart2339357.pePy5STpr4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2009 January 07 20:21:18 James Pickens wrote:
>On Wed, Jan 7, 2009, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> Can you cnfirm that your "reproducible" case starts working with that
>> addition to your ~/.gitconfig? If so, the solution is pretty simple: we
>> should just lower the default pack windowsize.
>
>Umm... isn't that more of a workaround than a solution?  I.e., if you lower
>the default pack windowsize, couldn't the corruption still happen under the
>right conditions?

IMHO:
I agree, somewhat.  I'm fine with a "die()" message when there's not enough=
=20
memory, but either corruption or just a spurious, but scary "<SHA> is=20
corrupt" messages should be fixed.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2339357.pePy5STpr4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllaowACgkQdNbfk+86fC2VRwCfTUr0EwCMw9V5QyaXLXe6CY+H
SL8An1f2NGiZ2OpTV51L75FIbBb1yV9X
=Fa8A
-----END PGP SIGNATURE-----

--nextPart2339357.pePy5STpr4--
