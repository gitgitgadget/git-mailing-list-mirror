From: Nick Douma <n.douma@nekoconeko.nl>
Subject: Re: Don't share anything but those files
Date: Tue, 17 Jul 2012 10:37:28 +0200
Message-ID: <50052448.5060407@nekoconeko.nl>
References: <5000334C.5030505@modusfx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0FA19FDD6F8710C1F024ED4A"
Cc: git@vger.kernel.org
To: Yves Perron <yves.perron@modusfx.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 10:37:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr3Hs-0002R4-IC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 10:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab2GQIhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 04:37:39 -0400
Received: from genome.nekoconeko.nl ([93.94.224.72]:46428 "EHLO
	genome.nekoconeko.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab2GQIhh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 04:37:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by genome.nekoconeko.nl (Postfix) with ESMTP id EBCF81FCAF;
	Tue, 17 Jul 2012 10:40:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at genome.nekoconeko.nl
Received: from genome.nekoconeko.nl ([127.0.0.1])
	by localhost (genome.nekoconeko.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hvgip8F3AtYD; Tue, 17 Jul 2012 10:40:24 +0200 (CEST)
Received: from [IPv6:2001:838:300:41e::2] (cl-1055.ams-01.nl.sixxs.net [IPv6:2001:838:300:41e::2])
	by genome.nekoconeko.nl (Postfix) with ESMTPSA id BB9041FC74;
	Tue, 17 Jul 2012 10:40:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nekoconeko.nl;
	s=genome; t=1342514424;
	bh=GobZ3Ggfg5soO2zy/q/yzWub7Xvz1oRH+5Y3wKctbL4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Ycs5NnxjtyXUMi78iErmxvy11yGN1TM7JR3Q5ciYZLFcl/4OS7nAfLJGUcxpw9rD0
	 YOKKy6hvbHRQHP3qYC4r67TwtsRysJtu8YP2kGuIE9IKnpNfbvoNbtn1LanAjYsJVg
	 gxfybvo97Wu8v69yehwuPDJi9rqRCgDY5AEU+hQQ=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <5000334C.5030505@modusfx.com>
X-Enigmail-Version: 1.4.2
OpenPGP: id=AB001628;
	url=http://nekoconeko.nl/pub_0xAB001628.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201594>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FA19FDD6F8710C1F024ED4A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hoi,

On 13-07-12 16:40, Yves Perron wrote:
> I'm wondering how to commit only selected files/folders on GIT, if even=

> possible. Note, the ignore list is not a good option for me as I'd like=

> to add a few files in a folder that contains many hundreds for instance=
=2E
>=20
> Basically, I'm looking for a way to say, don't share anything but those=

> files.

I would use a .gitignore with something like:

cat <<EOF > .gitignore
# Ignore everything
*
# Except
!/.gitignore
!/path/to/file/1
!/path/to/file/2
EOF

Only the two specified files and the .gitignore file should be shown in
`git status` now.

Kind regards,

Nick Douma


--------------enig0FA19FDD6F8710C1F024ED4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAFJEwACgkQkPq5zKsAFigV2ACfXb93BUNcMOOapr86qCEYrdAv
Cv0An00lUwsKLDQF5vUtd52RZHVHN0VU
=tGGE
-----END PGP SIGNATURE-----

--------------enig0FA19FDD6F8710C1F024ED4A--
