From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS
 update
Date: Sat, 20 Jan 2007 02:19:37 +0100
Message-ID: <45B16E29.7000607@fs.ei.tum.de>
References: <200701191049.40833.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig896F05B87E76DE23F4C3C669"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84tZ-0001T9-Co
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbXATBTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbXATBTq
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:19:46 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:57123 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965098AbXATBTo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:19:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 167CD280A7;
	Sat, 20 Jan 2007 02:19:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CgNQWC9s1qJO; Sat, 20 Jan 2007 02:19:41 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-212-125.dynamic.mnet-online.de [62.216.212.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 9ECB4280A5;
	Sat, 20 Jan 2007 02:19:41 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701191049.40833.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37241>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig896F05B87E76DE23F4C3C669
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins wrote:
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index a33a876..c370a53 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -882,7 +882,6 @@ sub req_update
>  		print "MT text A \n";
>                  print "MT fname $filename\n";
>                  print "MT newline\n";
> -		next;

I think this is the wrong fix.  Reading cvs's classify.c, T_ADDED is only=
 generated for *locally* added files, never for added files in the repo. =
 The correct status would be "U" as well.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig896F05B87E76DE23F4C3C669
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsW4rr5S+dk6z85oRAkhmAKCRs5y9esZ3fh/CJlpjuTMZxGA52QCggbcL
9huOF0+mzAgZ44UC2APVMmM=
=eBHK
-----END PGP SIGNATURE-----

--------------enig896F05B87E76DE23F4C3C669--
