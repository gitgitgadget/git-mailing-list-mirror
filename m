From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 17:12:56 -0800
Message-ID: <20140106011255.GM3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net>
 <20140105212458.GG3156@odin.tremily.us>
 <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 02:13:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzyka-0006zi-0I
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 02:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaAFBM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 20:12:59 -0500
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:40061
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318AbaAFBM7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 20:12:59 -0500
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id AQK61n0060SCNGk5ARCyGJ; Mon, 06 Jan 2014 01:12:58 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id ARCw1n00R152l3L3VRCxCd; Mon, 06 Jan 2014 01:12:58 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 2AF77E8C047; Sun,  5 Jan 2014 17:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388970776; bh=Tqt3j/BErt5kjXaEzOBeWBVNEWWZwIMqvO/evHpPWwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M0WAPK0IB3uGRTfKjMKJYo+Glpr92hdRBTnQYH6SR/svFR3E4Qd3ZO1QpNOWcX81c
	 meXCUEnA8eC53F6ltgDTyHXu03yQc1rcDbCFtlq7Jj0YvZJE7q9bYXWP6H+mvAG3Qy
	 m+HgDcIvZV70wgX9/L4W8IR1DSYW5lN/Evc1X9zA=
Content-Disposition: inline
In-Reply-To: <20140106003314.GL3156@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388970778;
	bh=xAcB9THs3Qei7jaWqjbrdxY8vMBRUJ7c4sJc/D5tPSQ=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=bdeqCI4OblXrn5A9uggcc+G/jpU1oHPjW6yhIp5h3lJ4bsPf65D8BYPmzXTJZ7KOD
	 mGn+MlOEU62b3eYxkfSKO9Ssf6xTL+mJB9wSFWL6eQ6KSq2CmTKsk+VZpP4UuFB3pr
	 Y8B5kaDOgHV85DyisU3VJkZAqn3IL6Fakf7E/rZ659aS0H5nWt2QNKMK3PsF65dyfz
	 8KWqjv9N2WVAoHAqo51HKYjQEsBkzQrJHaS1CuOSDxordSMzytse9xUgRgcLJytCJ1
	 fXXAqyXlJgXWQ1VqcizOSJrnp8KK2/4fT8YamKM/PMQKbOE4pLz6tM5Jp9+zYrrgzQ
	 sM3HntpaR3lDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239985>


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 04:33:14PM -0800, W. Trevor King wrote:
> The only people who would need *automatic* rebase recovery would be
> superproject devs update-cloning the subproject.  That's a small
> enough cross-section that I don't think it deserves the ambiguity of
> gitlink-to-reference.  In that case, all you really need is a way to
> force a recovery gitlink (i.e. add a 'commit' object to the tree by
> hand).

Actually, you recovering by hand is a lot easier.  Setup a
rebased-away gitlink target:

  mkdir subproject &&
  (
    cd subproject &&
    git init
    echo 'Subproject' > README &&
    git add README &&
    git commit -m 'Subproject v1' &&
    echo 'Changes' >> README &&
    git commit -am 'Subproject v2'
  ) &&
  mkdir superproject &&
  (
    cd superproject &&
    git init
    git submodule add ../subproject &&
    git commit -m 'Superproject v1'
  ) &&
  (
    cd subproject &&
    git reset --hard HEAD^ &&
    git reflog expire --expire=3Dnow --all &&
    git gc --aggressive --prune=3Dnow
  )

Then a recursive clone of the superproject dies:

  $ git clone --recursive superproject super2
  Cloning into 'super2'...
  done.
  Submodule 'subproject' (/tmp/x/subproject) registered for path 'subprojec=
t'
  Cloning into 'subproject'...
  done.
  fatal: reference is not a tree: f589144d16282d1a80d17a9032c6f1d332e38dd0
  Unable to checkout 'f589144d16282d1a80d17a9032c6f1d332e38dd0' in submodul=
e path 'subproject'

But you still have the submodule checkout (up until the $sha1 setup):

  $ cd super2
  $ git diff
  diff --git a/subproject b/subproject
  index f589144..82d4553 160000
  --- a/subproject
  +++ b/subproject
  @@ -1 +1 @@
  -Subproject commit f589144d16282d1a80d17a9032c6f1d332e38dd0
  +Subproject commit 82d4553fe437ae014f22bbc87a082c6d19e5d9f9-dirty

And you can automatically update to match the upstream remote:

  $ git submodule update --remote --force
  Submodule path 'subproject': checked out '82d4553fe437ae014f22bbc87a082c6=
d19e5d9f9'
  $ git diff
  diff --git a/subproject b/subproject
  index f589144..82d4553 160000
  --- a/subproject
  +++ b/subproject
  @@ -1 +1 @@
  -Subproject commit f589144d16282d1a80d17a9032c6f1d332e38dd0
  +Subproject commit 82d4553fe437ae014f22bbc87a082c6d19e5d9f9

When explicitly updating to the superproject or subproject's
(--remote) new tip is so easy, I don't see a need for floating the
gitlinks themselves.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSygMWAAoJEKKfehoaNkbt2n8P/2Xvp7KJenlb4TNU/4ufa6ju
xdQezdOS28uYJezDRVfCJbN1KuIVFk/Ez/NQd6rALFiFfckcmZoVTTb2PVhfVdtT
inc6p++f9D6MoxfITR2ognyZ14rLUOmaa74HPqyadR1kwyH+G2vZDn4Eb+hyiSu3
qMdPCkpp5Zo5SptNDI6j3lPEI9v9rEf+OE2TK6f3tzCKTiaqQEg05rSbtl9jYGp/
xfst6j0y19GEDCH+ofN8CInIqPiAL+wquK9VKVHU0HzLV85UATnm0STvcJSfWavJ
901oZnNjM8ZWy3GBxc4ZuVczLJ6EZLMV+x0q1pBNwwbA4zk355cZOmxtZTHAHD3h
D/mxnFbOdW6TY7aYNuwOf0WOW9CQjw5xWVQluorKWywuHHnhtXtyk5jPJ82rUiea
3on1ACwjZpeNIMro2P9eQrlcm+KXOIJ4WOgVRNm/F40n49Pg04AFygASECDfMrAb
34JqRJXI6uiJ5QWsD1FaqSkHq7bLBvEtbcBvNAt/z0iAAZ1eDfqOxZUqn9DLdXm0
cMi4t+shkmDKgDFRsLa09J9/ba4iOu7VrC5/COxdazuC7SR8Jhc5jXTKyI/vM/AS
u52ePqocRr2mFp1Nr6AbWR8MURwO/okbH9gO5VNoLgxDC5PTERMIU4kW7pKYRgld
ysWzd0lhJUMztjqiXZEY
=FDrh
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--
