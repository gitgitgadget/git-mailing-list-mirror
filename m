From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] git blame --progress
Date: Mon, 29 Jan 2007 08:00:28 +0100
Message-ID: <45BD9B8C.70003@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>	<20070127080126.GC9966@spearce.org>	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>	<45BCB273.7010601@lsrfire.ath.cx>	<7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>	<7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>	<45BD40AE.9020603@lsrfire.ath.cx> <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF7FE0AD4F0664045015CC51C"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 08:00:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBQVS-0005yJ-1X
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 08:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933248AbXA2HAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 02:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933249AbXA2HAk
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 02:00:40 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:58207 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933248AbXA2HAj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 02:00:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id BA7DC28168;
	Mon, 29 Jan 2007 08:00:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LQgwkL-RqcvK; Mon, 29 Jan 2007 08:00:37 +0100 (CET)
Received: from [62.216.203.91] (ppp-62-216-203-91.dynamic.mnet-online.de [62.216.203.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 5BB46280F6;
	Mon, 29 Jan 2007 08:00:37 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38066>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7FE0AD4F0664045015CC51C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> +	fprintf(stderr, "\033[2JAssigning blame for %s\n", sb->path);

are you sure that you want to hard code the escape sequence?  I guess the=
 correct way would be to query terminfo.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigF7FE0AD4F0664045015CC51C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFvZuPr5S+dk6z85oRAojcAKC3MgDRvZuyMSSDzzt4Zamd1FUk8gCgp7jv
BwfVbX3lkHuFhwh6mPBN7ds=
=9q/x
-----END PGP SIGNATURE-----

--------------enigF7FE0AD4F0664045015CC51C--
