From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Importing non-version controlled bits and pieces to Git
Date: Fri, 20 Jun 2008 13:51:02 +0200
Message-ID: <20080620115102.GW29404@genesis.frugalware.org>
References: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mh7amEEZWgRn5zCw"
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 20 13:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fA1-0000h9-Qm
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 13:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbYFTLvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYFTLvI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 07:51:08 -0400
Received: from virgo.iok.hu ([193.202.89.103]:39780 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbYFTLvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 07:51:07 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F2E6F1B2510;
	Fri, 20 Jun 2008 13:51:04 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D6A8F44697;
	Fri, 20 Jun 2008 13:28:26 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 786711190AD9; Fri, 20 Jun 2008 13:51:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806201036440.24013@ds9.cixit.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85623>


--mh7amEEZWgRn5zCw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2008 at 10:42:22AM +0100, Peter Karlsson <peter@softwolves.=
pp.se> wrote:
> I am looking at moving a project that has not been version-controlled
> in the regular sense into Git. I have found it to currently consist of
> 40 directories with copies of the set of files in various shapes.
>=20
> I have reconstructed something that looks like a probable revision tree
> for these 40 directories, and I want to put this into Git so that I can
> examine what changes have been made where, and merge the various
> versions back together so that there can be one version with all the
> various fixes.

Maybe contrib/fast-import/import-tars.perl?

It imports tar.{gz,bz2,Z} files, but you can tar up your trees or it can
just serve as an example and you can write your own script that does the
same with directories.

--mh7amEEZWgRn5zCw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhbmaYACgkQe81tAgORUJa0TQCgoulaDpI5GF6hxLKvWtDbYWDJ
hn4AniV2ZYT8LQV7OTiYaoeem/2NXzdX
=kbKa
-----END PGP SIGNATURE-----

--mh7amEEZWgRn5zCw--
