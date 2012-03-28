From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v7 3/3] gitweb: add If-Modified-Since handling to
 git_snapshot().
Date: Wed, 28 Mar 2012 15:27:51 -0400
Message-ID: <20120328192750.GA6909@odin.tremily.us>
References: <20120328164513.GA4389@odin.tremily.us>
 <81004880a876bb9b9f607129956363d3167bff72.1332956550.git.wking@drexel.edu>
 <201203282011.32148.jnareb@gmail.com> <20120328183712.GA5992@odin.tremily.us>
 <7vr4wcv8v4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=huq684BweRXVnRxX
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyXY-0007X9-7a
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758021Ab2C1T2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:28:08 -0400
Received: from vms173017pub.verizon.net ([206.46.173.17]:53793 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757996Ab2C1T2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:28:07 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1M000QV0QGJOA0@vms173017.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 14:27:53 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id BFA1D43B932; Wed,
 28 Mar 2012 15:27:51 -0400 (EDT)
Content-disposition: inline
In-reply-to: <7vr4wcv8v4.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194168>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2012 at 12:11:27PM -0700, Junio C Hamano wrote:
> "W. Trevor King" <wking@drexel.edu> writes:
>=20
> > Grr.  Thanks.  I'm getting lots of rebase practice on this patch set,
> > but I'm still missing things=E2=80=A6
>=20
> How do you "rebase"?
>=20
> It often is the easiest to check out the tip of the previous iteration,
> fix all issues that were brought up in the working tree, eyeball the
> output from "git diff HEAD" to make sure you addressed all the comments,o
> and then make separate commits, using "add -p" to sift the fix-ups
> according to which commit in the previous round they need to update.
>=20
> And then finally you run "rebase -i" to squash these fix-ups in.

Ah, that makes a lot of sense.  I had been running `rebase -i`,
editing the earlier commits, and using `commit -a --amend` to squash
them on.  The problem with that approach is that you need to check the
changes vs the previous release before each amend, while with your
suggestion there's a single diff to look through.

Hopefully patches v8+ will be cleaner ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPc2Y1AAoJEPe7CdOcrcTZEIkH/i20Y+wZ2j1r5MR2QteYeGZ3
e3JKb5swRCWKpXXPy49is06qUUISXW0i1c8Hi7HR7kuZLSmiQ5qxqGkOaiW4kOhF
dk8KtWAMJv9hFU4Scd8YdKPRpuRQ9G4mzm9jucV2/MO2tkptTHe/nYpY8TlYFXVr
lqyp+H0qoEC7TANSffCV+oLyffVJmRzwfyQHTTf9cQDIY2UTs8Y+70LQPrFWcoj9
d/jcEoAdZuqKCwjIuta+Jc0UwF1KQBG97oFRSqWfgtm+YFSu9LQQ7FPQ949sZz6C
4fmYlsdTtNQZTnUPvt/WMWCYcDNoEidhxUxKI9ATsjvI3LKFD/H+RxwT84vSTz0=
=k78j
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
