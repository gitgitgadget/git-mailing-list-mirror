From: martin f krafft <madduck@madduck.net>
Subject: Re: Branch dependencies
Date: Tue, 2 Aug 2011 21:08:06 +0200
Message-ID: <20110802190806.GA16674@fishbowl.rw.madduck.net>
References: <20110801121946.GA575@fishbowl.rw.madduck.net>
 <CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 02 21:08:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoKKF-0007LY-S6
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 21:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130Ab1HBTIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 15:08:19 -0400
Received: from seamus.madduck.net ([213.203.238.82]:43634 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab1HBTIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 15:08:18 -0400
Received: from fishbowl.rw.madduck.net (28-193.78-83.cust.bluewin.ch [83.78.193.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 8D8F6407D3B;
	Tue,  2 Aug 2011 21:08:07 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 7E9C91FE57; Tue,  2 Aug 2011 21:08:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178501>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2011.08.02.1506 +0200=
]:
> while I appreciate, that you dig this topic up. I think you are trying
> to solve the wrong problem first. My main problem with the TopGit
> approach is, that you can't freely change the dependencies of a topic.
> This may be not the most common case in distro development. But in my
> eyes more problematic than maintaining the meta data.

Hello Bert, thank you for taking the time to respond!

Could you please try to illuminate me a bit on a use-case of
changing dependencies? I am aware that TopGit has had a problem with
changing dependencies due to renamed branches, and I think I have
a solution to that (encode the dependent ref, not the branch head),
but I cannot come up with a use case for freely changing
dependencies just like that.

> For my first mentioned problem, I think a new 'system' needs to be
> 'rebase' based, not merge based like TopGit.

The problem with rebasing is that you cannot publish the branches.

However, maybe I am simply not seeing the light here. Do you have
some further ideas about what this would be like? Please keep in
mind that what I seek is not just a way to bring feature branches
up-to-date with upstream, but also to have those branches be shared
among developers.

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"gott ist tot! und wir haben ihn get=F6tet."
                                                 - friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOEsWwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xEMh
D/44yN8wzKpzXNDP5AQ9vTp8uLBrtxuhH6o7jFPnHI3O1//2gZcuafJqcg0WL/cA
Q3Vayh9PnENB2p7x8L8rSHJLB7+UB66SRNeWNymijdIyt1t3wJPiGyuu93gyA/hZ
Jpl+a2PoOp+gzu6U/R7rK8oWf0AxrBpSYYHkk1qjpEZ397avrZlR/9L/3DSStwHj
jNZOzBQasF7Ms2lhJCEqtgCbVA6jeg2B8WbrTAAj2GVyXzs/JBAP0yyGSNS3jehL
1SPAbiT9OB4+pTla0JbyWEoCCsis03v9V+ccPkgv6zCwcWRSdG4bTXPPYypSAhFQ
85w4b1rJ6y7kmkgajzNJXNyj1IBlCi4oE6IF5xqKAo+UNX4zuIMzK0poQvUjaE/5
3vhYMPP0XGH907e2Ik1Ex94+tz0J8cZJiQLYahHZWPAFztcWd/KNNSBnk6k+hOOq
Idmy5CngDrgb7sZDiboPz9IS8Du2dVwvSgtqS+6jRYs6FkZLOBmVyUO2HxrJTo8B
YwD+VHMkrWSspmpYhdtZpfeaX87tx5TnHjsAi2uscAqwAN0cF8oq9B6gMuHSjEE7
9YytM9NaHPwEO/ch7RNividDQQHz4RTU69yq9kXfBeNPEaCCR5Q9JLLsb4RfVgOM
djuBNYAtYzP++blewOFYCpcE/Sde9avO2L02EqfzrYXI/A==
=Tl2j
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
