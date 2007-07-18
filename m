From: Simon Hausmann <simon@lst.de>
Subject: git-p4 pull request
Date: Wed, 18 Jul 2007 17:42:07 +0200
Message-ID: <200707181742.12046.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart35914933.KYmTa1NVAI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 17:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBBeu-0004st-In
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 17:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbXGRPl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 11:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759388AbXGRPlZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 11:41:25 -0400
Received: from verein.lst.de ([213.95.11.210]:41896 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057AbXGRPlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 11:41:25 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6IFelNK024116
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Wed, 18 Jul 2007 17:40:48 +0200
User-Agent: KMail/1.9.7
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52869>

--nextPart35914933.KYmTa1NVAI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following changes since commit a5e407988b35b7353bd03c770afc647670c25981:
  Jim Meyering (1):
        git-cvsserver: detect/diagnose write failure, etc.

are available in the git repository at:

  git://people.freedesktop.org/~hausmann/git-p4 master

Scott Lamb (2):
      git-p4: use subprocess in p4CmdList
      git-p4: input to "p4 files" by stdin instead of arguments

Simon Hausmann (3):
      git-p4: Cleanup, make listExistingP4Branches a global function for later use.
      git-p4: Fix upstream branch detection for submit/rebase with multiple branches.
      git-p4: Cleanup, used common function for listing imported p4 branches

 contrib/fast-import/git-p4 |  129 ++++++++++++++++++++++++--------------------
 1 files changed, 70 insertions(+), 59 deletions(-)


I have used Scotts changes for two days now and had no problems at all.
Based on Alex Riesen's suggestion they are a nice solution around the commandline
limits when calling the p4 client.

The other three changes fix a rather ugly bug when importing multiple depot
paths through p4 branch mappings where it could happen in the end that changes
that were done in git were submitted into the wrong depot paths in perforce itself
due to a faulty rebase onto the wrong git branch.

Would be great if those changes could be included in master.


Thanks,
Simon

--nextPart35914933.KYmTa1NVAI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGnjTTWXvMThJCpvIRAsmcAJ4h2f6fqP9TnFFL/TLSME5GbzcJJwCgrwA4
be6mw7290mSz60sZ55ETAEk=
=qTYv
-----END PGP SIGNATURE-----

--nextPart35914933.KYmTa1NVAI--
