From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [ANNOUNCE] TopGit - A different patch queue manager
Date: Sun, 3 Aug 2008 09:27:26 +0200
Message-ID: <20080803072726.GB32057@genesis.frugalware.org>
References: <20080803031424.GV32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qmZeNP3jAKWqBt+w"
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 03 09:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPY0y-0007Pw-PL
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 09:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYHCH12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 03:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbYHCH12
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 03:27:28 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50205 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375AbYHCH11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 03:27:27 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7073A1B24FC;
	Sun,  3 Aug 2008 09:27:26 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BE5244465E;
	Sun,  3 Aug 2008 08:40:03 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 411801770071; Sun,  3 Aug 2008 09:27:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080803031424.GV32184@machine.or.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91212>


--qmZeNP3jAKWqBt+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 03, 2008 at 05:14:24AM +0200, Petr Baudis <pasky@suse.cz> wrote:
> 	(iii) Actually _WORK_ in the distributed environment;
> 	you can have several repositories and develop your patches
> 	in all of them

As we discussed on IRC, this means that unlike git rebase -i and others,
the history of such rebases is not stored in reflogs (which are not
transfered) but stored with this "one branch, one patch" logic.

>   P.P.S.: Can I get trademark on the (ironically) /[^p]g/ porcelains
> now? ;-)

Heh, no please. I have a porcelain called 'dg'[0] after 'darcs-git', which
imitates some of the darcs UI, but operating on a git repo. ;-)

[0] http://tinyurl.com/5lfs5g, http://tinyurl.com/6pb772

--qmZeNP3jAKWqBt+w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiVXd4ACgkQe81tAgORUJYovACfVpCoqCo2IsNp6SSCFzYtAJ28
CSQAn1KQiudLuDGYrY8VpuyII/pE+BJR
=F9Hl
-----END PGP SIGNATURE-----

--qmZeNP3jAKWqBt+w--
