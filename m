From: Jan Hudec <bulb@ucw.cz>
Subject: Re: new to git
Date: Wed, 5 Sep 2007 07:56:59 +0200
Message-ID: <20070905055659.GF3786@efreet.light.src>
References: <46D32973.8030104@krose.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Cc: git mailing list <git@vger.kernel.org>
To: Kyle Rose <krose@krose.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 07:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISntT-0000KA-J8
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 07:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbXIEF5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 01:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbXIEF5J
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 01:57:09 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:49174 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbXIEF5I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 01:57:08 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5577257510;
	Wed,  5 Sep 2007 07:57:07 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id yIcZkpO8pcov; Wed,  5 Sep 2007 07:57:01 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 40644574BA;
	Wed,  5 Sep 2007 07:57:01 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ISnsp-0006Aq-Ki; Wed, 05 Sep 2007 07:56:59 +0200
Content-Disposition: inline
In-Reply-To: <46D32973.8030104@krose.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57668>


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2007 at 15:43:47 -0400, Kyle Rose wrote:
> After many years of dissatisfaction with the limitations of CVS, and
> after getting fed up with the complexity of configuring and maintaining
> a SVN setup, I just started using git for my own personal projects.  I
> have to say it's quite nice and fits the UNIX philosophy well: fast,
> simple, powerful.
>=20
> I've been playing with it for a few weeks and generally understand what
> is going on, but I do have a few usage questions that I couldn't find
> answered in the docs:
>=20
> (1) Let's say I:
>=20
> git clone something
> git branch foo
> git checkout foo
> <make some changes>
> git commit -a
> git checkout master
> git pull . foo

git merge foo

would be probably both clearer about the intent and more efficient here.
After all, pull is just a simple wrapper for fetch + merge and you don't ne=
ed
the fetch from the repository to itself.

> git push
> git pull

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3kUrRel1vVwhjGURAvsvAKDE8tzjicrhN3ktBcPpm2uv0shvhQCgtXmF
sQ0oMxsEVT55yJlwf2SMk7k=
=h1yJ
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
