From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Converting from svn to git
Date: Sun, 10 Aug 2008 15:24:09 +0200
Message-ID: <20080810132409.GE18960@genesis.frugalware.org>
References: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Cc: git@vger.kernel.org
To: David Neu <david@davidneu.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 15:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSAty-0008Gf-Lj
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 15:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbYHJNXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 09:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbYHJNXD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 09:23:03 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57545 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbYHJNXB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 09:23:01 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 898791B24FA;
	Sun, 10 Aug 2008 15:23:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6A1274465E;
	Sun, 10 Aug 2008 14:31:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0A5CB1770019; Sun, 10 Aug 2008 15:24:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91838>


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 10, 2008 at 09:11:43AM -0400, David Neu <david@davidneu.com> wrote:
> Is there a git-svn strategy similar to git-svnimport -P that would do the trick?
> My git version 1.5.6.4 doesn't include git-svnimport, and I'm getting
> the impression
> it's be deprecated.

Sure, it is. Though if you _really_ need it, it's still under
/contrib/examples.

Anyway, if you do a single conversion, then probably speed does not
matter a lot; I would do a full import then use the subdirectory-filter
of git filter-branch do drop everything outside the subdirectory.

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkie6/kACgkQe81tAgORUJY1TQCgjGOdq5wi56PXhTdk2zQzBv8b
PyEAniWp/KzpYoO1r/htRlc3XJtmfnTN
=WxEG
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
