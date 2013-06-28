From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Fri, 28 Jun 2013 05:09:17 -0400
Message-ID: <20130628090917.GG11985@odin.tremily.us>
References: <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
 <20130627201032.GF9999@odin.tremily.us> <vpq1u7magky.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=doKZ0ri6bHmN2Q5y
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 28 11:09:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsUgJ-0004we-1S
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 11:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab3F1JJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 05:09:23 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:42569 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab3F1JJU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 05:09:20 -0400
Received: from odin.tremily.us ([unknown] [72.68.89.48])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP300NX2IRI3X10@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 28 Jun 2013 04:09:19 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 48898A71890; Fri,
 28 Jun 2013 05:09:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372410557; bh=0j736HcEUiWgzWw3QizjudsvUSLo7Zdsnk1gCM0VhyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GWruad7+redaqx6L7STqr9md7My0mzwD9Xit6lzFX3BXGbFJeBRVIHVTkYQo5l1dg
 oSmc6L1vvIfTFxZM0z6rDQH3KvFOF/YDH+DnsunPUSPL+v7whstCUUnxBfCPbey4lk
 DMw8g6SPM3swZSrnRllQO5xmgk+fesNdah6OLpaw=
Content-disposition: inline
In-reply-to: <vpq1u7magky.fsf@anie.imag.fr>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229181>


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2013 at 08:34:53AM +0200, Matthieu Moy wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
> >> Because letting a trivial merge automatically handled by Git is so
> >> easy with "git pull", a person who is new to Git may not realize
> >> that the project s/he is interacting with may prefer "rebase"
> >> workflow.
> >
> > Or they may not even realize that they've just merged an unrelated
> > branch at all, dragging in a thousand unrelated commits which they
> > accidentally push to a central repository without looking,
> > contaminating future branches based on the central repostitory without
> > drastic rebase surgery ;).  I just saw one of these earlier this week.
>=20
> I don't understand how the change would solve this. If "pull" would drag
> a lot of commits in the current branch, the "rebase" will rebase the
> current branch on a totally different history, and pushing the result
> would be equally bad.

I want the warning that they had not made the required config choice
between rebase/merge needed to handle a non-ff case, not the default
merge (or rebase) behavior.  The warning gives them a chance to
realize that this was not an appropriate time for a `svn update`
analog, and that the project may not to want to have the branches
joined at all ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzVK5AAoJEKKfehoaNkbt538P/Rwh+58OoRWGmD9p/MB0C3fb
tmNuliWyPTNBvVmBbFgebFZwJIQ4riadkGiBFETb6MmnP40RPiQLm+A62982x+1N
vV42PcA5g5QN0p402kLjtbuWYTJotvypk4llWqWqldj1Byx6IQjIjQZ2Lxvi90/P
ukoVwAfOFlP0ovxdUTJPMp3e3Vyx98Ll2tVZ1668vAMHKnA2aXnWWBLz5ddHRA9W
Ov9D+yR1xt18zx4gmV8GfMHMhPiCVfq7iYIae0kYoO1HyVeLYJudWHaEVkD+SYMZ
Ceu31u2YwxbZMg3LAweIWU2ZW9n565rRARomt6abYQQ1notqu723qXVTLBuYujVA
l1a6TANbKC411Qri+J1mJq7Pjt4mdLiKMBRH4v/fe++8rbZuClvxms33EJlotRER
NmZCNnMeMiCwbkVH+C+hhtlJQXRoHmPUGn3IWEUuDJTq/SkAafGjJkxH7o0lfLUN
f7d/5VBAnimTV4ce9DawsIGumhmpZWyPzW099Jw609kSVpfcUf6Fb9i+9uu5FYuV
LyyEWZa9VW6HRvFvTFhjYOHR0nkIhK7xKjg6TN3sTpOhIeX2PZFVvQF4YPlhLkrO
J8MuLHnGHb4E81wV/GmYFiZqVn3wZBCbKGKIZQxqWN7LnqOO4+eQqq8EVP/6EnuM
ePBxsw+e+GiHti1ymGt7
=8Bom
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
