From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-grep: small suggestion, -w flag
Date: Sun, 22 Feb 2009 18:20:55 +0100
Message-ID: <20090222172055.GW4371@genesis.frugalware.org>
References: <20090222103448.GA32119@elte.hu> <49A133C9.2030601@lsrfire.ath.cx> <20090222161410.GA24886@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/HyWXnBjJpZe6z0y"
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:22:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbI25-00078A-1s
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbZBVRU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbZBVRU5
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:20:57 -0500
Received: from virgo.iok.hu ([212.40.97.103]:41867 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381AbZBVRU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 12:20:56 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 92794580FB;
	Sun, 22 Feb 2009 18:20:56 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 685D0446AE;
	Sun, 22 Feb 2009 18:20:55 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9E64411B877C; Sun, 22 Feb 2009 18:20:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090222161410.GA24886@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111026>


--/HyWXnBjJpZe6z0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2009 at 05:14:10PM +0100, Ingo Molnar <mingo@elte.hu> wrote:
>  earth4:~/tip> git grep -lw schedule
>  usage: git grep <option>* [-e] <pattern> <rev>* [[--] <path>...]
>=20
>=20
> should have been 'git grep -l -w schedule'.

Yeah, that's because git-grep does not use parseopt yet.

I'm willing to work on it once mv/parseopt-ls-files is settled down.

--/HyWXnBjJpZe6z0y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmhiXcACgkQe81tAgORUJYeIwCeOzhDJsgcsMbvRWEtkYXiX8LB
0cIAoKgAoG51k7J8POjDHhBvVGgF+nIr
=uaPM
-----END PGP SIGNATURE-----

--/HyWXnBjJpZe6z0y--
