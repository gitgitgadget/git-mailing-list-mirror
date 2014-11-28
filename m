From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Our cumbersome mailing list workflow
Date: Fri, 28 Nov 2014 16:24:26 +0000
Message-ID: <20141128162425.GE4744@vauxhall.crustytoothpaste.net>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <546F4B5B.2060508@alum.mit.edu>
 <xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
 <5473CD28.5020405@alum.mit.edu>
 <54776367.1010104@web.de>
 <20141127225334.GA29203@dcvr.yhbt.net>
 <547895F1.1010307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Cc: Eric Wong <normalperson@yhbt.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Nov 28 17:24:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuOLY-00051h-No
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 17:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbaK1QYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 11:24:37 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54868 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111AbaK1QYg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 11:24:36 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5DEB92808F;
	Fri, 28 Nov 2014 16:24:32 +0000 (UTC)
Mail-Followup-To: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Wong <normalperson@yhbt.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <547895F1.1010307@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260369>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2014 at 04:34:09PM +0100, Michael Haggerty wrote:
> My ideal would be to invert the procedure. Let the patches in a public
> Git repository somewhere be the primary artifact, and let the review
> process be focused there. Let email be an alternative interface to the
> central review site:
>=20
> * Generate patch emails (similar to the current format) when pull
> requests are submitted.
>=20
> * Generate notification emails when people comment on the patches.
>=20
> * Allow people to respond to the patch and notification emails via
> email. The central review site should associate those comments with the
> patches that they apply to, and present them along with other review
> comments received via other interfaces.

I think these are good goals.  Even as a semi-regular contributor, I
prefer to push branches around using Git rather than formatting patches
and mailing them.

Also, I think that being able to comment on a patch or report a bug
without a login (via email) is desirable.  I'm not a fan of having to
have an account on every Bugzilla on the planet.  That's why I like
debbugs.

> It seems like a few desirable features are being talked about here, and
> summarizing the discussion as "centralized" vs "decentralized" is too
> simplistic. What is really important?
>=20
> 1. Convenient and efficient, including for newcomers
> 2. Usable while offline
> 3. Usable in pure-text mode
> 4. Decentralized

I think 1 is definitely important.  For me personally, 2 isn't very
important, as all my email is via IMAP (so I have to be online).  I
think 3 is important for accessibility reasons.  There are a lot of
blind or low-sighted people for whom a GUI is infeasible or burdensome.

> Something else?

It might be useful to have a system that has a bug or issue tracker.  We
often have posts to the mailing list that don't get a response, even
though those may represent legitimate bugs (code or documentation).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUeKG5AAoJEL9TXYEfUvaLFBsP/iOjJg31/cwfa7BOsMaq1Hhq
aOpFM2TQiupgVcwsdIkwnC05VfBQUvqxWUdYsnDDO16QJSyzOnBISnM8TvgZFWuh
UvTlfkIZEzIhvQBkRHFPpld/q3SwyuZQsVHd/9HsnAYjz73dQ8D3b3fNgPEHut+8
5jyeHGsOjkWoKFZTcUV9OzPGXXh/H0DpzmwfgXgukhlTwqVH3PUWv0E7GG19kWrd
fI/JbsPgBio3eS1TOd9rEXZsWe6ZxokkfjyflPEvbRoDHJNzW/8eMzZ8j/PGmYly
7i8FhTpvxH5jC1KoOiwahiK6UG9mJovg6EFdppDv3L6MxWVfmL5ycp3j43jERDT6
KPebiSbhpTRYl+/wDNiGqUS5s2kBPPV5+BSLjbY+UEj0iMJuVNupgZpMmJL/E+eG
dhAdGhHgsLJYHberKfq1LLnHh+Ywv56pJLNxoMT7hc3hhcO9exxT/IQK6FgnzXWG
lAZtQPA1/34VR2N1oIDvQrUKe9mLfiSS35A2ciGFF8SrrF2vD+WZ/xSMamb6C5oj
NH66VrfBGjJZG/oe0Nhw2GohgPrPiJtNea3TLg4SEjkCmgz4AjeLvJz4snRwOAuy
wD2XPpgblvx8h7KkS0j0ySNpnKqusYH8qnnA9xeclHsJgAikXkjEsB+67SCokc2q
r4MXKG4rfUtAwJGy1Ora
=T9Xv
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
