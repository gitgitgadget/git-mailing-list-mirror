From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 2/9] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Sun, 17 Feb 2013 21:39:08 -0500
Message-ID: <20130218023908.GC5936@odin.tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <31c45d95acaf062428f171c33c4c164d80b4becb.1361146398.git.wking@tremily.us>
 <7v621qe4xc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:40:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7HaE-0001v0-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 04:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab3BRDjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 22:39:39 -0500
Received: from vms173009pub.verizon.net ([206.46.173.9]:59807 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab3BRDji (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 22:39:38 -0500
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2013 22:39:38 EST
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00FXPA18I980@vms173009.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 20:39:09 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 9DBFF88588F; Sun,
 17 Feb 2013 21:39:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361155148; bh=+LjlIXmS/bSnKpCujjYjuZJAq/SPB6k0s5BFH2bvBpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XdI86ZywIu0+jUh7AC8zVZmlygJY4ieXwcCOG6w1gWxn4DR6TmmPP8n8zLmNttS2+
 R0ON1EncrMrQ2EAVqgAmPdjvlUfnvUBcVXYd0O5M/e+bMS78cM8jqBk1lQDuWzpTU6
 Lh/OlIKalsfO78URcLIzpP+N6Ji3vfV+erVZydxQ=
Content-disposition: inline
In-reply-to: <7v621qe4xc.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216437>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2013 at 06:23:11PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> >  [[rewriting-one-commit]]
> >  Rewriting a single commit
> >  -------------------------
> > @@ -2552,71 +2558,81 @@ $ git commit --amend
> >  which will replace the old commit by a new commit incorporating your
> >  changes, giving you a chance to edit the old commit message first.
> > =20
>=20
> ... A lot of lines removed here ...
>=20
> > +[[reordering-patch-series]]
>=20
> This change makes the [[rewriting-one-commit]] section say "We
> already saw you can do 'commit --amend'" and nothing else.  It makes
> me wonder if the remaining section is worth keeping if we go this
> route.

I think there should be some mention of `commit --amend` in the
rewriting history section.  It's a pretty straightforward idea though,
so there's not all that much to say about it ;).

> > +Then modify, reorder, or eliminate patches as preferred before applying
> > +them again with linkgit:git-am[1]:
> > =20
> >  -------------------------------------------------
> > +$ git am *.patch
> >  -------------------------------------------------
>=20
> It may be just me, but s/preferred/needed/, perhaps?

Sure.  I was just shifting the existing text.  Will fix in v4.

> > +The rebase will stop when `pick` has been replaced with `edit` or when
> > +a command fails due to merge errors. When you are done editing and/or
> > +resolving conflicts...
>=20
> I am afraid that "due to merge errors" and "resolving conflicts" do
> not look corresponding to each other for a new reader.  Also here we
> say "when a command fails", but the explanation before this part
> never says "list of commands".

Oops.  s/command/commit/.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRIZRLAAoJEEUbTsx0l5OML3AP/004L/jYMgMPEUo2u8ZBGPqS
4OB07z8SDhrq5ue115uREjKS5I5z2noaDkXr4WyGBW7Iint3u4zT+N/sM/8KXM2c
v4UlcVYCfwo0ngYGle+UEEAkiv2pRiz36Q6xzOcTEEgfoWUU4yYo0KrHOXPobMlt
7sFpHns5uM/FyUwMKxhxguKaPPbuSd8ap/Qwe4pS6WBw0NlCZxFwsVFCUwMM9wcR
B+AppLXEiTi/v/R1YF9tJ9leAkvRPDq9s83h6hG0oRu5FNvSXtgdEfTZCCMX6Rni
Yt7irnbVUKj5ADZmke9+ScjZMh8jsKNnrZ2LXOIIA5Lq9yR+BNisHnHvsT+an/f3
JnCJo89ulnprbY0CBltj5NCRJgnWRcSPefX2LVKTMFkJT13G1wPoRFRSjaBloVy0
XB+8I5xFJ4zF34bLmVFwbmOGkDTLBCgGTZ1ldDOkOL5jKjrC1opY/1v/jgXCZvbV
pTiL9eU/xUImE0Qdr+CoS8m91Sh6xKW6hvoM/LCXc77TDjRreYna7G8BmJBhfWlw
G4/FKA5ThH9J7JMlpUXqPm8Xx2YOxA5tJwMU0TtCM+WhvrveA2AEqEKpFmOXmuVJ
uGNlU2W5LEYsc3/YVxULnr0mzIdWIVDh+7Bt23B2McDzjz9FUhEZFQuL/ctyOrLn
1Wh37hpyDrJdxVG4vzsV
=Plq+
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
