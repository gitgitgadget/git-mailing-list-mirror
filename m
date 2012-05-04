From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 21:00:52 +0100
Message-ID: <20120504200051.GP14230@opensource.wolfsonmicro.com>
References: <86aa1rmvhb.fsf@red.stonehenge.com>
 <4FA05E9F.9090709@palm.com>
 <CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com>
 <4FA2D1D7.3020807@palm.com>
 <CA+7g9JzZ36RgsniT4UN0Zk+z1ohZYW5u+0AoGMjJZqsoBjqvqA@mail.gmail.com>
 <4FA2D97A.8090504@palm.com>
 <86ipgdhvjo.fsf@red.stonehenge.com>
 <4FA2F013.3020904@palm.com>
 <20120504155606.GB30130@sirena.org.uk>
 <4FA41E8E.20900@palm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xNm6VWMD3PcA105u"
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Nathan Gray <n8gray@n8gray.org>,
	PJ Weisberg <pj@irregularexpressions.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 22:01:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOgY-0000mC-2p
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 22:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab2EDUA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 16:00:57 -0400
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58016 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754334Ab2EDUA4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 16:00:56 -0400
Received: from finisterre.wolfsonmicro.main (host86-158-216-225.range86-158.btcentralplus.com [86.158.216.225])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 8AF281B41AE;
	Fri,  4 May 2012 21:00:54 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.77)
	(envelope-from <broonie@opensource.wolfsonmicro.com>)
	id 1SQOgO-000872-FI; Fri, 04 May 2012 21:00:52 +0100
Content-Disposition: inline
In-Reply-To: <4FA41E8E.20900@palm.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197070>


--xNm6VWMD3PcA105u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2012 at 11:23:10AM -0700, Rich Pixley wrote:

> This is a different situation from either the one where I,
> specifically me, must merge or the one where I intend my changes to
> stay separated from other development, (a new "branch").  The
> situation with multiple heads allows the merge, the branch, even the
> decision about whether to merge or branch, to be delayed
> indefinitely.

So, git does actually allow this quite happily - people can publish and
merge whatever they feel like.  What seems to be missing (as far as I
can tell without having used hg) is the ability to associate random
scratch branches from various places with each other and then do things
with that information.  Like I said in another e-mail elsewhere in the
thread this does make sense to me, though it's not a current workflow.

> The fact that it allows for this also allows for a number of
> different repository network architectures, all of which are blocked
> in git because of the push problem.  In git, those decisions must be
> made _before_ the push.

They're only blocked if you don't want to create new branches; idiomatic
git is much more free and easy with that idea so a lot of the time what
people would say is that is to just create topic branches.

> There's also a possibility of nonterminating merges.  That is, if my
> team is making changes faster than you can merge them, then you'll
> never get to push your changes.  With dual heads, you still can.
> And then anyone who wants to can merge them.

Again, this only applies if everyone has to merge onto the same branch
and do it regularly - in normal git workflows this doesn't really occur
as the final merge branch requires some review/approval process and
unmerged work branches are cheap to create and publish.

--xNm6VWMD3PcA105u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPpDVtAAoJEBus8iNuMP3diSAQAI9rGGzGG6B7WDKOOniLdRC6
9d/VU2pbSsjMu3UkjCARC7P+g78Fj7hol6JuKkEdAmccwSBECUN0icr77Qed0pVl
BScDZel4SmxbRfhKUcOercj4+w1j7HFB6RZf/3vsH1TDOW1EErCiyZWDSKrqBG2v
0tP+k7q4FjMMN+Qqo2QvsAvExdsN8m6nm2XlNeF0u7dKG0tRHxEkokVrOwq3GPIY
ngvxxy3d7j6jR5fEYRBBNcgJxHyLUUUOMPbwpAeahsrfWgr4OF0/pGxrHiY3wV9u
1oHpveSeTNzcSA9Osa/iYDjVqCSzrnxNjOlj0zjKt+yz1zEnmCPRjg19jpIhOXeq
HSsvDXpesZGgQQ8pV9xPlOZThdRV1Few8NEKVgdV6OgiRaebbkxlSUETHxrJe26N
7PaMZYM/WrYQCf1JF15Pzf2u6vTtbcW+kgnLlWT3oEu0+5TJt4jAUOac8bBodyqC
16u9Qd24QmoS4QNRnr6n9vXVgkWVoAQfctLDj2qzEgrfUahK1tCk5xWKUdaXh6R6
SmbfQ33NDT5ruMn4oe5kfVCplcnVLgZiARlaf4NFMn9pGSdnKsE939LmmrX3mwnK
o3COGrKaqon7HGPRaMMx441NWpT3NfxYYgbUof8dbhnANLz0zQf2GV9dLOWEa3nB
0MoYqdONJMQ1GKUjDBKr
=8Q0p
-----END PGP SIGNATURE-----

--xNm6VWMD3PcA105u--
