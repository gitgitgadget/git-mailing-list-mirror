From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add SVN->Git conversion example to documentation
Date: Sat, 14 Jun 2008 21:06:48 +0200
Message-ID: <20080614190648.GF29404@genesis.frugalware.org>
References: <20080614180929.GA26449@zakalwe.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A0ITfjB2SU22lvQn"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sat Jun 14 21:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7b6u-0006lN-Ps
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 21:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYFNTGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 15:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbYFNTGw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 15:06:52 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47818 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbYFNTGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 15:06:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9F7CF1B2548;
	Sat, 14 Jun 2008 21:06:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5AF0F44698;
	Sat, 14 Jun 2008 20:47:25 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F1C461778001; Sat, 14 Jun 2008 21:06:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080614180929.GA26449@zakalwe.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85038>


--A0ITfjB2SU22lvQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 14, 2008 at 09:09:29PM +0300, Heikki Orsila <heikki.orsila@iki.fi> wrote:
> +------------------------------------------------------------------------
> +# Convert all branches of an SVN repository to a Git repository:
> +
> +	git svn clone --no-metadata -A authors.txt SVN_URL foo.git

Don't you need -s here?

Two other minor notes:

1) I would add an example on how to update such a repo in case it will
be a mirror, like 'git --bare svn fetch'.

2) I would mention that one still needs a trick if he/she wants to allow
others to clone this repo, with something like:

git config remote.origin.url .
git config remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
git config --add remote.origin.fetch +refs/remotes/*:refs/heads/*
git fetch

--A0ITfjB2SU22lvQn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhUFsgACgkQe81tAgORUJbtwQCeLXQ7GzRF4zze9cN9xVO4GX4O
7iQAnih1iqnO/6SN5kfNfPZ8eyINX5yE
=Wm6I
-----END PGP SIGNATURE-----

--A0ITfjB2SU22lvQn--
