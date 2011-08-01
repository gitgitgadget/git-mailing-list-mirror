From: martin f krafft <madduck@madduck.net>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 22:51:43 +0200
Message-ID: <20110801205143.GA15401@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801182845.GA4303@fishbowl.rw.madduck.net>
 <CACPiFCLPgsC+9cX7r33oCQ2AnuRXMTqOAE5RZLS7hXdHc6B-9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: Martin Langhoff <martin.langhoff@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:52:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnzT1-0008OC-S9
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab1HAUwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:52:00 -0400
Received: from seamus.madduck.net ([213.203.238.82]:52428 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab1HAUv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:51:58 -0400
Received: from fishbowl.rw.madduck.net (70-204.79-83.cust.bluewin.ch [83.79.204.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id D11FC407D24;
	Mon,  1 Aug 2011 22:51:44 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 90B341FFE2; Mon,  1 Aug 2011 22:51:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACPiFCLPgsC+9cX7r33oCQ2AnuRXMTqOAE5RZLS7hXdHc6B-9Q@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178412>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Martin Langhoff <martin.langhoff@gmail.com> [2011.08.01.2133 +0=
200]:
> What data are you trying to include? Some time ago, I had similar
> ideas to yours for a while... and it ended up being that all I needed
> was to put the additional data /in a file/ and commit that file.

Hi, thanks for taking the time to reply to me!

I am trying to store the top-base of a TopGit branch, which is the
merge of all a branch's dependencies.

TopGit uses refs for that, but a ref can only ever point at one such
merge, and so it's hard-to-impossible to reconstruct a branch
dependency in the past.

TopGit does use files in the worktree too. I would love to get rid
of this as well, since a file like .topmsg (which differs between
all branches, even related ones), requires to always remember to use
the 'ours' merge driver, which requires setup, which makes it harder
to use.

> If you are using a wrapper program,

I am trying to stay as close as possible to plain Git. All of this
could easily be done by a wrapper, but a wrapper always makes too
many assumptions to become a viable standard for Debian packaging.

> it's valid/sane, in the preparations to commit, perhaps ensuring
> that a pre-commit-hook script is in place and executable.

Again, that requires setup, which increases the barrier of entry to
passerby's and new contributors.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"verbing weirds language."
                                                           -- calvin
=20
spamtraps: madduck.bogus@madduck.net

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJONxHfwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xL27
D/42oIJ00GM93WbJj5XybhhfCJDJZBp/l7DIRwYHrIShUVu495y0O/3ZJ0z83XqY
lTiedlcUfJvcmDUhCPZCMudmBzQqVQKDMcnYYlg/CtJUSYeP1H8CDU0LSVSu5cM7
IBvmOwQEesD3MUnGweLYpHkJMJO+jJGMScR60kB98YLerEruGPTUhWLTxNId8Da3
e8SPSXduHapN8PVdDwQtrC60ZfwRksu0n5CyVJz9dfK72HibLJEY+1J6ajWxwzhq
SKIWA8c7J42z6RKltRuOAjWtG/wzB0OTbCoW3+ralb84bH8DVMOs0OUo5BSX5Q4L
H7YUDsixeFut+Wx+qZgxKfUhwW5cVSMTR+gmqy4TufhJKfSjBZ4I+gDpLEhndJTi
9kdZnMU3P3kr7PjIX00TZPdAK8zk0A10Vmeqp0bl2fbjLQREFzkR1v+KDUjWspLR
RBepMB7rJgzlTvAS6NWmOnqu+1bU25zmom/nqPNOAN2W57k02oWAw0ZFqenLlwsr
rkH261xXtRM7dGSuuazsTCxMFCNG1mpOwFzegiI3cQkjjbb9sRQFFor1kbF6OnlY
gXt2613GWS6UDBjjGv5cqwxJL5/jlS1y3sOm3l9TcIGTNRq7W9ohu54x/KYDLfOd
Fa6vOmgWNlQbMhPZPttqlJabSHktuZYz5oO98IAzxeyRgw==
=sn5m
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
