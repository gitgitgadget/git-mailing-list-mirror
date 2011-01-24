From: Sascha Peilicke <saschpe@gmx.de>
Subject: Re: [PATCH] No color diff when redirecting to file
Date: Mon, 24 Jan 2011 09:56:27 +0100
Message-ID: <201101240956.27579.saschpe@gmx.de>
References: <201101231410.48528.saschpe@gmx.de> <201101231547.18529.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1684387.VVdGzmVkRh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 09:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhIEf-0006AA-D0
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 09:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab1AXI5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 03:57:11 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:35214 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751214Ab1AXI5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 03:57:10 -0500
Received: (qmail invoked by alias); 24 Jan 2011 08:57:08 -0000
Received: from charybdis-ext.suse.de (EHLO bort.localnet) [195.135.221.2]
  by mail.gmx.net (mp008) with SMTP; 24 Jan 2011 09:57:08 +0100
X-Authenticated: #30943063
X-Provags-ID: V01U2FsdGVkX1/VYlhJEw/V8o96IQuDtjnTd2aBHKSWXmVyG4Hrcd
	UQDEwBNU0QN0TJ
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.95; x86_64; ; )
In-Reply-To: <201101231547.18529.j6t@kdbg.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165440>

--nextPart1684387.VVdGzmVkRh
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Sunday 23 January 2011 15:47:17 you wrote:
> The subject line reads as if you want that color markup appears in a file.
>=20
> On Sonntag, 23. Januar 2011, Sascha Peilicke wrote:
> > Previously, when having color diffs enabled and redirecting 'git diff'
> > into a file, one ends up with a messed up file containing termcap color
> > stuff. This change disables color when diff output is redirected into a
> > file.
>=20
> But this description and the patch read as if you don't want it.
>=20
> That said, I cannot reproduce. Perhaps your configuration says
> color.ui=3Dalways? If so, then this is expected behavior and not a bug, I=
MO.
Nope, it's color.ui=3Dauto
=2D-=20
Mit freundlichen Gr=FC=DFen,
Sascha Peilicke
http://saschpe.wordpress.com

--nextPart1684387.VVdGzmVkRh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAk09PrsACgkQDq/ykSrZt1WoDgCgsE8A8ojv79NwpckTpnzDQDGP
3ggAn1HZmxEI8FwjfRS3hKVWJc5mPWeT
=8r+E
-----END PGP SIGNATURE-----

--nextPart1684387.VVdGzmVkRh--
