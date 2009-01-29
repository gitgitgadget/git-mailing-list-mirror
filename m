From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git clone --bare doesn't create refs/heads/*?
Date: Thu, 29 Jan 2009 15:40:36 +0100
Message-ID: <20090129144036.GH21473@genesis.frugalware.org>
References: <be6fef0d0901290606q25ad7c82ob250a5f89d4db0cf@mail.gmail.com> <20090129142657.GG21473@genesis.frugalware.org> <be6fef0d0901290636m5b472499mdf614841a06ec978@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SK3XQJ7YwHDQqAUa"
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSY5j-0000gF-Ky
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZA2Oki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbZA2Oki
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:40:38 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48314 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbZA2Okh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:40:37 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B6A895812E;
	Thu, 29 Jan 2009 15:40:37 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0FC5D4465E;
	Thu, 29 Jan 2009 15:40:36 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2E1DF11B87A9; Thu, 29 Jan 2009 15:40:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <be6fef0d0901290636m5b472499mdf614841a06ec978@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107687>


--SK3XQJ7YwHDQqAUa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ Please don't top-post. ]

On Thu, Jan 29, 2009 at 10:36:26PM +0800, Tay Ray Chuan <rctay89@gmail.com>=
 wrote:
> Hmm, no, --mirror adds extra remote tracking information.
>=20
> Quoting the git-clone man page:
>=20
> "...the branch heads at the remote are copied directly..."
>=20
> which is to say, git clone --bare isn't doing what it's supposed to do.
>=20
> that said, i'm not too sure about this, hence this thread.

Ah, packed refs. :)

See man git-pack-refs, git clone uses it to pack refs after a clone.
They are still in the 'packed-refs' file.

--SK3XQJ7YwHDQqAUa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmBv+QACgkQe81tAgORUJYtAwCfV2AD6/lfnNXyZ443cm7skDqm
3dcAnRwjK2ky3/Z5z7csompyDixReTt8
=Xoc5
-----END PGP SIGNATURE-----

--SK3XQJ7YwHDQqAUa--
