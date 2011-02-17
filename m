From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: use case: keep the output of a markup (TeX) file under revision
 control
Date: Thu, 17 Feb 2011 11:37:00 +0100
Message-ID: <1297939020.3959.12.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-v73ozNXEDLakaCITIgYo"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 12:48:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2LL-00039e-NZ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 12:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab1BQLsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 06:48:15 -0500
Received: from mail.gw90.de ([188.40.100.199]:37424 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab1BQLsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 06:48:14 -0500
X-Greylist: delayed 4267 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Feb 2011 06:48:14 EST
Received: from f053032084.adsl.alicedsl.de ([78.53.32.84] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1Pq1EM-000753-Kv
	for git@vger.kernel.org; Thu, 17 Feb 2011 10:37:02 +0000
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167066>


--=-v73ozNXEDLakaCITIgYo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git folks,


(Please CC me when replying since I am not subscribed.)

I have the following use case and need an advise from you professionals.

A friend and I are writing a paper using TeX=C2=B9 and keep the files under
revision control using Git. This works fine so far. But I want to also
have the output (PDF) of the markup file under revision control to be
able to access the PDF files even if for example no TeX installation is
available on a system.

The problem now is, since the output is no plain text file, that
merging/rebasing always shows conflicts which Git, of course, cannot
solve.

Is there a way to set that up so that there are no conflicts? Would a
pre-commit hook work which generates the PDF file prior to committing?
And if no TeX installation is available it would just ignore the PDF
files?

I could not find anything on the Web because having PDF as search string
would just show up how to generate documentation about Git.


Thanks,

Paul


=C2=B9 Actually it is ConTeXt [1].

[1] http://wiki.contextgarden.net/Main_Page

--=-v73ozNXEDLakaCITIgYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1c+kwACgkQPX1aK2wOHVg66QCdGi96bPCZSXrR3P94i6ac9e9T
LzAAn2HeyjGWpFxK983hCy5VxW0vyHFe
=GE1H
-----END PGP SIGNATURE-----

--=-v73ozNXEDLakaCITIgYo--
