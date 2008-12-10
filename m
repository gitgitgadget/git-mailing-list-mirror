From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Recovering from epic fail (deleted .git/objects/pack)
Date: Tue, 09 Dec 2008 16:11:01 -0800
Organization: Slide, Inc.
Message-ID: <1228867861.14165.19.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3yvy1L8wC55O9I07FbjM"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 01:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LACgk-0005C7-Ho
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 01:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbYLJALI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 19:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYLJALI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 19:11:08 -0500
Received: from mx0.slide.com ([208.76.68.7]:46220 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbYLJALH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 19:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=s
	e6mZI8IhBhDvU7jV7plc8ksViXfu5iGpS0dufH23ZQ=; b=CD7y+nG5lNyergIGG
	xIO521NInMK4qXJRB8yYKx7VB1RTruma84yhV3mPyw9F1llLQnqkuiNJBZFiKmCA
	BgmK48gt/jj1+IKlAmlXE33xQ2rlHazQiGNdms70EwUMc1GxSVuXxi+c6RXhLMXN
	YGoCSwUuI6wJ/ZNOl5XjW6KI8g=
Received: from nat3.slide.com ([208.76.69.126]:52199 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LACfP-00047n-9L
	for <git@vger.kernel.org>; Tue, 09 Dec 2008 16:11:03 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 42947A6F0002
	for <git@vger.kernel.org>; Tue,  9 Dec 2008 16:11:03 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.689
X-Spam-Level: 
X-Spam-Status: No, score=-3.689 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.710, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVhj-lRfsnhO for <git@vger.kernel.org>;
	Tue,  9 Dec 2008 16:11:02 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id D93CAA6F0001
	for <git@vger.kernel.org>; Tue,  9 Dec 2008 16:11:02 -0800 (PST)
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102662>


--=-3yvy1L8wC55O9I07FbjM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I really wish I didn't have to ask this question, as we discussed in
#git early this morning, whiskey is the likely answer.

For unexplainable reasons one of our sysadmins got trigger-happy when he
tried to prune a temp_pack file generated and left in a
developer's .git/ directory after a git operation aborted (disk quota
exceeded)

As a result, the sysadmin killed the developers
entire .git/objects/pack/ directory. (insert copious amounts of whiskey
here)

He did not however delete all the other contents of .git/objects (00/,
01/, etc)

Is there a feasible way that I can properly recover
the .git/objects/pack directory such that the developer who had their
last two weeks of local work thrashed can get it back?


Anything that can help (other than pummeling the sysadmin) would be
appreciated

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-3yvy1L8wC55O9I07FbjM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk/CRUACgkQFCbH3D9R4W9iewCgnTfXSiSLnmmlD+wRdwYnzJKo
FSsAn2+pn5eWb3cuPoXlOCi0ItJKRajs
=Q/Hx
-----END PGP SIGNATURE-----

--=-3yvy1L8wC55O9I07FbjM--
