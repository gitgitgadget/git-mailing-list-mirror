From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 03:56:08 +0200
Message-ID: <20080611015608.GD29404@genesis.frugalware.org>
References: <484F2174.9020508@keyaccess.nl> <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com> <484F26C9.9080608@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4gNJB4SEdaEXssw0"
Cc: David Symonds <dsymonds@gmail.com>, git <git@vger.kernel.org>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:57:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FaD-0005WL-Vj
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbYFKB4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbYFKB4M
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:56:12 -0400
Received: from virgo.iok.hu ([193.202.89.103]:33367 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbYFKB4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 21:56:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A21051B2558;
	Wed, 11 Jun 2008 03:56:09 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CFD6344697;
	Wed, 11 Jun 2008 03:37:47 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3C9FA1770022; Wed, 11 Jun 2008 03:56:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <484F26C9.9080608@keyaccess.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84576>


--4gNJB4SEdaEXssw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2008 at 03:13:45AM +0200, Rene Herman <rene.herman@keyacces=
s.nl> wrote:
> So in the case of merging a branch from the local repository into the=20
> current branch, there is no difference between the two?

There is no difference, but you really want to use git merge and not git
pull in such a case, I guess the git pull form is supported mainly to
keep backwards compatibility.

--4gNJB4SEdaEXssw0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhPMLgACgkQe81tAgORUJbFxQCgnVqamCAAVrLI3/HGATAMh9BN
wK8An3JV7eQ0ozQugwyXONsfSHJTeeEh
=UN38
-----END PGP SIGNATURE-----

--4gNJB4SEdaEXssw0--
