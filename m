From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 13:47:52 -0800
Message-ID: <20140105214752.GH3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 22:48:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzvY8-0008VI-JX
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 22:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbaAEVr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 16:47:57 -0500
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:40557
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751718AbaAEVr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 16:47:56 -0500
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id AMGb1n0030QuhwU55MnvEd; Sun, 05 Jan 2014 21:47:55 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta02.westchester.pa.mail.comcast.net with comcast
	id AMnt1n00H152l3L3NMnuak; Sun, 05 Jan 2014 21:47:55 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 14F3AE8AD04; Sun,  5 Jan 2014 13:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388958473; bh=flocnMqGuT/do0Wuunxz6rnT0kGZiTUb/acLLAflK9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CvgNXOpHya6gontdHPMuwcLVhWzYKKvzg3w/LHnZNEvfs14EGxT0svRFJ+RUFQ26B
	 9gbeUJnRIKk+UbsHp8PSpA2l2LrU3+qMet4utylPNHyVVGec+W34Vreo63LjW9MZ3J
	 MSGzLLDi6vO9m6Mrgf1EkRPa/Xe+eWALTnEEsjgQ=
Content-Disposition: inline
In-Reply-To: <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388958475;
	bh=PCwCVHRLMGTZA0tKG3R/CVTbHN0FYeejGCDSjuY7kLU=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=PaMbanENochm6+fARKEA69yNZictHYZDYe3dqduM8YNpPFWNLcK3vxYpowfBXu7Uq
	 u8pnjdCqtz9CdTAHWOq5+H+IVDW8vQYT67L6/4Aefu4y+M84kEodAO6MOkqdjbkJSL
	 lkqQxhUOIWFJgzmPQh/OOrsSbCNrXtoxf+Ywwdd9L1uTIfuZPDTiSM0DV+IT8qKznF
	 pj8w4AXXAT0+SnGIm4v2IObctSTZNWK73XOjSOAGoMgNWWlvrMTFsSSYh3OkUZj8Lf
	 sDqZRo/dQ8QLZ5i7n24oJgEgYGx0xbZW8AHKL6qtRfY7niMNJWCxICPFtfyuCI22xP
	 3NnBh4RyJBGwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239976>


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 10:27:19PM +0100, Francesco Pretto wrote:
> 2014/1/5 W. Trevor King:
> > Adding a check to only checkout submodule.<name>.branch if
> > submodule.<name>.update was 'rebase', 'merge', or 'none' would be
> > easy, but I don't think that makes much sense.  I can't see any
> > reason for folks who specify submodule.<name>.branch to prefer a
> > detached HEAD over a local branch matching the remote branch's
> > name.
>=20
> I think the reason is that it still matches the original use case of
> submodules devs:
> - the maintainer decides the specific commit developers should have;
> - developers checkout that commit and don't pull (you can't do "git
> pull" in a detached HEAD);
> - they optionally get the upstream commit from the specified
> "submodule.<name>.branch" with "--remote". They are still in a
> detached HEAD and can't do "git pull".
>=20
> Maybe who coded submodules at first was thinking that the best way to
> contribute to a project is to checkout that repository, and not work
> in the submodule. As said, this works well when the submodule
> repository is a full project, and not a bunch of shared code.

You're saying that the detached HEAD is a feature because it breaks
pull?  And developers can't be trusted/trained to just not pull
reflexively?  I'm not buying that ;).  Although I was sad to see
jc/pull-training-wheel dropped and have that discussion stall out [1].

> > If they prefer checkout updates, the first such update will return
> > them to a detached HEAD.  If they prefer merge/rebase updates,
> > future updates will keep them on the same branch.  All my commit
> > does is setup that initial branch for folks who get the submodule
> > via 'update', in the same way it's currently setup for folks who
> > get the submodule via 'add'.
>=20
> My patch is in the same spirit but wants to obtain the same by being
> 100% additive and by not altering existing behavior in any way.

My v2 patch doesn't break the current test suite.  I'd be surprised if
a change in such peripheral existing behavior as the post clone-update
branch actually break any user code, but I'd be happy to see links
that prove me wrong.

> Also it covers:
> - an "autoremote" behavior when the user wants an attached HEAD:
> with your patch "--remote" is still needed to really update the
> branch with "git submodule update":
> - voluntary reattach/detach the HEAD with command line;
> - ff-only merge of changes in the case of "checkout" in an attached
> HEAD (doing "git checkout <branch>" is not enough);
> - reattach of the HEAD with orphaned commits.

Personally, I don't think autoremote updates are worth the additional
UI complication (hence my alternative patch ;), but I'm open to
discussion on this point.  Can you make a case for why and explicit
--remote update is burdensome?

I'm also not entirely clear on the problems avoided or workflows
enhanced via the last two entries.  Could you sketch an example
workflow that makes that more obvious?

> Unfortunately our patches are already a bit colliding. I'll wait for
> other comments from git maintainers and let see. Anyway, I'm happy
> because things are moving: after this debate git submodules will be
> better for sure.

+1.  I floated my patch as a proof-of-concept for my side of this
debate, but I'm pretty happy with the current setup, so it's hard for
me to imagine submodules getting worse as a result of this ;).

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/236372

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSydMGAAoJEKKfehoaNkbto0gP/jCci+Cjzx0lwBIFuSK/euZG
Yiv8QbG298MVLBHJSd3mqmZnuTf2n2yLgT1Kpi/rfkTxF8kyLTe442W4QIlSS26s
aEqJVAwldnUjRalo5mIlO21JzKn/G0eKtwZb1diWOw1l4BssqR2OPtCWpKKKL+7h
1f2mRmyPJlaTu4qvdCt/VLD3OVPGjutEJLqUpXxHE0X9BzhX6XFcRdi2bxocVb9v
bAZTj07mY5QB4rDhvrqttLg5hXsDIKQ9SxKDSAirIWR0Y2jwrckmxxHFNfnInZtV
2KG4C2fr9X/Jl+Q008rcdif4XdCesySGOKXt8tmZ+GCEtcBBnxPeZJcWA3/4V+op
5FNiSiT3AHh2ObKjcvFZZa79tskBlZV2RiaJhglacR+uIMF79QI9/QqEPZX+bfMJ
uTP4FJTyYbGUP8WnjxFQvPxgVovhXyKaDBCJ3iGHvty9IrMsMtMVjRNkMpf1Dvxn
C1rGlMbrq+43yyZKNqVqBsyYhv/h1EX8Mida4w/i3c3y6G/TZ29B7Yo0h5aaivk/
tWA3GFsJDpt/NWaiuG+tP6FFnCNCIGJlyTIcsqrVQcFIPkJMijfgBb40JlASoYjO
+qLCWp2djTn/OHpo0iKJOenNPNa9SOR4jj72RsTjRsICnmP4ikyV8gBQIwAdmuFu
DIH41WDJTtuFNiuoJYdi
=TKq7
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
