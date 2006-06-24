From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Subject: Re: [Patch] trap: exit: invalid signal specification
Date: Sat, 24 Jun 2006 15:54:55 +0300
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
Message-ID: <200606241555.03147.caglar@pardus.org.tr>
References: <200606240410.18334.caglar@pardus.org.tr> <7vejxf5ktc.fsf@assigned-by-dhcp.cox.net>
Reply-To: caglar@pardus.org.tr
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10468769.bAHluHYy1n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 14:55:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu7fO-0005XQ-BG
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 14:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWFXMzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 08:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWFXMzK
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 08:55:10 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:26510 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750731AbWFXMzI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 08:55:08 -0400
Received: from zangetsu.local (unknown [85.101.118.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 0899B17A5A4;
	Sat, 24 Jun 2006 15:55:04 +0300 (EEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vejxf5ktc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22513>

--nextPart10468769.bAHluHYy1n
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Cumartesi 24 Haziran 2006 05:50 tarihinde, Junio C Hamano =C5=9Funlar=C4=B1=
 yazm=C4=B1=C5=9Ft=C4=B1:=20
> I am not quite sure what to make out this...  Do you mean your
> shell does not like the command "exit" spelled in lowercase
> under Turkic locale?

Sorry to not clear enough previously, for Turkic locales (tr_TR, az_AZ etc.=
)=20
upper(i) !=3D I. More detailed analysis can be found at=20
http://www.i18nguy.com/unicode/turkish-i18n.html, "Why Applications Fail Wi=
th=20
The Turkish Language" section. This is the main reason of this problem.=20

According to its man page signals defined with uppercase letters but also=20
different trap implementations may permit lowercase signal names as an=20
extension.=20

As an example bash (v. 3.1.17) permits lowercase signal names but it conver=
ts=20
this lowercase signal names into uppercase ones while interpreting the=20
script. But for our "Turkish has 4 letter "I"s" problem this convert to=20
uppercase one process fails but for bash invalid signal names not be=20
considered a syntax error and do not cause the shell to abort.=20

Yours
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart10468769.bAHluHYy1n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnTYny7E6i0LKo6YRAhclAKCqPg6XAPpw0r7uPT34Kr3Xqe6pNgCgyKCP
d+m1r0FjcW5oswYIoesMj6I=
=RccQ
-----END PGP SIGNATURE-----

--nextPart10468769.bAHluHYy1n--
