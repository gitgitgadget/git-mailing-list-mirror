From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v5] gitweb: ref markers link to named shortlogs
Date: Mon, 25 Aug 2008 04:05:02 +0200
Message-ID: <20080825020502.GQ23800@genesis.frugalware.org>
References: <200808221501.54908.jnareb@gmail.com> <1219411786-14073-1-git-send-email-giuseppe.bilotta@gmail.com> <200808250153.31697.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="te9Bkl2b4W0C+FfQ"
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 04:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXRT7-0006th-Mw
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 04:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbYHYCFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 22:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYHYCFG
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 22:05:06 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52800 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbYHYCFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 22:05:05 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B3FC41B2525;
	Mon, 25 Aug 2008 04:05:02 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 37E094465E;
	Mon, 25 Aug 2008 03:06:06 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 533251788129; Mon, 25 Aug 2008 04:05:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200808250153.31697.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93586>


--te9Bkl2b4W0C+FfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 25, 2008 at 01:53:30AM +0200, Jakub Narebski <jnareb@gmail.com> wrote:
> We strip leading "refs/" in git_get_references(), so $ref does not
> contain it. I'm not sure of one has to use refs/heads/aaa and refs/tags/aaa
> to distinguish between tag and head with the same name, or heads/aaa and
> tags/aaa is enough.

You can have both heads/master and refs/heads/master, then heads/master
is ambiguous.

Given that git fsck will not barf on such a configuration, I think
gitweb should handle such a case as well.

--te9Bkl2b4W0C+FfQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiyE04ACgkQe81tAgORUJaBBwCghljuFckyLoyZiVM/H/mAivNX
mqQAn04maX4XcsROg1w1AV8fVNwdDbpZ
=5oT3
-----END PGP SIGNATURE-----

--te9Bkl2b4W0C+FfQ--
