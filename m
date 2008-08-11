From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/2] merge-recursive: prepare merge_recursive() to be
	called from builtins
Date: Mon, 11 Aug 2008 18:46:31 +0200
Message-ID: <20080811164631.GK18960@genesis.frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org> <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org> <20080811151303.GA11208@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSaYA-0002xU-Fi
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbYHKQqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 12:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbYHKQqP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 12:46:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60114 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbYHKQqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 12:46:15 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6AEBF1B24FB;
	Mon, 11 Aug 2008 18:46:13 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2BD434465E;
	Mon, 11 Aug 2008 17:54:23 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DC9131190002; Mon, 11 Aug 2008 18:46:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080811151303.GA11208@leksak.fem-net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91961>


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2008 at 05:13:03PM +0200, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hmm, I have the long-run vision that we have a nice libgit some day,

That would be nice, but in that case I would start avoiding die() which
is an awful amount of work... (There were multiple threads on the list
previously.)

> with merge_recursive() being part of it.  And I'm a little unsure if
> libified functions should rely on environment variables.

Well, many libs do this. Random example: ld.so relies on LD_LIBRARY_PATH
as well.

Anyway sure, using function parameters instead of env vars is more
elegant.

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkigbOcACgkQe81tAgORUJa+EACfXuXn0laDMtRnH6RRL0ABAvXj
iwIAnA5RK4HAb+FoHBArl/XrBmtPyoM8
=Bw3d
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--
