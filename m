From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: gitweb: charset problem
Date: Mon, 24 Oct 2005 09:18:39 +0200
Message-ID: <20051024071839.GB4608@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Cc: Christian Gierke <ch@gierke.de>,
	Peter Portmann <peter.portmann@sygroup.ch>
X-From: git-owner@vger.kernel.org Mon Oct 24 09:21:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETwcU-00052m-P6
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 09:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVJXHTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVJXHTn
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 03:19:43 -0400
Received: from wg.technophil.ch ([213.189.149.230]:60093 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751063AbVJXHTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 03:19:43 -0400
Received: (qmail 4748 invoked by uid 1000); 24 Oct 2005 07:18:39 -0000
To: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10533>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

gitweb (my $version =3D           "247";) seems to send utf-8 as meta tag e=
ncoding
(<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"/>=
).
The problem is that the name of the user "HansjOErg" (OE is the german umla=
ut)
is in iso8859-1 in /etc/passwd.
This is guessed, but it does not look like utf-8, as it's a one byte encodi=
ng:

00007b0: 3031 323a 3130 303a 4861 6e73 6af6 7267  012:100:Hansj.rg

What would be the correct way to fix that? Change the username to utf-8?
(Is this possible without causing problems in other programs?)
Or tell gitweb that it should convert non-UTF-8 to UTF-8?

But we also have another problem: Sometimes we have umlauts in the commit m=
essages.
Those are also displayed incorrectly. When I switch to iso-8859-1 encoding =
in mozilla,
the characters in the username and in the commit message are ok.

Greetings,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1yKzrOTBMvCUbrlAQLEcA/8CysMu2ehYtqNJ47fu34yKKsRNdKMytJ0
MxfMJyRAQ9F9v0mtQ2/ozVMSKxeGgUnsIQLhCCMzTE2V/qzLjnMShILnmr41tAYC
qpvgJliFmllrWcpxKMbVAOV960Z4X0qxTIx/dwYzxA/wdCJBAJvfbtdOEjrOvMPW
JWsr6NhIrdVDkq/hSbXfTsyc4BPqNOD8olXO8ynYxmd9dIap2oKBDX1s9F/w5oPx
DjW/4ZJI8SehxRexYBuqpRE2CBq4Sh9ljWruuzJe6oTNq+4wR1qy9rvL/XYl9y0Y
ZZ0gqwAGHtT7inb9dg934TBaFtIZjippj/OzhQzYWbiVPr4Ab6gKg1J2DcoPfeuU
M/WWENgJiVWhepYK5wqXYHaBFIgLtdT3zmJvK74MJnBN3EbzQRKDCyTm5NGJzE5B
7D2tj2Mn2PPyOTRYrlSJ013fzsF7m/q7WR3GKTUwpIBTZNcNFjpqFW4zd2i5NaYZ
9pM736Yoe3CcwYZ+R8X35k037p5wul5s6XMLA0Jrec7AZX6K3m80ftmaGVCEaE4v
r73Jls+4c3SwfSssRovIAw7AqOiyraqJw05MThTxgfqhSqlfznBn5EIGCJRUlO5F
r4aa9N3DMfdQBryMxxk+u9Febq4ZOzoDBM1pzGKeEU15bRCvruBDBMsgVWQKinpO
B9oMjcxujIw=
=fgrb
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
