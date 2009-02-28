From: Todd Zullinger <tmz@pobox.com>
Subject: Re: How can I force git to recognize a change change in file modes?
Date: Sat, 28 Feb 2009 13:34:27 -0500
Message-ID: <20090228183427.GN4505@inocybe.teonanacatl.org>
References: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
 <20090228045531.14399ebf@perceptron>
 <e38bce640902280824x3ae41d95qab1f1a450235e096@mail.gmail.com>
 <76718490902280852y2f2657ck7459c138205bb874@mail.gmail.com>
 <e38bce640902280934u3d9da650ke64865d7149b3c66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="f8uTbadvzI+nQOZu"
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 19:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdU2g-0001v0-Sb
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 19:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbZB1Sei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 13:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbZB1Sei
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 13:34:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZB1Sei (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 13:34:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 61C699E23C;
	Sat, 28 Feb 2009 13:34:33 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [71.173.205.56]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5B9159E23B; Sat,
 28 Feb 2009 13:34:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <e38bce640902280934u3d9da650ke64865d7149b3c66@mail.gmail.com>
X-Listening-To: Stevie Ray Vaughan and Double Trouble - Voodoo Chile (Slight
 Return)
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 7182FF74-05C6-11DE-9E87-CFA5EBB1AA3C-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111784>


--f8uTbadvzI+nQOZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Brent Goodrick wrote:
> All I want to do in my case is just chmod 700 a bunch of scripts
> after they are checked out or updated.  I'll need to re-read the
> git-hooks man page more closely.

You may want to check contrib/hooks/setgitperms.perl as well, if you
haven't seen it already.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Problems are opportunity in work clothes.


--f8uTbadvzI+nQOZu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJJqYOzJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj6cAIAKWhqoN0ch8gQwOYalNa3sOWm8533Oyt1Iv6
pFiL3jfZw+XabEhbl761j7urmVU45OlpW9Z8X51AtANSZajQICCniilDtFMOYtsr
JsCbGnsGwc11uqHfA311sePV7Yt4/B+jBJe5Sx7E7ktD96vjCEn3ck1NGynwoUFE
i01ElTGqZBSbups3+AQaghhSfyz95Ge/RRX1hyRXEdCqkvy+YRvinYQKw3Rugkco
5ZjvdC56hQzB9WixcDrfutvKMhv/l4DWaMIQOl9ZRFy0gcgOThuxcAtGhEZSIxAR
nFWH76BKlyfyungCXjKTNdWBUKar6u9lUGsOc70L0p5esSV+ng0=
=F9qH
-----END PGP SIGNATURE-----

--f8uTbadvzI+nQOZu--
