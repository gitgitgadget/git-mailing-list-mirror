From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 15:59:08 +0200
Message-ID: <20081016135908.GI536@genesis.frugalware.org>
References: <48F730D0.9040008@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xEruU51OOzV9VdJQ"
Cc: git@vger.kernel.org
To: Rick Moynihan <rick@calicojack.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 16 16:00:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqTOt-0004SO-BR
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 16:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbYJPN7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 09:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbYJPN7L
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 09:59:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54764 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbYJPN7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 09:59:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id EDD47580DA;
	Thu, 16 Oct 2008 15:59:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DAB114465E;
	Thu, 16 Oct 2008 15:59:08 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A42FB11901A1; Thu, 16 Oct 2008 15:59:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F730D0.9040008@calicojack.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98382>


--xEruU51OOzV9VdJQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2008 at 01:17:20PM +0100, Rick Moynihan <rick@calicojack.co=
=2Euk> wrote:
> I have a master branch, a dev branch and a number of feature branches fro=
m=20
> dev.  And I was wondering if there was an easy way to rebase dev and all =
of=20
> it's sub-branches onto master.

In general this is considered harmful. Why do you rebase your branch
=66rom time to time? For example in git.git, topic branches are based on
master, then merged to master when they are ready, but they are never
rebased.

--xEruU51OOzV9VdJQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3SKwACgkQe81tAgORUJarkQCfesG9GB/Lf2ABM1ENQELJXj9C
6H4An1yw2UpvyMBJkdE7OkgYEHqiRJXm
=o7Li
-----END PGP SIGNATURE-----

--xEruU51OOzV9VdJQ--
