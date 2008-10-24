From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-daemon and hook output
Date: Fri, 24 Oct 2008 22:39:43 +0200
Message-ID: <20081024203943.GV26961@genesis.frugalware.org>
References: <20081024050713.GA21548@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 22:41:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtTSv-0006nw-RP
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 22:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbYJXUjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 16:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbYJXUjs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 16:39:48 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57011 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbYJXUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 16:39:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 058B8580BA;
	Fri, 24 Oct 2008 22:39:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EC5BA4465E;
	Fri, 24 Oct 2008 22:39:43 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A876911901A1; Fri, 24 Oct 2008 22:39:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081024050713.GA21548@kodama.kitenet.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99064>


--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2008 at 01:07:13AM -0400, Joey Hess <joey@kitenet.net> wrote:
> I ran into this in a real-world application -- I'm implementing
> anonymous pushes into ikiwiki, which are checked pre-receive to limit
> them to changes that could be done via the web interface. So all my nice
> error messages about why a commit is refused are not available, which is
> a pity.

I think the recommended protocol even for anonymous push is ssh, at
least that's what repo.or.cz uses for the 'mob' user, which is
equivalent to anonymous, AFAIK.

(The source is available under repo.git, I did not have a look how one
can set up an account - using git-shell - that can be used without a
password.)

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkCMo8ACgkQe81tAgORUJalyACgiJELKNfsthEe5wqJ0h2eMRgK
6+gAn3MvUMKgQhGrWAhHVPBHm9wpJWHu
=E0Rt
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--
