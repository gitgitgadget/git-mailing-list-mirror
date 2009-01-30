From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 03:30:40 +0100
Message-ID: <20090130023040.GR21473@genesis.frugalware.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxd4aqMUuikGjl19"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 03:32:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSjB9-0005vd-6V
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 03:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbZA3Cap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 21:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbZA3Cap
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 21:30:45 -0500
Received: from virgo.iok.hu ([212.40.97.103]:51771 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbZA3Cao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 21:30:44 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 441505814B;
	Fri, 30 Jan 2009 03:30:42 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 567994465E;
	Fri, 30 Jan 2009 03:30:40 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 529D511B87A9; Fri, 30 Jan 2009 03:30:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107765>


--Qxd4aqMUuikGjl19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2009 at 01:34:28AM +0100, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> -		error("refusing to update checked out branch: %s", name);
> +		error("refusing to update checked out branch: %s\n"
> +			"if you know what you are doing, you can allow it by "
> +			"setting\n\n"
> +			"\tgit config receive.denyCurrentBranch true\n", name);

Shouldn't this be

git config receive.denyCurrentBranch ignore

instead of "true"?

--Qxd4aqMUuikGjl19
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCZlAACgkQe81tAgORUJYRxQCaAkqvAzUtVltMOz+DVEkKTQSy
0PsAnAzcpu007DKpiJsSN+iJQSAj3+SI
=HdYq
-----END PGP SIGNATURE-----

--Qxd4aqMUuikGjl19--
