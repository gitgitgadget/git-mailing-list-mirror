From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Checking for a valid email address
Date: Fri, 27 Feb 2009 10:08:07 +0100
Message-ID: <20090227090807.GQ4371@genesis.frugalware.org>
References: <799406d60902261928q2c691112yf24d01b92a3dad6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e/6p6d7vICK/GCJ"
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 10:09:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcyiz-0004dO-8v
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 10:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbZB0JIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 04:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZB0JIM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 04:08:12 -0500
Received: from virgo.iok.hu ([212.40.97.103]:38153 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbZB0JIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 04:08:10 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 19108580D1;
	Fri, 27 Feb 2009 10:08:08 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E53D0446D6;
	Fri, 27 Feb 2009 10:08:06 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2679B11B877C; Fri, 27 Feb 2009 10:08:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <799406d60902261928q2c691112yf24d01b92a3dad6c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111650>


--6e/6p6d7vICK/GCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2009 at 09:28:59PM -0600, Adam Mercer <ramercer@gmail.com> wrote:
> We are in the process of migrating some of our repositories from CVS
> to Git in a two step process, first to a centralised Git setup then
> (hopefully) onto a more distributed development model. In the testing
> we have been doing so far the only problem we have run into is
> developers not setting their email addresses correctly so the
> changelogs are filled with spurious address. Does anyone know of a
> pre-commit hook that could check for a valid email address prior to
> allowing a commit? Or another way that this can be acheived?

You can use a script like this:

http://www.perl.com/CPAN/authors/Tom_Christiansen/scripts/ckaddr.gz

Other helpful git commands to get the current email address:

git var GIT_AUTHOR_IDENT
git config user.name
git config user.email

You can do the rest, hopefully. :)

--6e/6p6d7vICK/GCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmnrXcACgkQe81tAgORUJb9YgCdFQaGo88j5lIp7j7rl3Cr7yY8
VSAAn2TkS0SS2y+XSZmT9shySWGUQbuB
=Ql8S
-----END PGP SIGNATURE-----

--6e/6p6d7vICK/GCJ--
