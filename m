From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC] mtn to git conversion script
Date: Sun, 24 Aug 2008 15:14:05 +0200
Message-ID: <20080824131405.GJ23800@genesis.frugalware.org>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1fZJyN7nFm/tosmV"
Cc: git@vger.kernel.org, monotone-devel@nongnu.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 15:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXFR5-00088J-MB
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 15:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYHXNOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 09:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbYHXNOK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 09:14:10 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51450 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbYHXNOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 09:14:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2EA061B2504;
	Sun, 24 Aug 2008 15:14:06 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CDF464465E;
	Sun, 24 Aug 2008 14:15:26 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C2407119003C; Sun, 24 Aug 2008 15:14:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93529>


--1fZJyN7nFm/tosmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> What do you think? Does it makes sense to have a 'write-raw' command?
> Or should I somehow use 'fast-import'?

Yes, you should. ;-)

The syntax of it is not so hard, see for example 'git fast-export
HEAD~2..' on a git repo and you'll see.

This should help a lot if you are like me, who likes to learn from
examples.

--1fZJyN7nFm/tosmV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkixXp0ACgkQe81tAgORUJZWiwCfSiXtw/YepJRfVWr2tiXXrIpy
ZvEAn2Djc3me6x9+5fiWcTT6/LEY9tZF
=eGhX
-----END PGP SIGNATURE-----

--1fZJyN7nFm/tosmV--
