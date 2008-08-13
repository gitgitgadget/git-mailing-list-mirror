From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
	merge_recursive_generic()
Date: Wed, 13 Aug 2008 22:13:20 +0200
Message-ID: <20080813201320.GP18960@genesis.frugalware.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net> <20080812214410.GG18960@genesis.frugalware.org> <20080813172622.GB12871@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UrGtnQA9R6QcIU0f"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:27:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMjk-0007rl-Ve
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYHMUNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYHMUNY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:13:24 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40072 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbYHMUNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:13:23 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 856E71B2509;
	Wed, 13 Aug 2008 22:13:22 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 794FE4465E;
	Wed, 13 Aug 2008 21:20:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 122421190002; Wed, 13 Aug 2008 22:13:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813172622.GB12871@leksak.fem-net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92262>


--UrGtnQA9R6QcIU0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2008 at 07:26:22PM +0200, Stephan Beyer <s-beyer@gmx.net> wrote:
> I did not intend to replace merge_recursive() by merge_recursive_generic(),
> because merge_recursive() may be the better choice in cases where the caller
> only deals with commit objects and never with tree objects directly.
> Or if the caller does not want to lock the index or do some other stuff
> with the index...
> In that case merge_recursive_setup() is still needed, isn't it?

Hm, OK. I was not aware pure merge_recursive() will be interesting for
other builtins even after merge_recursive_generic().

--UrGtnQA9R6QcIU0f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkijQGAACgkQe81tAgORUJbAkQCfTT/9p+Tlc8awrhqlmj6WLPBf
aksAn13syokgblihjndMd2wft6ufeciY
=4e2y
-----END PGP SIGNATURE-----

--UrGtnQA9R6QcIU0f--
