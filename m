From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 16:55:34 +0200
Message-ID: <20080730145534.GD32057@genesis.frugalware.org>
References: <20080730133859.368bbd92@pc09.procura.nl> <20080730133334.GB31192@lars.home.noschinski.de> <20080730155835.71289eee@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Dq4f+xZ7+xHwkrO"
Cc: Lars Noschinski <lars-2008-1@usenet.noschinski.de>,
	git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOD6V-0007Dy-UM
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762233AbYG3Ozg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762214AbYG3Ozg
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:55:36 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37036 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762169AbYG3Ozf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:55:35 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5DE481B24FD;
	Wed, 30 Jul 2008 16:55:34 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 075274465E;
	Wed, 30 Jul 2008 16:10:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1C05B1190A16; Wed, 30 Jul 2008 16:55:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080730155835.71289eee@pc09.procura.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90797>


--5Dq4f+xZ7+xHwkrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2008 at 03:58:35PM +0200, "H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
> We are not used to working with $SHA's, and IMHO from the end-user pov,
> a $SHA is less user friendly than a release number or a file version. I
> can remember a version, but I cannot remember a SHA.

But a version is never unique in a distributed environment. So a version
is useless without at least an abbreviated hash.

If pure hashes are not friendly enough, you can use something like:

git describe $(git rev-list -1 HEAD -- <file>)

to get the _hash_ of the _commit_ (ie. not the version of a file) that
touched the file last time.

--5Dq4f+xZ7+xHwkrO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiQgOYACgkQe81tAgORUJYVaQCfbWetMrpKxYr1rzNqxJneRTsR
5goAn1w+8qrJzmc/lNPDaeS11vn24YQQ
=p1bi
-----END PGP SIGNATURE-----

--5Dq4f+xZ7+xHwkrO--
