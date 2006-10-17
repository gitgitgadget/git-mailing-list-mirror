From: Robert Collins <robertc@robertcollins.net>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 19:33:19 +1000
Message-ID: <1161077599.9020.66.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	 <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sFgYm/ThIXX+fv8ZI+M/"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 11:33:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlKG-0007yS-MC
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 11:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWJQJd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 05:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWJQJd3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 05:33:29 -0400
Received: from ipmail01.adl2.internode.on.net ([203.16.214.140]:62344 "EHLO
	ipmail01.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1161016AbWJQJd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 05:33:28 -0400
Received: from ppp245-86.static.internode.on.net (HELO lifelesswks.robertcollins.net) ([59.167.245.86])
  by ipmail01.adl2.internode.on.net with ESMTP; 17 Oct 2006 19:03:25 +0930
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CACc+NEU
X-IronPort-AV: i="4.09,319,1157293800"; 
   d="asc'?scan'208"; a="30733110:sNHT82242741"
Received: from [192.168.1.5] (helo=lifelesslap.robertcollins.net)
	by lifelesswks.robertcollins.net with esmtpa (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1GZlK2-0000I8-Qt; Tue, 17 Oct 2006 19:33:18 +1000
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1GZlK4-0004Px-IG; Tue, 17 Oct 2006 19:33:20 +1000
To: "bazaar-ng@lists.canonical.com" <bazaar-ng@lists.canonical.com>
In-Reply-To: <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29041>


--=-sFgYm/ThIXX+fv8ZI+M/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 01:45 +0200, Johannes Schindelin wrote:
>=20
> If you really, really think about it: it makes much more sense to
> record=20
> your intention in the commit message. So, instead of recording for
> _every_=20
> _single_ file in folder1/ that it was moved to folder2/, it is better
> to=20
> say that you moved folder1/ to folder2/ _because of some special
> reason_!

Just a small nit here: bzr does /not/ record the move of every file: it
records the rename of folder1 to folder2. One piece of data is all thats
recorded - no new manifest for the subdirectory is needed.

Of course, a user can choose to move all the contents of a folder and
not the folder itself - its up to the user.

By recording the folder rename rather than the contents rename, we get
merges of new files added to folder1 in other branches come into folder2
automatically, without needing to do arbitrarily deep history processing
to determine that.

This also does not prevent us doing history analysis as well, to
determine other interesting things - such as cross file 'blame' as has
been mentioned in this thread.=20

-Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-sFgYm/ThIXX+fv8ZI+M/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNKNfM4BfeEKYx2ERAjfIAKCOX9mA9AYCALHE0+6TFhxG2I0/iwCfYIry
ZKysrYTvuZUQLb8F1MRSER0=
=tPKe
-----END PGP SIGNATURE-----

--=-sFgYm/ThIXX+fv8ZI+M/--
