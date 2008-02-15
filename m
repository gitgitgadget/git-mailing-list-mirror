From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [BUG?] packed refs and cloning via dump protocols
Date: Fri, 15 Feb 2008 19:41:09 +0100
Message-ID: <20080215184109.GW25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LlyFhrrzptpgNMGs"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 19:42:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ5VX-0001NL-Hk
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 19:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbYBOSlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 13:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbYBOSlZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 13:41:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60765 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101AbYBOSlY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 13:41:24 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JQ5Uo-0002a1-UD
	from <vmiklos@frugalware.org>
	for <git@vger.kernel.org>; Fri, 15 Feb 2008 19:41:23 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AA1ED1190520; Fri, 15 Feb 2008 19:41:09 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.2.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4970]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73974>


--LlyFhrrzptpgNMGs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

$ git clone
rsync://rsync.frugalware.org/pub/frugalware/frugalware-testing/.git
Initialized empty Git repository in
/home/vmiklos/git/test/frugalware-testing/.git/
receiving file list ... done
./
pack/
pack/pack-1f136144cd34dfe0849f2bdeacda30f6b54397db.idx
pack/pack-1f136144cd34dfe0849f2bdeacda30f6b54397db.pack

sent 177 bytes  received 49409812 bytes  890270.07 bytes/sec
total size is 49403514  speedup is 1.00
cat: .ls-remote-7290-d/refs/heads/master: No such file or directory

and yes, i just checked that the master ref is packed. is this a bug?

thanks,
- VMiklos

--LlyFhrrzptpgNMGs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHtdzFe81tAgORUJYRAuyEAKCBwlfUSVsR2nhtclkm/OaN54qHXACeLTBn
DD5MFf8m7BsKPtTzcnARxnw=
=yVap
-----END PGP SIGNATURE-----

--LlyFhrrzptpgNMGs--
