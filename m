From: Jan Hudec <bulb@ucw.cz>
Subject: Re: gitweb css - pixels?!
Date: Tue, 8 May 2007 10:36:44 +0200
Message-ID: <20070508083644.GA9007@efreet.light.src>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Cc: git@vger.kernel.org
To: Chris Riddoch <riddochc@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 10:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlLCJ-0004VM-BJ
	for gcvg-git@gmane.org; Tue, 08 May 2007 10:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934743AbXEHIhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 04:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934739AbXEHIhE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 04:37:04 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:3417 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934730AbXEHIhA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 04:37:00 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.65950;
	Tue, 08 May 2007 10:36:44 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HlLBc-0002NY-CL; Tue, 08 May 2007 10:36:44 +0200
Content-Disposition: inline
In-Reply-To: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46552>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2007 at 17:13:42 -0600, Chris Riddoch wrote:
> Hi, folks.
>=20
> I've been gradually converting my ~/src directory full of tarballs
> I've found interesting enough to download to a ~/repos/ directory
> containing bare git repositories of the projects.  I was thinking it
> might be worth my while to set up gitweb so I can peruse my collection
> of projects.
>=20
> I noticed myself squinting, on my 1400x1050 laptop screen, at the 10
> and 12-*pixel* font settings gitweb's CSS specifies before thinking to
> myself that I should bring this to the list's attention.
>=20
> I'm no CSS guru, or I'd just provide a patch.  It seems that *all* the
> measurements specified in the CSS file are in pixels, not ems or
> percentages.  There's got to be a better way.  I can't be the only
> person who would rather use my nice screen to render attractive,
> readable fonts rather than to render the smallest possible fonts?

Well, there should be three ways to set font sizes:

 1. Use the symbolic small, normal, large..., which are derived from user
    settings (normal is user setting, large is one step larger etc.). IMHO
    this would be the best variant.
 2. Use *points* (pt) instead of *pixels* (px). Unfortunately most browsers
    don't know what their DPI is and will treat 1pt as 1px, even though they
    have more than 72dpi. I believe this applies to all Micro$oft browsers.
 3. Use designation relative to previous font. One step up is 1.2em, one st=
ep
    down is 0.8333333em. I am not sure this actually works in Micro$oft
    browsers. Also rounding errors may quickly get you to completely
    different font size that you wanted.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQDacRel1vVwhjGURAlThAKDiTn2Yu78OVo3csfIx2b7JnmqNxQCeOOjo
+8yfIIpFShDFOQ7OAuVQOTE=
=RWRc
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
