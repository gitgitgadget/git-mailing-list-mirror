From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: testsuite problems
Date: Tue, 18 Sep 2007 00:04:08 +0200
Message-ID: <20070917220408.GG19019@genesis.frugalware.org>
References: <20070917211742.GF19019@genesis.frugalware.org> <46EEF6A8.1030308@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXOjR-0003e6-7D
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbXIQWEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 18:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXIQWEQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:04:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:44942 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbXIQWEP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:04:15 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IXOhS-00079U-6a
	from <vmiklos@frugalware.org>; Tue, 18 Sep 2007 00:04:14 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DC6371678012; Tue, 18 Sep 2007 00:04:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46EEF6A8.1030308@lsrfire.ath.cx>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=BAYES_00,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58485>


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2007 at 11:50:32PM +0200, Ren=E9 Scharfe <rene.scharfe@lsrf=
ire.ath.cx> wrote:
> The failing tests check ZIP file creation, not tar file creation.
> Perhaps your unzip command works a bit differently from Info-ZIP's?

$ zip -v
Copyright (c) 1990-2006 Info-ZIP - Type 'zip "-L"' for software license.
This is Zip 2.32 (June 19th 2006), by Info-ZIP.

should this version be ok?

> Also, what is the difference between t/trash/a and t/trash/d/a after
> running the test script (that's what test 21 is comparing)?

$ diff -Naur t/trash/a t/trash/d/a
diff -Naur t/trash/a/l1 t/trash/d/a/l1
--- t/trash/a/l1        2007-09-17 23:10:03.000000000 +0200
+++ t/trash/d/a/l1      2007-09-17 23:10:03.000000000 +0200
@@ -1 +1 @@
-simple textfile
+a
\ No newline at end of file

thanks,
- VMiklos

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG7vnYe81tAgORUJYRAuQlAKCjMYHKp2XJcKjSGvyXDKW6/OUkxwCgpsfE
pksfP/7WNRiehpUHo7/kep0=
=FjoW
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
