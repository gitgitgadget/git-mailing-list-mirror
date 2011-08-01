From: martin f krafft <madduck@madduck.net>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 20:34:11 +0200
Message-ID: <20110801183411.GA5182@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <CAGdFq_h5gimMkwhyOv0PFqVwx4pExL7Zri8Tki_dT5HDtFcBFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
To: Sverre Rabbelier <srabbelier@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:35:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxL3-00053q-MK
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab1HASfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:35:38 -0400
Received: from seamus.madduck.net ([213.203.238.82]:34699 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1HASfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:35:36 -0400
Received: from fishbowl.rw.madduck.net (70-204.79-83.cust.bluewin.ch [83.79.204.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id A1527407D24;
	Mon,  1 Aug 2011 20:35:07 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id D39441FE00; Mon,  1 Aug 2011 20:34:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAGdFq_h5gimMkwhyOv0PFqVwx4pExL7Zri8Tki_dT5HDtFcBFA@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178400>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sverre Rabbelier <srabbelier@gmail.com> [2011.08.01.2027 +0200]:
> On Mon, Aug 1, 2011 at 20:20, martin f krafft <madduck@madduck.net> wrote:
> > My intent was to add an extra commit header to select commits as
> > a way to store extra information needed to automate the management
> > of interdependent branches and patch generation =E0 la TopGit.
>=20
> Have you had a look at git notes?

Hello, and thanks for taking the time to reply to me!

Yes, I have considered git-notes. The issue I have with git-notes is
that it requires every contributor to set up refspecs for fetch and
push, or else the notes will not be exchanged/shared.

I realise this is a minor concern to most of you, or maybe even
a feature (part of the beauty of Git is, after all, that it works
without requiring everyone to have the same local setup), but in our
use-case (distro packaging), it's a relatively large burden to new
contributors and passerby's (sp?).

Also, git-notes are mutable (at least from the UI perspectiv) and
I strive to encode information immutably.

Therefore I am looking for a means to encode this (necessary)
information as part of the main DAG (i.e. not polluting the
worktree).

I hope this makes sense.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"first get your facts; then you can distort them at your leisure."
                                                       -- mark twain
=20
spamtraps: madduck.bogus@madduck.net

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJONvGjwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xHor
EAC74xveb1NbWy3DDWCo/q3lMLK7gYhdFDmzSYtHHbasUrUp+7qkceQRp4TdLTlB
H8o5agtCSm2q6/mMj+5iqd/CCSY/7R/yaruxgZvwxRCGFI0Ke3w4tm61Vk2cHL6V
SQk8Q8ROKAu99946d3jmuamrilzJxr2aN4JRRqR6hT5h2XqS/D3urn/8rjunwmn1
yrAmaOGD9qpthOGroR1CX5yWLEcy2bdQ8OSaBzfBcHWTs4PLCzYgoAD36rTYljZx
M8eDbnwUxkOSC3scQPaFcSiEZwM8wXrHRy6uPTeEdl1zx5OzMgZKdvz/c7QhgMS5
nMtIq7Qxm/03cvxxRGWbHm5h/SKE8DXVKDrpbXWj25NjuUADK1b6edt6Jie4UXzj
vvruuh8ABqA9hnjeGZNzR0223JzJcyTdK9CmrsKoL32PfEB8+GFmpjWfX3BC1zTL
WE7JbTobrR1pLUmS+CRPp0R5JbpiS5X4nd+uUu7NCgtoey03HHroFI16YEouMGSK
aeraKeIjSdoQNg11w33xIUC1Mbun1+eRY6J8iw5pe7XpD6ZQoWVVqX5ROfsdTehf
4+z1Q1Tt4IsJi+4iz7MJoXrMSzNsUdk6tMHeUTzvqXTz0yMoy17lOepjI9B6ZAY6
BlBUX9A1Vm2L+rty6DC5M+d0MFeIK9wuRnk50WeUixDOPw==
=+TST
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
