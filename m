From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: no --dry-run to git-pull ?
Date: Fri, 4 Jul 2008 15:59:44 +0200
Message-ID: <20080704135944.GA4729@genesis.frugalware.org>
References: <912ec82a0807040656y1c48cba8m6f9981f6bb97b36a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CgyvWwj/llZsteoZ"
Cc: git@vger.kernel.org
To: Neshama Parhoti <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 16:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElqg-00046u-TY
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 16:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489AbYGDN7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759502AbYGDN7r
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:59:47 -0400
Received: from virgo.iok.hu ([193.202.89.103]:56504 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759495AbYGDN7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:59:46 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D9D781B24FF;
	Fri,  4 Jul 2008 15:59:44 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CF5CB44698;
	Fri,  4 Jul 2008 15:29:11 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A53A311901F1; Fri,  4 Jul 2008 15:59:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <912ec82a0807040656y1c48cba8m6f9981f6bb97b36a@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87395>


--CgyvWwj/llZsteoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 04, 2008 at 04:56:27PM +0300, Neshama Parhoti <pneshama@gmail.com> wrote:
> Isn't there a way to do a --dry-run with git-pull ?

Not really. But you can do a 'git fetch origin', then a
'git log master..origin/master', and it'll tell you what changes will be
merged if you do a 'git merge origin/master'.

NOTES:

1) Replace origin and master with your repomte and branch.

2) If this sounds cryptic for you, then it might be an important info
that by default a pull is a fetch + a merge.

--CgyvWwj/llZsteoZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhuLNAACgkQe81tAgORUJaADACeMKvx+qyHWJ20dFkcMRC/CjM3
h5gAniXQhZT2wiyYq1bsn43526qhYmxz
=emmG
-----END PGP SIGNATURE-----

--CgyvWwj/llZsteoZ--
