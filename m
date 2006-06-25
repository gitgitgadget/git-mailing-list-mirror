From: "=?iso-8859-9?q?S=2E=C7a=F0lar?= Onur" <caglar@pardus.org.tr>
Subject: Re: [Patch] trap: exit: invalid signal specification
Date: Sun, 25 Jun 2006 17:33:12 +0300
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
Message-ID: <200606251733.16502.caglar@pardus.org.tr>
References: <200606240410.18334.caglar@pardus.org.tr> <200606241555.03147.caglar@pardus.org.tr> <f36b08ee0606241311h399c42b0h11638f14d6f54bd5@mail.gmail.com>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3612637.n0RnjuyrmT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 16:33:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuVg0-0001hQ-57
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 16:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWFYOdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 10:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWFYOdV
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 10:33:21 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:23708 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932419AbWFYOdV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 10:33:21 -0400
Received: from zangetsu.local (unknown [85.101.118.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 198EA20B1ED;
	Sun, 25 Jun 2006 17:33:16 +0300 (EEST)
To: "Yakov Lerner" <iler.ml@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <f36b08ee0606241311h399c42b0h11638f14d6f54bd5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22630>

--nextPart3612637.n0RnjuyrmT
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Cumartesi 24 Haziran 2006 23:11 tarihinde =FEunlar=FD yazm=FD=FEt=FDn=FDz:
> But in the commandline you are patching,  'exit' keyword
> is not bash signal name,=20

Pff, you are completely right. I'm currently using git-1.2.6 which has "exi=
t"=20
signal (git-clone.sh: trap 'err=3D$?; cd ..; rm -r "$D"; exit $err' exit )=
=20
causing that trouble but in git-1.4.0 its converted to 0 (git-clone.sh:=20
trap 'err=3D$?; cd ..; rm -r "$D"; exit $err' 0) and i didn't realize until=
=20
look again. Sorry for noise :(

=2D-=20
S.=C7a=F0lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart3612637.n0RnjuyrmT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnp6sy7E6i0LKo6YRAkiaAJ9mteRhXQ7AZRr/VV/9NvzZ/y5WXwCfVfUg
ue61KlqJoeP5swawjzldAjo=
=Nbiw
-----END PGP SIGNATURE-----

--nextPart3612637.n0RnjuyrmT--
