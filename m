From: Keith Packard <keithp@keithp.com>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 11:59:27 -0700
Message-ID: <1150311567.30681.28.camel@neko.keithp.com>
References: <1150269478.20536.150.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>
	 <1150307715.20536.166.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7GK/B1g/cdKsp05H5SBs"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 21:00:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqaaw-0002CE-1r
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 21:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWFNS7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 14:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWFNS7x
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 14:59:53 -0400
Received: from home.keithp.com ([63.227.221.253]:26893 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750751AbWFNS7w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 14:59:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 7DBE213001F;
	Wed, 14 Jun 2006 11:59:51 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05832-04-2; Wed, 14 Jun 2006 11:59:51 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 436E713001E; Wed, 14 Jun 2006 11:59:51 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 0A19714001;
	Wed, 14 Jun 2006 11:59:50 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 01F136AC439; Wed, 14 Jun 2006 11:59:28 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21852>


--=-7GK/B1g/cdKsp05H5SBs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-14 at 11:18 -0700, Linus Torvalds wrote:

> You don't _need_ to shuffle. As mentioned, it will only affect the=20
> location of the data in the pack-file, which in turn will mostly matter=20
> as an IO pattern thing, not anything really fundamental.  If the pack-fil=
e=20
> ends up caching well, the IO patterns obviously will never matter.

Ok, sounds like shuffling isn't necessary; the only benefit packing
gains me is to reduce the size of each directory in the object store;
the process I follow is to construct blobs for every revision, then just
use the sha1 values to construct an index for each commit. I never
actually look at the blobs myself, so IO access patterns aren't
relevant.

Repacking after the import is completed should undo whatever horror show
I've created in any case.

--=20
keith.packard@intel.com

--=-7GK/B1g/cdKsp05H5SBs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkFyPQp8BWwlsTdMRAsPPAJ47u+v1R8ZWXvfwIrXkTxe5rtR2ewCeOyow
N7KfmMPby36RQcJN3VV0F3w=
=A/mz
-----END PGP SIGNATURE-----

--=-7GK/B1g/cdKsp05H5SBs--
