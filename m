From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Showing changes about to be commited via git svn dcommit
Date: Tue, 29 Jul 2008 01:53:26 +0200
Message-ID: <20080728235326.GQ32057@genesis.frugalware.org>
References: <7968d7490807281554u3954cf51qe2cd87b94284c77f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fpw32LjOclf2mikU"
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:54:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcXu-0007wF-Oy
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYG1Xxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbYG1Xxa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:53:30 -0400
Received: from virgo.iok.hu ([193.202.89.103]:58848 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbYG1Xx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:53:29 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AC0A01B2526;
	Tue, 29 Jul 2008 01:53:28 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2B7004465E;
	Tue, 29 Jul 2008 01:09:04 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6096C1190A0A; Tue, 29 Jul 2008 01:53:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7968d7490807281554u3954cf51qe2cd87b94284c77f@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90527>


--fpw32LjOclf2mikU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 04:54:19PM -0600, Lee Marlow <lee.marlow@gmail.com>=
 wrote:
> $> git svn dcommit --dry-run | grep -E '^diff-tree ' | cut -b 11- |
> git diff-tree --stdin -p -v
>=20
> Is this the real way to do it?  Do others do something similar?

Depends on how did you created your git-svn repo. If you have only one
branch with no prefix, then I would try:

        git log git-svn..master

--fpw32LjOclf2mikU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiOW/YACgkQe81tAgORUJbhqwCffZrrbwKCJByrNB5E3YIXX1ZS
M3gAoJib12qaec1AhQjqV50JrLuQF9D1
=FYQa
-----END PGP SIGNATURE-----

--fpw32LjOclf2mikU--
