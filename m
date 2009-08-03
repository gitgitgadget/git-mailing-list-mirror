From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Mon, 3 Aug 2009 15:56:31 -0600
Organization: icecavern.net
Message-ID: <200908031556.35634.wjl@icecavern.net>
References: <4A7735B0.2040703@zytor.com> <7vocqw8u0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart56801711.K56hDTdAY4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5WS-0001Vf-Cr
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 23:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbZHCV4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 17:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbZHCV4k
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 17:56:40 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:56688 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751194AbZHCV4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 17:56:40 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 299F635B4F;
	Mon,  3 Aug 2009 23:56:38 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.29-2-amd64; KDE/4.2.2; x86_64; ; )
In-Reply-To: <7vocqw8u0x.fsf@alter.siamese.dyndns.org>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124726>

--nextPart56801711.K56hDTdAY4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 03 August 2009 15:30:38 Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> > In a serious case of craniorectal immersion, the Thunderbird developers
> > have started using \r\n line endings on saved emails:
> >
> > https://bugzilla.mozilla.org/show_bug.cgi?id=3D503271
> > https://bugzilla.mozilla.org/show_bug.cgi?id=3D507530
> >
> > It would be nice if git-am could handle this case automatically.
>
> Perhaps
>
>     $ dos2unix *.eml | git am

I didn't try it, but would "git am" with "apply.whitespace" and=20
"core.whitespace" set in some reasonable manner help? Not "automatic", but=
=20
may help if dos2unix isn't available for some reason.

--nextPart56801711.K56hDTdAY4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp3XQ8ACgkQ8KmKTEzW49I2NQCfXbnsCmHqL0drJkyW6zBT+gn3
WYoAn3ExjwTyqEpHWMdnbcy0kiTXylWb
=853S
-----END PGP SIGNATURE-----

--nextPart56801711.K56hDTdAY4--
