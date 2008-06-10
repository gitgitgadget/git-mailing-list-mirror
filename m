From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Tue, 10 Jun 2008 02:03:40 +0200
Message-ID: <20080610000340.GY29404@genesis.frugalware.org>
References: <alpine.DEB.1.00.0806091458190.1783@racer> <1213051426-11530-1-git-send-email-vmiklos@frugalware.org> <7v8wxefbtn.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806100024310.1783@racer> <7vlk1edvn1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lzTnM044bxJwS9+G"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5rLp-00064x-4G
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 02:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbYFJADo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 20:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYFJADo
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 20:03:44 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57648 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbYFJADn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 20:03:43 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7D5E21B24FA;
	Tue, 10 Jun 2008 02:03:42 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3CBAB44697;
	Tue, 10 Jun 2008 01:45:20 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 258DA1770022; Tue, 10 Jun 2008 02:03:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlk1edvn1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84460>


--lzTnM044bxJwS9+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 09, 2008 at 04:41:06PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Actually a quick glance at git-merge, a rather large case...esac after
> that "show-branch --merge-base" tells me that we do not really use the
> output from that operation and instead we check if we are fast-forward
> from all the other heads by iterating over them.  merge-octupos would
> accept it as the base but never looks at it.

I may be wrong but I think it would be still nice to pass a valid base
to the backend, even if _currently_ the only octopus implementation
ignores it.

Actually on "valid" I mean what my original get_octopus_merge_bases()
returned. :-)

--lzTnM044bxJwS9+G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhNxNwACgkQe81tAgORUJYAdACgm/e1VE0ek1pp5G9ExntbbO5m
mwQAn3pEZH9zYQIXtEtuf0Dp8trMHapZ
=8DS7
-----END PGP SIGNATURE-----

--lzTnM044bxJwS9+G--
