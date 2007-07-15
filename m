From: VMiklos <vmiklos@frugalware.org>
Subject: Re: question about git-submodule
Date: Mon, 16 Jul 2007 00:29:48 +0200
Message-ID: <20070715222948.GL7106@genesis.frugalware.org>
References: <20070715105450.GD7106@genesis.frugalware.org> <20070715135057.GI2568@steel.home> <20070715135453.GE7106@genesis.frugalware.org> <20070715140244.GF999MdfPADPa@greensroom.kotnet.org> <20070715142624.GF7106@genesis.frugalware.org> <20070715144835.GI999MdfPADPa@greensroom.kotnet.org> <20070715150540.GH7106@genesis.frugalware.org> <20070715152101.GJ999MdfPADPa@greensroom.kotnet.org> <20070715154028.GI7106@genesis.frugalware.org> <20070715214530.GK999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jul 16 00:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IACbW-0007Rp-C1
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 00:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbXGOW35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 18:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbXGOW35
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 18:29:57 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40669 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbXGOW34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 18:29:56 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IACbC-0000QY-Kd
	from <vmiklos@frugalware.org>; Mon, 16 Jul 2007 00:29:54 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 25FB216A8091; Mon, 16 Jul 2007 00:29:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715214530.GK999MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52593>


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Na Sun, Jul 15, 2007 at 11:45:30PM +0200, Sven Verdoolaege <skimo@kotnet.org> pisal(a):
> You should do a git submodule init first.

nice, now it works :)

then my question would be if the following workflow is possible or not:

1) you told me how to do the following:

a) somebody updates libfoo

b) a dev of main pulls libfoo, commits something like:

diff --git a/libfoo b/libfoo
index 07ceadb..459b61f 160000
--- a/libfoo
+++ b/libfoo
@@ -1 +1 @@
-Subproject commit 07ceadb17ca73636b0d96cb91688baecb1763d9b
+Subproject commit 459b61fa4bba78a6e6542b8fcc0fd8f320eafa8c

c) users have to "git pull; git submodule update" and they'll be happy

2) is it possible to do this without step b)?

i mean adding something like: "Subproject commit HEAD" or "Subproject
commit mybranch"

thanks,
- VMiklos

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGmp/ce81tAgORUJYRAqXKAJ9mVLIvEAKVko3jDVkuF21qk7bg1QCfZlNZ
swSqjeY7WaDTQfUxqL0AKGU=
=o/6z
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--
