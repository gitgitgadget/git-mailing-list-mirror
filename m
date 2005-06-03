From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 03 Jun 2005 16:56:11 -0400
Message-ID: <1117832172.8970.22.camel@jmcmullan.timesys>
References: <20050603152212.GA4598@jmcmullan.timesys> <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <1117814982.32257.64.camel@jmcmullan.timesys> <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org> <1117819137.32257.75.camel@jmcmullan.timesys> <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org> <1117827011.8970.2.camel@jmcmullan.timesys> <Pine.LNX.4.58.0506031320190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-RmU4pHHXt4oRmHJ2Vb3j";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 22:54:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeJAI-00083h-KF
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 22:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFCU4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 16:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFCU4V
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 16:56:21 -0400
Received: from mail.timesys.com ([65.117.135.102]:18323 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261362AbVFCU4N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 16:56:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 03 Jun 2005 16:56:12 -0400
In-Reply-To: <Pine.LNX.4.58.0506031320190.1876@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Fri, 3 Jun 2005 16:49:20 -0400
Message-ID: <1117832172.8970.22.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-daemon server
thread-index: AcVofbcq2CbRq5nfTR2aAbhLQdhHJw==
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-RmU4pHHXt4oRmHJ2Vb3j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Linus, you were wondering why stdin/stdout was the default, even though
I don't have a use case for ssh with stdin/stdout:

1) I used the stdin/stdout stuff as debugging

2) It works with xinetd

3) Because I can't figure out how to get /bin/sh to give me two pipes
   that hook together two processes. What I really want:

ssh user@remote git server --db /my/git.git <|> git server request HEAD

Where 'xxx <|>  yyy' means:

	Take process xxx's stdin, hook it to yyy's stdout,
	Take process yyy's stdin, hook it to xxx's stdout,
	Run till they both die.

If you know how to do that, I'd be grateful.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-RmU4pHHXt4oRmHJ2Vb3j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCoMPr8/0vJ5szK6kRAgOEAKCsPttBfIEtCJYZ3FKQx04/YHYDGQCfQqHK
SgY/06f35FCj6fIUfnJuRoU=
=WU6P
-----END PGP SIGNATURE-----

--=-RmU4pHHXt4oRmHJ2Vb3j--
