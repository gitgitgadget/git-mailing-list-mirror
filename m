From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 15:25:59 +0100
Message-ID: <20091219142559.GF25474@genesis.frugalware.org>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
 <20091219020947.GB10687@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6eUvXotnMb6+obQB"
Cc: Junio C Hamano <gitster@pobox.com>, Moe <moe@signalbeam.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 15:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM0GL-0002Tv-4Y
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 15:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZLSO0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 09:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbZLSO0I
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 09:26:08 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35648 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbZLSO0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 09:26:05 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AB2C858094;
	Sat, 19 Dec 2009 15:25:59 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5A2BE44965;
	Sat, 19 Dec 2009 15:25:59 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 552E41240014; Sat, 19 Dec 2009 15:25:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091219020947.GB10687@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135482>


--6eUvXotnMb6+obQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 18, 2009 at 06:09:47PM -0800, "Shawn O. Pearce" <spearce@spearce.org> wrote:
> What file does `git config --add` modify?  Should we be able to
> modify the GIT_CONFIG_EXTRA file?

git config --add will still write .git/config (or $GIT_CONFIG) as
before. At the moment there is no way to modify a GIT_CONFIG_EXTRA file
using git-config.

> What order is GIT_CONFIG_EXTRA applied in relative to other files
> that git config would also have read?

The config file from GIT_CONFIG_EXTRA is the last one that is read.

Adding the above feature and documenting the later answer could be done
in a second version of such a patch, but as far as I see it's no good
doing so because then patch solves a non-exsiting problem. ;-)

--6eUvXotnMb6+obQB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkss4ncACgkQe81tAgORUJaGpQCgpJVxRWPLEWlG8gKWR5eesCKQ
3TwAn05a8ezV3I2dYw5mA8AUiJYGJQho
=aBrR
-----END PGP SIGNATURE-----

--6eUvXotnMb6+obQB--
