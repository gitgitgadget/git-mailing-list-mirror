From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: git log: Add a switch to limit the number of displayed lines from
 the commit messages
Date: Sat, 15 Jun 2013 20:07:03 +0200
Message-ID: <1371319623.9845.34.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-sKbfdv4CHTyywNrg7+h6"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 15 20:07:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unusk-0005Cj-RL
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab3FOSHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 14:07:17 -0400
Received: from mail.gw90.de ([188.40.100.199]:41608 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381Ab3FOSHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 14:07:16 -0400
Received: from e178084155.adsl.alicedsl.de ([85.178.84.155] helo=[192.168.2.49])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1Unusb-0005UV-7u
	for git@vger.kernel.org; Sat, 15 Jun 2013 18:07:13 +0000
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227966>


--=-sKbfdv4CHTyywNrg7+h6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear git folks,


there are people out there disliking elaborate commit messages, as going
over `git log` is tedious as you have to scroll a lot. As I do not like
the suggestion to make commit messages shorter by omitting certain
details, a way to limit the number displayed lines of the commit
messages would be nice to have.

The switch `--format=3Doneline` exists already. Unfortunately a lot of
commits do not have a informative enough summary, so the first lines of
the commit message are still needed/desired to understand the commit
more.

Could a switch be added, like `--commit-message-lines` (sorry for not
coming up with something better) to limit the number of displayed lines?
That would be great!

For older git versions, do you know of editor/pager options to achieve
this?


Thanks,

Paul

--=-sKbfdv4CHTyywNrg7+h6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlG8rUcACgkQPX1aK2wOHVjfhQCeLzpkCZ0uxTIyHmOBMPcDiEGK
q2AAn3WKLFk4h6JMeg6naAC5zEhz2sRZ
=BV+v
-----END PGP SIGNATURE-----

--=-sKbfdv4CHTyywNrg7+h6--
