From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/2] Introduce receive.guardCurrentBranch
Date: Mon, 24 Mar 2008 02:21:39 +0100
Message-ID: <20080324012139.GV14567@genesis.frugalware.org>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XilfshMFnlxBucLf"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 02:22:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdbOM-000586-Jr
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbYCXBVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 21:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbYCXBVq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:21:46 -0400
Received: from virgo.iok.hu ([193.202.89.103]:25659 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882AbYCXBVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:21:45 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3B8861B24FC;
	Mon, 24 Mar 2008 02:21:44 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 791FC44697;
	Mon, 24 Mar 2008 02:18:39 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 771561B64142; Mon, 24 Mar 2008 02:21:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803232142460.4353@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77986>


--XilfshMFnlxBucLf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 23, 2008 at 09:43:43PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> +receive.guardCurrentBranch::
> +	If set to true, git-receive-pack will deny to update the ref that
> +	HEAD points to, if HEAD is not detached.  This configuration
> +	variable is set when initializing a non-bare repository.

probably i want too much, but it would be really nice if receive-pack
could just make HEAD detached. so that the user later can do a 'git
checkout -m master' to resolve possible conflicts.

--XilfshMFnlxBucLf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH5wIje81tAgORUJYRAp1PAJ0YVrMbPdCVtfHjDBW72DHN2wh4dwCeOwJw
fBktKfHY6iqjykV21DuvSVY=
=uDmd
-----END PGP SIGNATURE-----

--XilfshMFnlxBucLf--
