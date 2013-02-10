From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 04/15] user-manual: Use git branch --merged
Date: Sun, 10 Feb 2013 16:56:31 -0500
Message-ID: <20130210215631.GC8000@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <c8abf7a75a59302e6bdc66eee13eb2ec53b26b46.1360508415.git.wking@tremily.us>
 <7v4nhju9z6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4etX-0006gG-SD
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab3BJV4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:56:45 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:54298 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab3BJV4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:56:44 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000FXCYA7HN90@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 15:56:32 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 6FC2787995D; Sun,
 10 Feb 2013 16:56:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360533391; bh=ukHxLxtmNXqOTO8aQgQVU67vEFZ2mRJZyYXFyyG0YRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AR+VArQFERsj0BC6hoEgh0OdcTml5GXt6cVvR4As7ymbqXmIkYUWvurvXijbFFbMa
 LBDvqN/IYUxDK8R/M8AtpAxFupYVK3TkfZvQIAtkaSDqbWL2mKYFA3wjYI796p1+Uk
 55OKBpObJ+yi4pgiJGgXJ5LwG3eedpgt+VQUeNVc=
Content-disposition: inline
In-reply-to: <7v4nhju9z6.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215943>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2013 at 01:37:01PM -0800, Junio C Hamano wrote:
> This is making things much less useful.  "branch --merged origin"
> will show 47 different branches that you are *not* interested in the
> flow of examples in this part of the tutorial.
>=20
> Also, log origin..branchname allows you to notice a situation where
> some but not all of the branch was merged, too.

Good points.  I'll drop this patch from v3.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRGBeOAAoJEEUbTsx0l5OMntMP/2olk6UfcYXFiBdPZc4meX35
IjL60IOxj8yxjKbkKPzYhKYEtJVQSBmR6b0JXzjPt+ddI4bg+Z+dT6iOo8E68EZ8
buTxs2F7Yx9pbU5r1aVLOWzQ2ddfB/VmodV71wH+T+GaeHvT/HbAc7fLeXcMjtbQ
I3bVB3bMAFKlsiy9TIrVSRDJXd9LnZrshVpPthje8nC9COgNuqbcaIpTJvdUhMNc
1okGV5cMY/EdeYLys1452kt9pPkY5xq/LPKN/bvLeNzWY1LxyHfODHJvFBjAtiCG
rbByUBo+1RGqpt+oscpMkDtNPiGfw3rjUQOFIZKoGH+D4rRT05hnXClXjh0hLcw7
OdNBoo2bKIWR1jVX98lhYvkOovb49VYQEb6Bpfj+qhKuqlRabTRgMLZTKmXwLXOA
GGnQholvZ65OfHB6C+cppD9g5ROcQrFh2jMyS+kdSnF5utXqix/fy9HqQBix0giP
PuTDJltkP3oSb8rhs5cWRuV2JrRfghAtc6AOaX3NlqWheNvGhhDFoA1mGlGQNaN9
a7Tdka9GAJ3pDxGTUIRIq8JfMV+6d7e/dZua30Uv+31cmNgpkHex9+rLMaej9L/d
AKVY45TlSrw0MFTsnh5P/++EVjuOZAsXpQ098XTL4jTALALUIg+msF26FWnl5gvv
jmjFKHl2Iz0kGQeVPG5Y
=Sh2b
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
