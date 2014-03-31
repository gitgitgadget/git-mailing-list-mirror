From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from
 master to HEAD
Date: Mon, 31 Mar 2014 13:38:25 -0700
Message-ID: <20140331203825.GH19236@odin.tremily.us>
References: <20140328030556.GD25485@odin.tremily.us>
 <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
 <5339C36B.5020502@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 22:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUiyY-0001HO-F0
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 22:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbaCaUi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 16:38:29 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:56295
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987AbaCaUi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 16:38:28 -0400
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id kKnH1n0060xGWP853LeU8j; Mon, 31 Mar 2014 20:38:28 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id kLeS1n00Q152l3L3YLeTmN; Mon, 31 Mar 2014 20:38:28 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 950C210E9936; Mon, 31 Mar 2014 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1396298305; bh=R3s3SOMwOgdZhdLet5L93ugbP1qvdjOysLQnFU4sQQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dgdT3QbKG3p1DW8RDbRgIFsPw73qHv5duCQ+fY7jaQjJV3oH4ja1zZoZ8g85OEVFv
	 X8gr/n/P0DcSs2j2E2tVN+V2+Q6Z2FYrbhmDppaAVoqkyhRmfmJ4GYOkT6WY3cdscY
	 7eizLpq+JfHDhgFMHMkVZCL28qb7ZDKBFMXaIZ9c=
Content-Disposition: inline
In-Reply-To: <5339C36B.5020502@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1396298308;
	bh=epzV6QfcfJ6BP1qipbIOIGRw0BE8bv+lu2hbspqe910=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=I/LOdQC4WOYDCNiq+jZutxjwaF1beMsyMErxKM7dRGA+qWnjQ8OptBpLJv8Jv9Kc/
	 w7Nof1dRHV59+YXHi9ghO8glmPEUOSwyXOEgqaJdHL2NnJlJcMZ8PgmM9umGDbCrnv
	 2/nuKxUa30jEL0ZL2a1lrcOh9C/p5OpRpUaocH2PJB/KR+fuAgLwuCSAHxdyeUIMpT
	 n1CCGYb86pvhQxifV14b5XF88XBeW7yMyW7aCPdSWs3OxAT6Id17s+VqmYyMBwJicO
	 jvLrezW/B6qkQU8baakJlJhmU2YIU/EOOjbloCHQEnaSimSscXp50ua1yo7aBBsOtA
	 LEWkJpm2HluJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245524>


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 09:35:07PM +0200, Jens Lehmann wrote:
> Am 28.03.2014 04:36, schrieb W. Trevor King:
> > The main drawback to this approach is that we're changing a default,
> > but I agree with John's:
> >=20
> > On Fri, Mar 28, 2014 at 12:21:23AM +0100, Johan Herland wrote:
> >> I expect in most cases where "origin/master" happens to be the
> >> Right Answer, using the submodule's upstream's HEAD will yield
> >> the same result.
> >=20
> > so the default-change may not be particularly intrusive.
>=20
> I'd prefer a solution that doesn't change any defaults for the
> checkout use case (again). Maybe it is a better route to revert
> this series, then add tests describing the current behavior for
> checkout submodules as a next step before adding the branch mode
> for rebase and merge users again?

The change in defaults should only adversely effect users who:

* don't configure submodule.<name>.branch,
* use --remote updates,
* expect them to pull the master branch of the submodule's upstream, and
* have an upstream whose HEAD doesn't point at master.

Since 23d25e4 (submodule: explicit local branch creation in
module_clone, 2014-01-26), we adversely effects users (regardless of
update strategy) who:

* don't configure submodule.<name>.branch, and
* update-clone from a submodule upstream that doesn't have a master branch.

But with this patch we'll fix that.  Before 23d25e4, we adversly
affected users who:

* used non-checkout update strategies, and
* wanted an attached HEAD after update-clones.

All of these were easy to work around, with either:

  $ git config submodule.$name.branch $branch

or:

  $ cd $submod
  $ git checkout $branch

I'm fine reverting 23d25e4 if we want to kick it around some more, but
I have trouble imagining a future UI that works for both:

* users that want --remote to pull master even though upstream's HEAD
  points elsewhere, and
* users that want --remote to pull HEAD because upstream doesn't have
  a master branch,

if neither of those users are willing to configure an explicit
submodule.<name>.branch.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOdI/AAoJEKKfehoaNkbtY8wP/i887Jdyo5VEkvpi+96YeKSd
QgOaPy20Eb9CQp4XzSGFK/TEpRjuuHBZRfMYzWHJGllh+xQk7YGglccBkbW1vfjV
Fd4plDSKtkpFDFWjeLVWdVd/LMYyvZeGGVdQDjuTQdDA7MuR79lv/vDQ0Chky3aT
7BDJSuNNeCiQtZ9Pp2YnuuZoi6hbrk8ozxf8wef0ANrcw04jmW394qKGD8yMfUf8
xGA/s3cYDpTCT3bCSjLlhuM2dAbDZLhQY5zfWzWGplM+/HqET6inXe6BXNHhj9tn
4W4Wt9BIIw2lI8JP5PXiEkZk7jRB7J2dL70LPqE7kgNu/Y5IjwVkbnxHfV/bc8qJ
2QJpXM0D8pW2bY0GxfYfMTM4qYulQQHJxLN6waCX61Z8xRU6ag0l4jlGavt4llhN
bCHJbt4t2I6dyyDwhnBwPHGH+mRpPjAdK+juKBGAzj9BJyVMyzPKpe2KGdv0qy9Y
lIhhnsxB/qM7RyUELItwNAFw1qkZ/15ma197A2g4eUxOSwgs5Q5A0xa+MwFdvfYK
9aZ5p46X0ZG9fgTDid/EI1HkrjxUR1i7/pF1UVud37+IIadOgKMChXRWKGOklOW2
kxGqm2MAwHiQd/zPvtwxeL0w0f3G/+oKNFR148t8tj+kY6swUcAdQ59PxknVqQso
T9bPDu3vU/DrlGv8UTKo
=4kDW
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
