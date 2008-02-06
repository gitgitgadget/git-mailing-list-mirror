From: Jan-David Quesel <jdq@gmx.net>
Subject: Bug-Report git-svn Empty Repository
Date: Wed, 6 Feb 2008 11:30:40 +0100
Organization: Carl von Ossitzky =?iso-8859-1?Q?Universit?=
	=?iso-8859-1?Q?=E4t?= Oldenburg
Message-ID: <20080206103037.GD14130@mort.hrz.uni-oldenburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 12:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMi5t-0007lZ-2e
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 12:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbYBFLFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 06:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYBFLFA
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 06:05:00 -0500
Received: from arbi.Informatik.Uni-Oldenburg.DE ([134.106.1.7]:57169 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750726AbYBFLE7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 06:04:59 -0500
X-Greylist: delayed 2057 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2008 06:04:59 EST
Received: from taifun.Informatik.Uni-Oldenburg.DE ([134.106.11.36])
	by arbi.Informatik.Uni-Oldenburg.DE (Exim 3.36)
	id 1JMhY8-0003jg-00; Wed, 06 Feb 2008 11:30:40 +0100
Received: from withoutHELO (noIP)
	by taifun.Informatik.Uni-Oldenburg.DE (Exim 4.66)
	id 1JMhY8-0003CQ-0n; Wed, 06 Feb 2008 11:30:40 +0100
Content-Disposition: inline
X-OS: Linux mort 2.6.23-gentoo-r3 x86_64
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72799>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

I just tried to replay a stack of patches into a fresh svn
repository. The repository was created in an empty state
(revision 0). It could be checkout out fine using git-svn, but
trying to do git svn dcommit or git svn rebase fails, as $url
does not get initialized in git-svn:410, I think extract_metadata
fails.

I'm using "git-svn version 1.5.4 (svn 1.4.5)".

regards,
Jan

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHqYxNzWWUYNynIPERAgq6AJ9MW8yrkezA9WkUSCgOjWrv6dS4HACgtQyj
6HGiDlwxQbjzFznuQ8LQFZM=
=4iO7
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
