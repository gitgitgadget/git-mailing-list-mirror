From: Rene Moser <mail@renemoser.net>
Subject: Bug: file named - on git commit
Date: Mon, 28 Jan 2013 11:38:56 +0100
Message-ID: <51065540.1090007@renemoser.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WOOTPKUUFCHGAQJOHWAG"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 11:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzmDY-0003SA-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 11:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab3A1KpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 05:45:15 -0500
Received: from renemoser.net ([88.198.132.86]:41048 "EHLO mx1.resmo.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174Ab3A1KpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 05:45:13 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2013 05:45:13 EST
Received: from [192.168.123.40] (adsl-89-217-73-126.adslplus.ch [89.217.73.126])
	by mx1.resmo.ch (Postfix) with ESMTPSA id B4A2C2D6804E
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 11:39:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214828>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WOOTPKUUFCHGAQJOHWAG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

Found a little issue in git version 1.7.9.5 if a file named "-", causing
"git commit" to read from stdin.

(So you must hit ctrl-d or ctrl-c to finish the commit.)

Everything looks ok to me after the commit. Other users reported to be
fixed in 1.8.1.1 but haven't it tested myself.

This does not work:

mkdir tmp && cd tmp;
echo foo >./-;
git init; git add .;
git commit -m "is this a bug?"

Kind regards

Ren=E9







------enig2WOOTPKUUFCHGAQJOHWAG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEGVUAACgkQHXu/ROUxaMd1cQCeLrRpD04CP7J66Eg8rWhjmWNd
ag8AnRH3ZnvW2BggP4TB6JjSTLMmJsgL
=SZHt
-----END PGP SIGNATURE-----

------enig2WOOTPKUUFCHGAQJOHWAG--
