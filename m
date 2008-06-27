From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: 'next' will be rewound shortly
Date: Fri, 27 Jun 2008 19:19:48 +0200
Message-ID: <20080627171948.GC6201@leksak.fem-net>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org> <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org> <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org> <20080627161220.GB6201@leksak.fem-net> <20080627163411.GA2058@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:20:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHcw-0001Xj-AD
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbYF0RTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbYF0RTx
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:19:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:56117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754528AbYF0RTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:19:52 -0400
Received: (qmail invoked by alias); 27 Jun 2008 17:19:50 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp035) with SMTP; 27 Jun 2008 19:19:50 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19G9h0PDUtGUqeAAx5QIO8lVorhGsUZGkgKfeeomu
	uZ+199eig4i2Sy
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KCHbw-0006wi-PO; Fri, 27 Jun 2008 19:19:48 +0200
Content-Disposition: inline
In-Reply-To: <20080627163411.GA2058@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86605>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just looked how you solved that and wanted to start a discussion but
you've swooped in first, find. ;-)

> I think it its current form that is not a bugfix. The user may want to
> prepend a custom message and may want to replace the original message
> with a custom one, and I would not consider either of them as "buggy".

Well, when I do -m <msg>, I expect that my commit message is exactly
<msg>, and not <msg> with appended stuff.
Of course, it doesn't matter what I expect, but I think what the
documentation says matters.
This is (in "master" and in "builtin-merge" of vmiklos.git):

-m <msg>::
	The commit message to be used for the merge commit (in case
	it is created). The `git-fmt-merge-msg` script can be used
	to give a good default for automated `git-merge` invocations.

So it is not mentioned that a standard message is appended, and thus the
original behavior is somehow "buggy" :)

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIZSE0bt3SB/zFBA8RApVhAJ9WDnH3WeWe02Rqw5Bt5APbTXYWJwCg1Lq1
lyERs20FayLoiUIsr3Q5CaY=
=VbsD
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
