From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 00:48:08 +0200
Message-ID: <20081016224808.GO536@genesis.frugalware.org>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hbBJ5WP8dkNDDowN"
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 00:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqbet-0005Z4-5P
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 00:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbYJPWsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 18:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756111AbYJPWsL
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 18:48:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42088 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbYJPWsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 18:48:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6D17F580DE;
	Fri, 17 Oct 2008 00:48:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5654F4465E;
	Fri, 17 Oct 2008 00:48:08 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3769811901A1; Fri, 17 Oct 2008 00:48:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98431>


--hbBJ5WP8dkNDDowN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2008 at 12:10:55AM +0200, Richard Hartmann <richih.mailinglist@gmail.com> wrote:
> all changes were submitted. Of course, I now have a
> file with the conflict markers inlined in my repository. Not
> a good thing, imo. Is there a way to make git block all
> conflicting versions?

Write a pre-commit hook that checks for conflict markers?

> Also, I would be interested in the design decissions
> behind the current behaviour. Any pointers?

Not sure, but in general blocking conflict markers by default would be a
bad idea IMHO, several markup language (asciidoc, for example) makes use
of the >>>, === and such character sequences.

--hbBJ5WP8dkNDDowN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3xKgACgkQe81tAgORUJY7gQCfX5GdvAqj6wMvhV9IR0uOpr8X
3LwAni6G6BCnbSkIiVj+Vm4lsklrWla2
=1LAA
-----END PGP SIGNATURE-----

--hbBJ5WP8dkNDDowN--
