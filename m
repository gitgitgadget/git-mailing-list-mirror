From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git branch -D: give a better error message when
 lockfile creation fails
Date: Sun, 27 Sep 2009 10:49:06 +0200
Message-ID: <20090927084906.GR32702@genesis.frugalware.org>
References: <vpqy6o15v6m.fsf@bauges.imag.fr>
 <1254006909-1862-1-git-send-email-vmiklos@frugalware.org>
 <20090927082123.GD15393@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQrIXZbGokyKU1X6"
Cc: Matthieu.Moy@grenoble-inp.fr, spearce@spearce.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrpRU-0003T8-7F
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbZI0ItF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 04:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbZI0ItF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:49:05 -0400
Received: from virgo.iok.hu ([212.40.97.103]:42765 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529AbZI0ItE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 04:49:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CCEC058089;
	Sun, 27 Sep 2009 10:49:06 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5B02844906;
	Sun, 27 Sep 2009 10:49:06 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 40EAC11F0028; Sun, 27 Sep 2009 10:49:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090927082123.GD15393@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129203>


--yQrIXZbGokyKU1X6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 27, 2009 at 04:21:23AM -0400, Jeff King <peff@peff.net> wrote:
> Maybe it is just me, but that extra die() that should never be reached
> is terribly ugly. I would do it with two functions, one that dies and
> one that doesn't, with a helper to format the message. IOW, this:

Okay, that's fine with me - thanks for providing a patch as well.

--yQrIXZbGokyKU1X6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq/JwIACgkQe81tAgORUJYriQCfZLS5ldLlxrDNNCN9MrkJRWa8
KIwAn3Os1AMMldgUBJR851KP5RCdLR5j
=g9qn
-----END PGP SIGNATURE-----

--yQrIXZbGokyKU1X6--
