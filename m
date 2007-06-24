From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Darcs
Date: Sun, 24 Jun 2007 23:19:52 +0200
Message-ID: <20070624211952.GA3044@efreet.light.src>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com> <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org> <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bu Bacoo <bubacoo@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 23:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ZVD-0002u3-UG
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 23:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXFXVT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 17:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXFXVT4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 17:19:56 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:52522 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbXFXVTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 17:19:55 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 55181575A1;
	Sun, 24 Jun 2007 23:19:54 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I2ZUu-0001Gd-MX; Sun, 24 Jun 2007 23:19:52 +0200
Content-Disposition: inline
In-Reply-To: <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50822>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2007 at 08:45:57 +1200, Martin Langhoff wrote:
> On 6/25/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >Ahh, a chance to flame! I will never back down from such a challenge!
> >
> >Darcs is .. umm .. ehh..
> >
> >"Academic".

> OTOH, and from the POV of someone closely following the SCM tools in
> the last few years (and using almost all of them), darcs was the first
> usable DSCM in the camp. I am not sure how much of its commandline
> user interface was borrowed from BK or elsewhere, but darcs was
> _easy_, where Arch was extremely hard to use.

Arch is not in fact distributed. One key feature that makes things
distributed is that object (revision in SCM) identity is independent of the=
ir
location (repository in SCM). And in Arch that is not true.

Revisions independent of repositories (and branches) is what makes the ad-h=
oc
branching, that makes git (and hg, bazaar and darcs) so easy, possible. Arch
claimed to have easy branching, but it was still the old explicit model.

(Besides yes, I can confirm that Arch was not the easiest thing to use.)

> The darcs commandset (init, push, pull) is what git, hg and bzr have
> today in common. At least _I_ learned about how it could be easy by
> watching people use Darcs (and feeling very ashamed of my baroque Arch
> usage). The focus on patch tracking (as opposed to "snapshot"
> tracking) and the whole patch algebra are two misfires I'd say.
> Snapshot-tracking DSCMs are winning (faster and fundamentally more
> reliable), and the patch algebra doesn't quite scale and (as far as
> I've heard) sometimes ends in unsolvable corner cases.

IMHO the patch algebra also falls short of it's goal. The idea is supposed =
to
be that you can cherry-pick easily. However, in practice many changes that
are easy to cherry-pick are textually dependent in something like import
list, list of files in makefile or such. While git cherry-pick will happily
apply such patch and give you a single easy to resolve conflict, darcs will
just insist on pulling the other patch as well.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGft/4Rel1vVwhjGURAiYCAKDksCgcieuc11NOlFy6lz/cTYoxrwCeJGDD
wbd4FRT4LlhchtiF2uJwxlI=
=S0VP
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
