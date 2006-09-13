From: Keith Packard <keithp@keithp.com>
Subject: Re: [Monotone-devel] cvs import
Date: Wed, 13 Sep 2006 16:42:01 -0700
Message-ID: <1158190921.29313.175.camel@neko.keithp.com>
References: <45084400.1090906@bluegap.ch>
	 <20060913225200.GA10186@frances.vorpus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LDdf3jiM9Fu7pYBvKVdh"
Cc: keithp@keithp.com, Markus Schiltknecht <markus@bluegap.ch>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 01:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNeN6-0005Kx-1a
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 01:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWIMXmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWIMXmV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 19:42:21 -0400
Received: from home.keithp.com ([63.227.221.253]:2315 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751246AbWIMXmU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 19:42:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 1E67D130024;
	Wed, 13 Sep 2006 16:42:09 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xCxx5Nj5zHxJ; Wed, 13 Sep 2006 16:42:05 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 1663D13001F; Wed, 13 Sep 2006 16:42:04 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id EEFEE14001;
	Wed, 13 Sep 2006 16:42:04 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id B0B445428F; Wed, 13 Sep 2006 16:42:02 -0700 (PDT)
To: Nathaniel Smith <njs@pobox.com>
In-Reply-To: <20060913225200.GA10186@frances.vorpus.org>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26964>


--=-LDdf3jiM9Fu7pYBvKVdh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-13 at 15:52 -0700, Nathaniel Smith wrote:

> Regarding the basic dependency-based algorithm, the approach of
> throwing everything into blobs and then trying to tease them apart
> again seems backwards.  What I'm thinking is, first we go through and
> build the history graph for each file.  Now, advance a frontier across
> the all of these graphs simultaneously.  Your frontier is basically a
> map <filename -> CVS revision>, that represents a tree snapshot.=20

Parsecvs does this, except backwards from now into the past; I found it
easier to identify merge points than branch points (Oh, look, these two
branches are the same now, they must have merged).

However, this means that parsecvs must hold the entire tree state in
memory, which turned out to be its downfall with large repositories.
Worked great for all of X.org, not so good with Mozilla.

--=20
keith.packard@intel.com

--=-LDdf3jiM9Fu7pYBvKVdh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFCJdJQp8BWwlsTdMRAuyWAKCShRQ+VlzXgjFiEI9NTOPGe6dlzwCfSMjO
T1HF0rtRXY7M7DL3lCjyuQI=
=GAzo
-----END PGP SIGNATURE-----

--=-LDdf3jiM9Fu7pYBvKVdh--
