From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Tue, 20 Feb 2007 01:36:40 +0100
Message-ID: <45DA4298.7010002@fs.ei.tum.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>	<20070217232603.GB30839@coredump.intra.peff.net>	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>	<20070217233203.GA6014@coredump.intra.peff.net>	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org> <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7D3ED837B8E80E5AAB889052"
Cc: Linus Torvalds <torvalds@linux-foundation.org>, peff@peff.net,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:36:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJ02-0002Oi-S5
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965750AbXBTAgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965751AbXBTAgu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:36:50 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:59578 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965750AbXBTAgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:36:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 30FF8280DD;
	Tue, 20 Feb 2007 01:36:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pA02vAOF9c9c; Tue, 20 Feb 2007 01:36:44 +0100 (CET)
Received: from [62.216.203.216] (ppp-62-216-203-216.dynamic.mnet-online.de [62.216.203.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 707CB280D8;
	Tue, 20 Feb 2007 01:36:43 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40178>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D3ED837B8E80E5AAB889052
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> If the patch were what you made by running "GNU diff" inside a
> corresponding subdirectory of another repository (perhaps you
> wanted to feed uncommitted changes from there to this
> repository), then you can always use "GNU patch" to apply.  If
> you made such a one-shot patch using git-diff, it will tell you
> the correct directory to apply to, so...

The difference there is that GNU/Larry Wall diff does not prepend a/ and =
b/ to the paths.  Maybe use this as an indicator for "this patch is relat=
ive to project root" vs. "this patch doesn't know where it wants to be ap=
plied".

A parameter --subdir, or even plain -pN could mean "apply this patch here=
, now."

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig7D3ED837B8E80E5AAB889052
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2kKar5S+dk6z85oRAv2DAKCY5g/2NA7RGss1MfFQVfWMwxgT8ACg88uP
Ot28Hbj49M14tqw9dj7EIXE=
=y+Gr
-----END PGP SIGNATURE-----

--------------enig7D3ED837B8E80E5AAB889052--
