From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 05:02:34 +0100
Message-ID: <45B1945A.1000400@fs.ei.tum.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45AF5F83.6090207@fs.ei.tum.de>	<Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<7vps9ag58g.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>	<7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfya69xym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE42851C50FF3AC17605CB77B"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 05:02:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H87RE-0005of-KM
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 05:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbXATECl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 23:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbXATECl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 23:02:41 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:33206 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965130AbXATECl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 23:02:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id ADA78280FB;
	Sat, 20 Jan 2007 05:02:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id exHcpaQAdtRB; Sat, 20 Jan 2007 05:02:39 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-212-125.dynamic.mnet-online.de [62.216.212.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 1EB22280BD;
	Sat, 20 Jan 2007 05:02:39 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfya69xym.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37257>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE42851C50FF3AC17605CB77B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> I think there are two very valid ways.  You determine what you
> would spit out as if there is no --reverse, and then reverse the
> result, or you do not limit with them to get everthing, reverse
> the result and do the counting limit on that reversed list.

We were originally coming from replacing a perl -e 'print reverse <>' in =
git-rebase.  So I'd say the former. =20

> If you do the latter, you would be able to get the first four
> commits in the chronological order.  I do not think that is
> usually of much practical value (although people new to git
> always seem to ask "how do I get to the root commit" at least
> once), but there may be some valid uses for that kind of
> behaviour.

But I doubt that "--reverse" would suggest that.

   Commit Ordering
       By default, the commits are shown in reverse chronological order.

so --reverse would mean no-reverse, i.e. forward.  well, acceptable :)  S=
o if --reverse is an option to influence the output after the commit orde=
ring, it is clearly the former.

I don't think the latter makes much sense, anyways.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigE42851C50FF3AC17605CB77B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsZRdr5S+dk6z85oRAnkdAJ96sKf+WY+OK8TqbxnjCBQ/E1XDqwCeN7tn
6HlFiY+m65Oedx2pq6HkZU4=
=X3GK
-----END PGP SIGNATURE-----

--------------enigE42851C50FF3AC17605CB77B--
