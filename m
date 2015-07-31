From: Hugo Connery <hmco@env.dtu.dk>
Subject: Documentation bug in ProGit v2
Date: Fri, 31 Jul 2015 12:13:38 +0200
Message-ID: <55BB4A52.2060404@env.dtu.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SwoBWLAnG7DLCV4RujHaaIi9c2X8Jkiao"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 31 12:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL7Yl-0005W3-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 12:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbbGaK27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 06:28:59 -0400
Received: from spamfilter2.dtu.dk ([130.225.73.113]:54683 "EHLO
	spamfilter2.dtu.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbbGaK27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 06:28:59 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2015 06:28:58 EDT
Received: from ait-pexedg02.win.dtu.dk (ait-pexedg02.win.dtu.dk [192.38.82.192])
	by spamfilter2.dtu.dk  with ESMTP id t6VADkFW018735-t6VADkFZ018735
	(version=TLSv1.0 cipher=AES128-SHA bits=128 verify=CAFAIL)
	for <git@vger.kernel.org>; Fri, 31 Jul 2015 12:13:48 +0200
Received: from ait-pex02mbx06.win.dtu.dk (192.38.80.18) by
 ait-pexedg02.win.dtu.dk (192.38.82.192) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 31 Jul 2015 12:13:41 +0200
Received: from ait-pex01mbx01.win.dtu.dk (192.38.82.181) by
 ait-pex02mbx06.win.dtu.dk (192.38.80.18) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 31 Jul 2015 12:13:48 +0200
Received: from 055x.env.dtu.dk (130.225.73.250) by ait-pex01mbx01.win.dtu.dk
 (192.38.82.181) with Microsoft SMTP Server id 14.3.235.1; Fri, 31 Jul 2015
 12:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-Originating-IP: [130.225.73.250]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275043>

--SwoBWLAnG7DLCV4RujHaaIi9c2X8Jkiao
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

When discussing establishing git over Smart HTTP on pages 140 and 141:

[quote]
Finally you=E2=80=99ll want to make writes be authenticated somehow, poss=
ibly
with an Auth block like this:

<LocationMatch "^/git/.*/git-receive-pack$">
AuthType Basic
140GitWeb
AuthName "Git Access"
AuthUserFile /opt/git/.htpasswd
Require valid-user
</LocationMatch>

That will require you to create a .htaccess file containing the
passwords of all the valid users. Here is an example of adding a
=E2=80=9Cschacon=E2=80=9D user to the file:

$ htdigest -c /opt/git/.htpasswd "Git Access" schacon
[end quote]

This will 401 every time.  You either do:

AuthType Digest and use htdigest, or you do
AuthType Basic and use htpasswd

Apache recommend Basic + SSL rather than Digest.

Thanks for the book.

Regards,  Hugo Connery
--
Head of IT, Department of Environmental Engineering
Technical University of Denmark,


--SwoBWLAnG7DLCV4RujHaaIi9c2X8Jkiao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVu0pSAAoJEDAMZjyc1DBcmIMP/0WOxztfy4dsc8THs2y8PhZS
SN+1z1QCws04TBjxFcy8dWO5IEwitOfxIGtpYv1YPdN4Jj+/46q/TtVq05RwH63i
6JYS06cv/oezF7POLEMzPq/cA2onso9/QAiumfgnH5NYCJ+RUHf8K++OM/Trnad+
eBZfU/B61/7HEhMxjZsEJYvRxKjOuijsENPMDW9JuH249BlaIeCIIIwG5vcqHGKP
k2XbsdA/a+j6+R1qY5on5TX6s/bCOrTVkza/pFv+yW6kU3Zkz1orxLBOwaIHCM6O
K6rvVnS0O+lupPgv9nykrNHVfCa+shBDRNNKshVH19NGeos98QET4bant51XDsjg
lX5R5LYT2Up8Rurb8rc4JtLGxlTky8pJnKAJgaZltRj71A9fZKCeoQeHlVCiJzSk
laCtQ0y+7cKXtM7fJGsBpg4B5x3Fm1ZgYJLQeY9isN85uhLgCXxbgcdvqs208dz6
K1TxzuNV9LtU+QpsQS9EtFHo1pkmn/hq6XXrJeC7Jm9cubOsgaG/N9RI12RbklWr
degK2y/Gm/WXzK57vSDpQ1z1RMFhkdbMl1VNHKE7jFT4nHIQMLD6REAn1OJKy29P
peZZtpeWklBJJZmvBYk0Z2KbnhwW9QFI8snUuaMfi+f5suqz4VjLhpNb3URy7x6Y
H2Hd3k9W/x3chggnlW3a
=kCsF
-----END PGP SIGNATURE-----

--SwoBWLAnG7DLCV4RujHaaIi9c2X8Jkiao--
