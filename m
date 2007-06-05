From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: "stgit rebase" should check for errors before changing tree
Date: Tue, 5 Jun 2007 20:59:40 +0400
Message-ID: <200706052059.51173.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6286371.LRisqbR7CG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 05 19:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvcOS-0007m3-Hg
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 19:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbXFERAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 13:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbXFERAT
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 13:00:19 -0400
Received: from mx28.mail.ru ([194.67.23.67]:17475 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbXFERAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 13:00:16 -0400
Received: from mx27.mail.ru (mx27.mail.ru [194.67.23.64])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id BFF6CAE368
	for <git@vger.kernel.org>; Tue,  5 Jun 2007 21:00:14 +0400 (MSD)
Received: from [91.76.107.130] (port=30754 helo=cooker.local)
	by mx27.mail.ru with asmtp 
	id 1HvcNs-000Bno-00; Tue, 05 Jun 2007 20:59:52 +0400
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49208>

--nextPart6286371.LRisqbR7CG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

{pts/0}% stg rebase 2.6.22-rc4
Checking for changes in the working directory... done
Popping all applied patches... done
Rebasing to "2.6.22-rc4"...
stg rebase: Unknown revision: 2.6.22-rc4^{commit}

well, now user is forced to reapply (push) all patches by hand, "stg rebase=
"=20
lost history and state. It probably should check before popping patches.

stgit-0.12.1

=2Dandrey

--nextPart6286371.LRisqbR7CG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGZZZ9R6LMutpd94wRArqLAJ46WfiB8xYQKLo4UKpdwXs228urlACeO86u
jS53qjFPvaswhFePFq9qFP4=
=oRWn
-----END PGP SIGNATURE-----

--nextPart6286371.LRisqbR7CG--
