From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: A better approach to diffing and merging
Date: Sun, 30 Nov 2008 03:54:08 +0100
Message-ID: <20081130025408.GO19355@genesis.frugalware.org>
References: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com> <200811291740.06865.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Cc: Ian Clarke <ian.clarke@gmail.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Sun Nov 30 03:55:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6cT2-0007g2-I4
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 03:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbYK3CyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 21:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbYK3CyM
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 21:54:12 -0500
Received: from virgo.iok.hu ([212.40.97.103]:53319 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbYK3CyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 21:54:11 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BA8205808D;
	Sun, 30 Nov 2008 03:54:08 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4235A4465E;
	Sun, 30 Nov 2008 03:54:08 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3327711901A1; Sun, 30 Nov 2008 03:54:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200811291740.06865.bss03@volumehost.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101948>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2008 at 05:40:02PM -0600, "Boyd Stephen Smith Jr." <bss03@v=
olumehost.net> wrote:
> You might look deeper into Darcs development.  This level of=20
> pluggable "understanding" of the file(s) being modified fits in well with=
 a=20
> Grand Unified Theory of Patching.  Also "understanding" patches better al=
lows=20
> Darcs to reorder patches (and calculate "reverse patches") better -- redu=
cing=20
> the time to do existing automatic merging (or reject the merge as=20
> non-automatable) and make merges automatic that are currently not handled=
=20
> automatically.
>=20
> I'm not going to come out and discourage you or other from adding the=20
> functionality to git, but I think there are more useful and practical way=
s to=20
> improve git.  (Line-by-line merging is generally "good enough", the worst=
=20
> enemy of "good" software.)

I think this was already discussed:

http://thread.gmane.org/gmane.comp.version-control.git/60457/focus=3D60512

If you mean just looking at the code moves/copies between the trees (but
no other history), then a merge strategy which makes use of git blame's
code move/copy detection would be indeed nice, though nobody created it
so far.

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkyAFAACgkQe81tAgORUJbWLwCfVQK2VW4BEYh8u15Pz+mL8blo
+XAAnjMgNeMCHAmlmvUpWUUG7NPWFHbB
=SAQB
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
