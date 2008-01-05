From: Miklos Vajna <vmiklos@frugalware.org>
Subject: how to use git merge -s subtree?
Date: Sun, 6 Jan 2008 00:00:04 +0100
Message-ID: <20080105230004.GY29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q/AGl/UrDvkbRExF"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 00:00:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBI0U-00077y-1N
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 00:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYAEXAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 18:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYAEXAH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 18:00:07 -0500
Received: from virgo.iok.hu ([193.202.89.103]:46311 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbYAEXAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 18:00:06 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 26C091B2545
	for <git@vger.kernel.org>; Sun,  6 Jan 2008 00:00:05 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1E8BC4466A
	for <git@vger.kernel.org>; Sat,  5 Jan 2008 23:58:29 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DEE4111904E4; Sun,  6 Jan 2008 00:00:04 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69692>


--Q/AGl/UrDvkbRExF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

i recently noticed that the subtree merge strategy is missing from
merge-strategies.txt an i tried to first figure out how it works. i got
it to work, but i'm not 100% sure about i'm using it the way i'm
supposed to.

here is what i do:

1) git remote add B /path/to/B.git
2) git fetch
3) mkdir B
4) touch B/.gitignore
5) git add B/.gitignore
6) git commit -m "add empty B directory"
7) git merge -s subtree B/master

and yes, it works pretty well, but is this the right way? or is it
possible to somehow avoid steps 3..6?

thanks,
- VMiklos

--Q/AGl/UrDvkbRExF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHgAv0e81tAgORUJYRAgIVAJ9n43Fa8wpMIudUgGsEtZ8fWY13oACePYhE
cntJAuLebbrpRFuwrjd3NsM=
=zmCx
-----END PGP SIGNATURE-----

--Q/AGl/UrDvkbRExF--
