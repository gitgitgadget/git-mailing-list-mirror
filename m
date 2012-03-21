From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 16:34:01 -0400
Message-ID: <20120321203401.GA660@odin.tremily.us>
References: <20120321140429.GA28721@odin.tremily.us>
 <7vmx7921yz.fsf@alter.siamese.dyndns.org>
 <20120321195520.GB32535@odin.tremily.us> <201203212104.23192.jnareb@gmail.com>
 <7viphx1zt7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=NzB8fVQJ5HfG6fxh
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:34:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SASET-0001pi-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760204Ab2CUUeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:34:05 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:45555 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760263Ab2CUUeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:34:03 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M19003N454Q5J80@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 21 Mar 2012 15:34:03 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 67149428B8A; Wed,
 21 Mar 2012 16:34:02 -0400 (EDT)
Content-disposition: inline
In-reply-to: <7viphx1zt7.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193614>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 01:09:24PM -0700, Junio C Hamano wrote:
> In a more elaborate series, you would first add a lot of tests to nail the
> behaviour of the existing code down, then refactor or reimplement them in
> a different way, add tests that expect failure until the next phase, and
> then add features and turn expect_failure in tests to expect_success.
>=20
> But I do not htink this single patch deserves that complexity.  Does it
> even have to split into three?

Sorry, testing makes me think of test-driven development ;).  Two
patches it is (refactor + git_feed tests, git_snapshot + git_snapshot
tests).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPajs2AAoJEPe7CdOcrcTZR60H/ROrlJPZoHv+Jkga3Z64m2Zr
svjyeuM5QcS8COpXGqgeUphxulXefN20WRGv5osOnwo+mVfkyIpxpqgqa00RdtcJ
qoWmSLudg6qkD6DaE13z3d9hYCFa9j9xHz4Ui42vtVR+1vx8CbAJIFOr9UwsMsGN
ARBXdHYPvZk+VGbMGKsLy0arYNCd6B8jvfkdPILqFy4DPPvwuOZqP4ejBcZOGkCg
V3DBG0TT/2uiQ57e21y7j12PZl0iyduUfKRvsPvjI+V27hNttTpFEPU1METCxVij
tEw74urZNVjgeJmUif8Ro7SJLmbIhcenQMrGq/GnAgZpKUYeFzS+yykzChkf/DI=
=4kGO
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
