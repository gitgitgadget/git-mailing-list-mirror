From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: having to pull twice
Date: Mon, 29 Sep 2008 17:00:49 +0200
Message-ID: <20080929150049.GT23137@genesis.frugalware.org>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com> <200809271616.32082.trast@student.ethz.ch> <20080928151135.GF23137@genesis.frugalware.org> <200809281726.23062.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JVTRtevMO87SusWP"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 29 17:02:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKG9-0001Y9-Df
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbYI2PAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbYI2PAv
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:00:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60116 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbYI2PAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:00:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 863B958134;
	Mon, 29 Sep 2008 17:00:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6D7284465E;
	Mon, 29 Sep 2008 17:00:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 175E811901A1; Mon, 29 Sep 2008 17:00:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809281726.23062.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97016>


--JVTRtevMO87SusWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 28, 2008 at 05:26:20PM +0200, Thomas Rast <trast@student.ethz.ch> wrote:
> IIUC, this is not the same as "racy git".  The racy case is if you
> manage to get a file changed immediately after its index entry was
> updated, so that it will look unchanged.  In this case, it's simply
> the same file with a new mtime, which means it looks changed
> superficially but still has the same contents.

Right. I called it "racy" because it had something to do with
timestamps. I guess we have no proper term for this kind of problem yet.
;-)

--JVTRtevMO87SusWP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjg7aEACgkQe81tAgORUJbNZQCeMw68kVF5Y628f3PEFn139vmV
XEQAn3zfKuiSvh2YUbGFA8b8t9JYcbcd
=G9qp
-----END PGP SIGNATURE-----

--JVTRtevMO87SusWP--
