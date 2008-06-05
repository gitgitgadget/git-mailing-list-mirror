From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Sharing home and etc files with git
Date: Thu, 5 Jun 2008 22:50:31 +0200
Message-ID: <20080605205031.GH29404@genesis.frugalware.org>
References: <48484607.5090505@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AG41CdL1ZWVzkk/P"
Cc: git@vger.kernel.org
To: iiijjjiii <iiijjjiii@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 22:51:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MR3-0008FY-9H
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbYFEUuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761280AbYFEUuf
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:50:35 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37226 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbYFEUue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:50:34 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 992491B252C;
	Thu,  5 Jun 2008 22:50:32 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D20154469E;
	Thu,  5 Jun 2008 22:32:54 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EBAC11190ACA; Thu,  5 Jun 2008 22:50:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48484607.5090505@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83978>


--AG41CdL1ZWVzkk/P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2008 at 04:01:11PM -0400, iiijjjiii <iiijjjiii@gmail.com> w=
rote:
> I would like to use git to keep revision histories of my home and etc=20
> directories.

First, git is to track content, not permissions. So it is not the right
tool.

Second, you can try etckeeper which does this on top of git.

But still please keep in mind that you may have serious problems, like:
if you get a conflict in /etc/passwd, you may not be able to login,
etc...

--AG41CdL1ZWVzkk/P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhIUZcACgkQe81tAgORUJb8rgCeKTWz3O21jUApus9DHFLLqXVT
BwgAn0I11kUqDMIVofYiXjJyV7n6msey
=piy0
-----END PGP SIGNATURE-----

--AG41CdL1ZWVzkk/P--
