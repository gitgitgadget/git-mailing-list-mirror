From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Removing options from build
Date: Tue, 13 Jan 2009 13:43:22 -0800
Organization: Slide, Inc.
Message-ID: <1231883002.14181.27.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Bp2w7WSa6pskTeDJ83E/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 22:44:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMr47-0000tv-IY
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbZAMVn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbZAMVn0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:43:26 -0500
Received: from mx0.slide.com ([208.76.68.7]:39848 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbZAMVnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=n
	1cvEDB/HdzwsO9fsD9corFYbxZCNmftSs044Do76P8=; b=EQl3/nU9VsDh8pGTq
	JkXPIRj1vzqB9QehwYgsVt5BtnHtPFKTSKsZ4h7klMTru/i1I0TCKCUYfrr5d0au
	tEaeNrGwBt/JS+25jQ3FZzAuNvb1L7joueRTpFVvoTaYvcCcwBY5LYWwO1UjZDvh
	2yNAqxC8RXWixubvCcPjOae4EQ=
Received: from nat3.slide.com ([208.76.69.126]:39682 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LMr2j-00027A-Bd
	for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:43:25 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 515AB3899159
	for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:43:25 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.891
X-Spam-Level: 
X-Spam-Status: No, score=-3.891 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.508, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0UZGtmr0pLyB for <git@vger.kernel.org>;
	Tue, 13 Jan 2009 13:43:25 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 292DD38990F9
	for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:43:25 -0800 (PST)
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105541>


--=-Bp2w7WSa6pskTeDJ83E/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

One of our developers "discovered" the --force option on `git push` and
used it without taking the appropriate care and hosed one of the project
branches we have running around in our central repository.

Besides a vigorous flogging, we're looking at other ways to prevent this
sort of thing from happening again; the option we've settled on is to
remove the "--force" flag from our internal build of v1.6.1

I'm wondering if somebody could point me in the right direction to
remove "--force" (safely) from the builtin-push.c and removing the
"rebase" command (we've got no use for it, and would prefer it gone).

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-Bp2w7WSa6pskTeDJ83E/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltCvoACgkQFCbH3D9R4W+eGwCfaY+/3lkSXf+5kunFYjRlasyM
2OcAn1CUZ5vNUnFAt7Mn0/JdQoXh5WcV
=xEV8
-----END PGP SIGNATURE-----

--=-Bp2w7WSa6pskTeDJ83E/--
