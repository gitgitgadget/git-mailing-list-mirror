From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation: fix description for enabling hooks
Date: Wed, 17 Dec 2008 05:13:12 +0100
Message-ID: <20081217041312.GZ5691@genesis.frugalware.org>
References: <200812170359.24109.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UN41tlPsqEEbq75"
Cc: gitster@pobox.com, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 05:14:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCnnr-0005X0-6D
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 05:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbYLQENN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 23:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbYLQENN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 23:13:13 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54198 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbYLQENN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 23:13:13 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E5006580A1;
	Wed, 17 Dec 2008 05:13:11 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DF74F4465E;
	Wed, 17 Dec 2008 05:13:11 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 120A611B862F; Wed, 17 Dec 2008 05:13:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812170359.24109.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103305>


--5UN41tlPsqEEbq75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2008 at 03:59:23AM +0100, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> Since f98f8cb (Ship sample hooks with .sample suffix, 2008-06-24) hooks
> are not enabled by making them executable anymore, but by removing the
> '.sample' suffix from the filename.

This is true, but having the executable bit is necessary as well. I
think it would be better to just append this requirement instead of
replacing the old one with this.

--5UN41tlPsqEEbq75
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklIfFgACgkQe81tAgORUJb2vgCfdQt/4SjWvmclBGPCxpLDJLb8
EmUAn25n+egyGfugnS0S6nfSaVUC/K1Y
=xgVt
-----END PGP SIGNATURE-----

--5UN41tlPsqEEbq75--
