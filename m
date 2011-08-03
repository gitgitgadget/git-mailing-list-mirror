From: martin f krafft <madduck@madduck.net>
Subject: changing the set of dependencies (was: Branch dependencies)
Date: Wed, 3 Aug 2011 11:51:03 +0200
Message-ID: <20110803095103.GA27996@fishbowl.rw.madduck.net>
References: <20110801121946.GA575@fishbowl.rw.madduck.net>
 <CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
 <20110802190806.GA16674@fishbowl.rw.madduck.net>
 <CAKPyHN0EsXMKQ2g7ONaO4yw2ioPbMhg8XCsmB20je=O1DDeE5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Aug 03 11:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoY6s-0002TB-S7
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 11:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab1HCJvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 05:51:21 -0400
Received: from seamus.madduck.net ([213.203.238.82]:35964 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab1HCJvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 05:51:19 -0400
Received: from fishbowl.rw.madduck.net (129-204.79-83.cust.bluewin.ch [83.79.204.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id ED930407D3C;
	Wed,  3 Aug 2011 11:51:07 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id C80391FE4C; Wed,  3 Aug 2011 11:51:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAKPyHN0EsXMKQ2g7ONaO4yw2ioPbMhg8XCsmB20je=O1DDeE5Q@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.2 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178553>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2011.08.03.0125 +0200=
]:
> Not each feature branch may end up in master. And there does not need
> to be one feature branch which depends on all other features. For the
> latter you have probably an empty feature branch which just depends on
> all features. I call this branch mostly 'tip'. Removing a feature
> branch from the tips dependency list only with merges can't be done
> right now, and the proposed solutions never reached a usable state.
>=20
> My second usecase is to convert a big quilt patch series into TopGit.
> Such big Quilt patches have mostly an artificial dependency to its
> predecessors. Removing these artifical dependencies makes it necessary
> to remove dependencies from patches.

Dear Bert, thank you for your reply.

Okay, understood. Yes, I agree entirely, the set of dependencies
needs to be mutable. And they must not be invalidated by branch
renames. Therefore, we really need some sort of other way to
identify branches.

Is there a way other than lamenting that refs did not get UUIDs
assigned to them from the early days onwards? ;)

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"if one cannot enjoy reading a book over and over again,
 there is no use in reading it at all."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOORoEwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xOVW
EADBs3bIeCjqQpiwegTElIpOsxXGLCfIYJSEA3kjJnJLYMI5bpKxVAN8EwFJH1os
l3NNl4t7Nr3jE9KJmty1bByZr4VXlvr/PCKlS3vePyskcE2Z+w4j2kriCnT3jG7q
CiJ6rfsAf7mH5o0XDRFe7i1HW03a5qM0DgiUZSFcyA+/GywNcS4DqVXYbTHQGfWc
KLN8bxi0UoeuCfVAUi2J4KzSxF5RQg9JjOIebIyyXnveNbswRfi7Jsq0sd8KJ5s/
hUDtTNSgVcfYK5BJZW45MV0YiAyX7a8EeDir4+k+CBWDDX6KISP62oN0OORqRFel
4uhMTDZ7Y2+e0dQqA8PZNT3yT7T8+Gq2csaekNOJisqx/3zpWEh3Ez4YFkFMu9lU
AOZ1632DTByenGx05NLnISHvmctCeJ/GKnSAmfFVASQ2kTrtNnWw8gpYJi0Imr70
/e1bqRYR8cIPR51yDJWS31M7Z7vhmeWk9nOLkd6Cl7TJL8ZJ7PHkG897g9ON/zO1
7xhhGXDeT1bE3FJLXXJFhSmAPngeZ7XEfLC7W/R+wEt74Wv1UQQZcWJqOCDEc8aL
Z8NFNiz9y1eefyJEqztfvcr3w6vaFwJGaPQm3pMVMt0hXsDAS4xTNH/RqLP35w6v
EOKDblqeHEq+Je1WWZUSTSEFjb+Y2TmUTKKdqAekg9IdFA==
=Wivh
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
