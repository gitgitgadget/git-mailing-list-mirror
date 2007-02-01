From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Thu, 01 Feb 2007 22:29:10 +0100
Message-ID: <45C25BA6.1000301@fs.ei.tum.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>	<20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9EE0F4B491830119018266EB"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjUo-0000xB-4w
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423019AbXBAV3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423023AbXBAV3T
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:29:19 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:51963 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423019AbXBAV3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:29:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A9B0B2825C;
	Thu,  1 Feb 2007 22:29:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kobgMSdObXPL; Thu,  1 Feb 2007 22:29:15 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-10.dynamic.mnet-online.de [62.216.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 5F53C28240;
	Thu,  1 Feb 2007 22:29:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38408>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9EE0F4B491830119018266EB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Although from the consistency point of view, HEAD reflog to
> follow swicthing branches like Nico's patch aims for (but not
> implements fully yet) makes perfect sense, I still am somewhat
> doubtful about it being actually useful in practice.

I think that's quite useful.

>  Even if we
> assume it is useful, I think forbidding people from saying
> HEAD@{...} right now only because the new semantics is
> unimplemented yet feels wrong.  If you use only one branch,
> there is no difference between the reflog of master and HEAD
> today, without waiting for that "reflog on HEAD".

I don't know how people are used to type HEAD@{..}, but why not:

1.  have .@{..} or @@{..} for "the current branch i am on" and have HEAD@=
{..} behave like nicolas is aiming to do.

2. have HEAD@{..} to mean "the current branch i am on" and invent somethi=
ng else for "HEAD commit".  doesn't sound too logic, though.

ignore me if i'm sounding stupid :)

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig9EE0F4B491830119018266EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwlupr5S+dk6z85oRAi8MAKCqoGqg76COlLR20dz4b8BzdQZlhACcDlCp
18UGYzuH2MCB7/YeaMAUzvo=
=MU+h
-----END PGP SIGNATURE-----

--------------enig9EE0F4B491830119018266EB--
