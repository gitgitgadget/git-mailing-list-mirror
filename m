From: Henrik Austad <henrikau@orakel.ntnu.no>
Subject: About git and the use of SHA-1
Date: Mon, 28 Apr 2008 18:29:07 +0200
Message-ID: <200804281829.11866.henrikau@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3154668.1C5AGdQOao";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 19:15:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWwh-0002c0-4w
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 19:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933867AbYD1ROb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 13:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933776AbYD1ROa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 13:14:30 -0400
Received: from mail45.e.nsc.no ([193.213.115.45]:40255 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933408AbYD1ROa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 13:14:30 -0400
X-Greylist: delayed 2717 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Apr 2008 13:14:29 EDT
Received: from 062016203203.customer.alfanett.no (062016203203.customer.alfanett.no [62.16.203.203])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m3SGTB8T029197
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 18:29:11 +0200 (MEST)
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80566>

--nextPart3154668.1C5AGdQOao
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi list!

As far as I have gathered, the SHA-1-sum is used as a identifier for commit=
s,=20
and that is the primary reason for using sha1.  However, several places=20
(including the google tech-talk featuring Linus himself) states that the id=
's=20
are cryptographically secure.

As discussed in [1], SHA-1 is not as secure as it once was (and this was in=
=20
2005), and I'm wondering - are there any plans for migrating to another=20
hash-algorithm? I.e. SHA-2, whirlpool..

[1] http://www.schneier.com/blog/archives/2005/02/cryptanalysis_o.html
=2D-=20
mvh Henrik Austad

--nextPart3154668.1C5AGdQOao
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIFftX6k5VT6v45lkRAurWAKCi4O+BElEKlqwNWSVMRbNJh/+ELwCgsyso
e0hvspx2aJclg91CDw501LE=
=kwAC
-----END PGP SIGNATURE-----

--nextPart3154668.1C5AGdQOao--
