From: Valdis.Kletnieks@vt.edu
Subject: Re: git guidance
Date: Sat, 08 Dec 2007 00:16:27 -0500
Message-ID: <7135.1197090987@turing-police.cc.vt.edu>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712072204.48410.a1426z@gawab.com> <11272.1197056185@turing-police.cc.vt.edu>
            <200712080756.21980.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1197090987_2992P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 06:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0s3h-0000km-Jy
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 06:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbXLHFQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 00:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXLHFQj
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 00:16:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:42417 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbXLHFQi (ORCPT <RFC822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 00:16:38 -0500
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [127.0.0.1])
	by turing-police.cc.vt.edu (8.14.2.Alpha0/8.14.2.Alpha0) with ESMTP id lB85GR1B007137;
	Sat, 8 Dec 2007 00:16:27 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
In-Reply-To: Your message of "Sat, 08 Dec 2007 07:56:21 +0300."
             <200712080756.21980.a1426z@gawab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67517>

--==_Exmh_1197090987_2992P
Content-Type: text/plain; charset=us-ascii

On Sat, 08 Dec 2007 07:56:21 +0300, Al Boldi said:

> It probably goes without saying, that gitfs should have some basic 
> configuration file to setup its transparent behaviour

But then it's not *truly* transparent, is it?

And that leaves another question - if you make a config file that excludes
all the .o files - then what's backing the .o files?  Those data blocks need
to be *someplace*.  Maybe you can do something ugly like use unionfs to
combine your gitfs with something else to store the other files...

But at that point, you're probably better off just creating a properly
designed versioning filesystem.

--==_Exmh_1197090987_2992P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHWiircC3lWbTT17ARAiEqAJ9+8RurRYI6jjSiX/BaqiNZGJ97AACfTOAw
g5Y8Lh36QWvSod8+Zbh9d9E=
=DvZ0
-----END PGP SIGNATURE-----

--==_Exmh_1197090987_2992P--
