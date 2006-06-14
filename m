From: Keith Packard <keithp@keithp.com>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 10:55:15 -0700
Message-ID: <1150307715.20536.166.camel@neko.keithp.com>
References: <1150269478.20536.150.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N2g6fLL2eyNmes9X0DOw"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 19:59:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqZeU-00082D-BT
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 19:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWFNR7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 13:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWFNR7e
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 13:59:34 -0400
Received: from home.keithp.com ([63.227.221.253]:35851 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751160AbWFNR7e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 13:59:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id B0E3213001F;
	Wed, 14 Jun 2006 10:59:31 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05343-01-2; Wed, 14 Jun 2006 10:59:31 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 4F5E313001E; Wed, 14 Jun 2006 10:59:31 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id EFFCE14002;
	Wed, 14 Jun 2006 10:59:30 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id E4C866AC43A; Wed, 14 Jun 2006 10:55:17 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21849>


--=-N2g6fLL2eyNmes9X0DOw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-14 at 08:53 -0700, Linus Torvalds wrote:

>  - You can list the objects with "most important first" order first, if=20
>    you can.  That will improve locality later (the packing will try to=20
>    generate the pack so that the order you gave the objects in will be a=20
>    rough order of the resul - the first objects will be together at the=20
>    beginning, the last objects will be at the end)

I take every ,v file and construct blobs for every revision. If I
understand this correctly, I should be shuffling the revisions so I send
the latest revision of every file first, then the next-latest revision.
It would be somewhat easier to just send the whole list of revisions for
the first file and then move to the next file, but if shuffling is what
I want, I'll do that.

>    The corollary to this is that it's better to generate the pack-file=20
>    from a list of every version of a few files than it is to generate it=20
>    from a few versions of every file. Ie, if you process things one file=20
>    at a time, and create every object for that file, that is actually goo=
d=20
>    for packing, since there will be the optimal delta opportunity.

I assumed that was the case. Fortunately, I process each file
separately, so this matches my needs exactly. I should be able to report
on this shortly.

--=20
keith.packard@intel.com

--=-N2g6fLL2eyNmes9X0DOw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkE2DQp8BWwlsTdMRAsCWAKCpIDfNBI5w24f7KDFJ9EOwb8mQtwCfYMaX
w7N/vk0fmkRIHjN7csCADQU=
=aYUL
-----END PGP SIGNATURE-----

--=-N2g6fLL2eyNmes9X0DOw--
