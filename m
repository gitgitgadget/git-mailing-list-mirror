From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Which msysGit version corresponds to which official Git version?
Date: Sun, 25 May 2008 11:46:25 -0400
Message-ID: <20080525154625.GV3216@inocybe.teonanacatl.org>
References: <48380E05.9020103@dirk.my1.cc>
 <3F512BCF-1D2E-46B0-84E5-4807753A2618@zib.de> <4839839C.2040605@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HKOZ/JADkehwFk9I"
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun May 25 17:47:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0IRS-0000Ve-6r
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 17:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbYEYPqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 11:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbYEYPqf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 11:46:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbYEYPqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 11:46:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C2C9160C;
	Sun, 25 May 2008 11:46:32 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-68-39-203-93.hsd1.pa.comcast.net
 [68.39.203.93]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix)
 with ESMTP id F10E11608; Sun, 25 May 2008 11:46:27 -0400 (EDT)
Mail-Followup-To: Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
 Steffen Prohaska <prohaska@zib.de>, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4839839C.2040605@dirk.my1.cc>
X-Listening-To: Nothing
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: BF95F06C-2A71-11DD-A5D1-80001473D85F-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82865>


--HKOZ/JADkehwFk9I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dirk S=FCsserott wrote:
> So what's the difference then between 9d8318051 and 1d2375d?
> gitk doesn't know about 9d8318051 at all. Seems that there are
> two ways to get to v1.5.5: via 9d... and via 1d.... Is that right
> or did I misunderstand sth. here?

9d8318051 is a tag object that creates the v1.5.5 tag:

$ git cat-file -p 9d8318051
object 1d2375ddfee18bd3effd2c1f98527cc2f8b1df0a
type commit
tag v1.5.5
tagger Junio C Hamano <gitster@pobox.com> Mon Apr 7 21:57:56 2008 -0700

GIT 1.5.5
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH+vtXwMbZpPMRm5oRAlfBAJwPP5W9HvoAHzmD1AoWpRtcyQ/uoACfVkCc
M7H1LhvSXz+h2+08bieh3uU=3D
=3DuTP0
-----END PGP SIGNATURE-----

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Until you have the courage to lose sight of the shore, you will not
know the terror of being forever lost at sea.
    -- Demotivators (www.despair.com)


--HKOZ/JADkehwFk9I
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJIOYnEJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj8xUH/ic973neFtWyeC5WVRGc3fF5w9lKqIE/TXZL
HxoeLUp+e9bgrxI9QJCjElR08m4mPzO+wDTqnzeI91NCwA0QAoz2N8XV0ZS5RYNm
kpwX4lC8UxiU03dTab3B0iK7H5muuwhNuko6L1I/jFrL2vk6KKpF+TYiZL1L6yRM
cX7OcSDL2y/A9jBOF8tTxakTsUFMP6XoiYEKZZg21gCYuSQHssnTSf+8+OlDkCFj
e5YjkP+epDtHPwh93BLokehoUJPVOie15Na5swopSoxxGpsZzB8HmiE2t40eoUxB
5CQWvwfhNyUPagPlDNuFCo0epBWWf3uUxSch/hgq7Aqo9/V1k+Y=
=w0x9
-----END PGP SIGNATURE-----

--HKOZ/JADkehwFk9I--
