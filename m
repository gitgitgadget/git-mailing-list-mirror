From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: About *git clone --depth=n* puzzle
Date: Wed, 14 Aug 2013 10:51:53 +0200
Message-ID: <520B4529.9080304@googlemail.com>
References: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1A1F11C086ECDCCF77F1CC67"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"junchunx.guan@gmail.com" <junchunx.guan@gmail.com>
To: XinLingchao <douglarek@outlook.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 10:52:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9WoB-00049t-5A
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 10:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759540Ab3HNIvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 04:51:54 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60253 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759410Ab3HNIvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 04:51:52 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj13so1659121wib.17
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=dSHDiz08RAHBnAd9wHViq0ND1V///p4reocNmg4XHU4=;
        b=YWfHLJA5/TUVAf7IEbwjfF3qvD4EggrqA3G+A26m0C7/HqwDz+2Vdw4jIdIOML4d5/
         foduLlQC4xv2qORju8jE57U1EfV+TG43T3GoLVzlAMUhBfdU6eJWAGUjIlevHZ0x40KR
         Ft6LBKC8CxBegnauWSPmPLTka8yli442drZCWuqfD5G9We6K3T0ty8rJ/MAPYa4GUtjT
         CvycHRgwtz0zLR2PBtBwp8rJJR7M50bkaITniWpMP+eUbR1+Nx1IkcAwAP4hrxRV36rz
         Uw3QZul1h5a6R6nvlkUnYUNc5dZkoAlxl22cvGXL84sFyLnmxhcc93hxX7NJeJXjoYHy
         iFeQ==
X-Received: by 10.194.120.68 with SMTP id la4mr597105wjb.33.1376470311400;
        Wed, 14 Aug 2013 01:51:51 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id e7sm1500317wiy.4.2013.08.14.01.51.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 01:51:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232273>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A1F11C086ECDCCF77F1CC67
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/14/2013 10:20 AM, XinLingchao wrote:
> Hi Guys,
>=20
> I think I have got some trouble when I use `git clone --depth=3Dn` comm=
and. Take a real repo for example:
>=20
>=20
> `git clone https://github.com/douglarek/vimrc.git --depth=3D1`
>=20
>=20
> then I use `git log`:
>  =20
> ``` =20
>     commit d04ca09ecc723739123fae11ad56784eb0c9b36a
>     Author: Lingchao Xin <douglarek@outlook.com>
>     Date:   Fri Jun 7 09:39:22 2013 +0800
>=20
>         Update vnudle to master branch, add wm shortcut, pylint optimiz=
ation
>=20
>     commit c66d827dc212f6ae8aab6b5c44631564bcbe2acd
>     Author: icocoa <lingchax@outlook.com>
>     Date:   Tue Mar 12 01:36:34 2013 -0700
>=20
>         Merge pull request #1 from douglarek/master
>=20
>         Add markdown, flake8, pylint plugin
>=20
> ```
>     but when I clone it with `file://`:
>=20
>     git clone https://github.com/douglarek/vimrc.git
>     git clone file://vimrc.git --depth=3D1 vimrc1
>=20
>     I got this log:
> ```
>     commit d04ca09ecc723739123fae11ad56784eb0c9b36a
> Author: Lingchao Xin <douglarek@outlook.com>
> Date:   Fri Jun 7 09:39:22 2013 +0800
>=20
>     Update vnudle to master branch, add wm shortcut, pylint optimizatio=
n
> ```
>=20
> so the two results are not same, is it a bug? or it should be so?
>=20
> My os is openSUSE 12.3 and git version 1.8.3.4; and myabe it occured in=
 git 1.8.1.4 +.
>=20
>=20
> Thanks and Best regards
>=20
> Lingchao Xin 		 	   		  --

There was a similar discussion going on in July this year,
maybe this is an interesting read with respect to this topic
http://www.spinics.net/lists/git/msg196138.html

Stefan



--------------enig1A1F11C086ECDCCF77F1CC67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSC0UpAAoJEJQCPTzLflhqIKMP/RVsOPKy5Yd9Oguj5OxjwqFU
YaBvvjVAKyH6xNqdH8WURY0KnAnWyFMM3POw+VoVWHPANYW9xah4vSIhrQCK5ju6
uWrNRyIi6DM7EjkUzoEDdkbCd2QTobs/h/x7JEhSADXKc89s7pl/RMGdmrgDMLap
jkWWYTLt8Tz/yIoVXA3/fv8FOaNZIh2gWT35P7uahqb5SCWKtvzGvE+Ibfu9ou7i
zUbq6zNfsiMwMU4Goqr1TBEzSj1o0fcEA+TlG1KPMD4EmroxZ9nIIFAjwcnvZiJh
+PPb4UCaA821DbGZvMjdk+o7pzVHQP884ks0sih9QR6biq13lcNRUCcj2Z0GQRHs
FtTUuf1Unmj6ZZND65jAy70pv9o5HW4ORQbsWXLps5355/wYDCzSswwtvtKjLkEZ
lVD9O+4IjTg3Po5CRcfr4sxZ+VkeKhZdugBiRwh9OAi1r8F3ZYj3nJauc90JnUrW
Wvqs0mnDpJrNCSn+bwAsZgWtvQ1nswiUuMQWxFp7yl9CCSscshoek0YEGElplX9R
IkK+3ddCPJefdF23Usp7XcyIAYii19zdSQNcocsc2mMEiNJUY0GE22rqn6xo09Z/
yo6kltm9opux/lwFPzPsaZYCjytkBj+nUu2iLHp0FX9/dT08FOXNOloiiMyyUx1a
FzMNuZ/pgoQsqmPpU2LI
=aBqv
-----END PGP SIGNATURE-----

--------------enig1A1F11C086ECDCCF77F1CC67--
