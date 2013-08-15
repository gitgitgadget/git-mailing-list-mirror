From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bug with `git branch HEAD` in a 'detached HEAD' state
Date: Thu, 15 Aug 2013 22:58:17 +0200
Message-ID: <520D40E9.1020000@googlemail.com>
References: <520D3F2A.5020203@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA1ABF5C2C4D33DEED76377B1"
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Beno=EEt_Legat?= <benoit.legat@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 22:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA4co-0000mu-HI
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 22:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab3HOU6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 16:58:11 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:58209 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3HOU6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 16:58:11 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so602636eek.10
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=XbhkFYYfWXSQNaslodqOmXILr7uon5OI+gh/dHl7OzY=;
        b=v3d6Ntc3V1Yh4s9jKaf4fNw9/Xvx6fB3ag8epELweYRe24C/2T2BUutTZMiyOpbmKh
         zEIgQpJhH57zjamZR9NolBgpTqN1cDi9mGg7UimgZ9Iy8qL7PTtxLc2rDUgSJHAxgZe0
         HOVPq2gFce7ly8Im58eYdkhwstaJNaroMbdgR7howvsN8B2i57Rl1yjQS5EXJxsjj1Lg
         JoELgjQsEnoUISLu7FYCzUF29cXL/+2rLAHvh0LlwxKdLB+mUJu5MQ7VXmwFdEI4T0h3
         H9lGqg/lKOB32v331cuSb2d5bQffmoUV7BcIaV13wDK308wv+PYN1umnNSY1UKvAFOzg
         0RaQ==
X-Received: by 10.14.149.3 with SMTP id w3mr44681eej.84.1376600289597;
        Thu, 15 Aug 2013 13:58:09 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id f49sm1694070eec.7.2013.08.15.13.58.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 13:58:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <520D3F2A.5020203@gmail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232368>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1ABF5C2C4D33DEED76377B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/15/2013 10:50 PM, Beno=EEt Legat wrote:
> Hello everyone,
>=20
> I think I have just found a bug in Git which basically occurs when I ru=
n
> `git log HEAD` in a detached HEAD state.
> To reproduce it, just run
> $ git init
> ...
> $ touch tmp
> ...
> $ git add tmp
> $ git commit -m "tmp"
> ...
> $ git checkout <commit_sha>
> ...
> $ git branch HEAD
> Segmentation fault (core dumped)
>=20
> My version of git is the following
> $ git --version
> git version 1.8.1.2
>=20
> If that helps (and even if it doesn't actually), I'm running ubuntu
> 13.04 64-bit.
>=20
> Beno=EEt Legat
> --=20
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


This should be fixed by 8efb8899cfe866dddb3659b9e0a94232161db65e
(2013-02-23, branch: segfault fixes and validation)

I could reproduce with 1.8.1.2, but not on current master branch.
If this annoys you too much, please update your git version. ;)

Stefan


--------------enigA1ABF5C2C4D33DEED76377B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDUDpAAoJEJQCPTzLflhq8QQQAKLXp1AT+qWNShQMxdEbG3ly
FIgoO6Y2h5eDZjalj6ibzhsBPAYMIlgDaI6vVa4nMS2nkv/L2WniqFvNf+Eijo8p
qkCo9lcgWgUCLq3cKbsvM4w5BJuN2jdWPt+X26l22WjY137PJcpn3i5siaGw/H+1
OI1Hv58f+pYMDCvunSGdDD+BHyrW4LJCDzg7ffWwm1/nB6jJPi2gAaZLiKbO/8PR
D6kTCrK3ldXqReV0uj5n/zGWsDqFS9VcYFI7yvzE+DOg24lCbV7MQH+yNN4bTOI7
WMzsJGNutRZKazPfEp9/i/kQEeVAoTRtOd2bRN+OnZZ2BISX4N/3XXxuJghQAXrJ
9Z977JpfNUvvlasKkXrcdBH1Vyk21TmTWLQHj5ZTjfdSxhdrZ+FwrCrTiIfxfvoF
PN0Xaq9Qqyd8hEfNgg3cAwgFEbFd3F9XJeN9RyX14kErKmEDxP7ISv7RxlOIfz3Z
WWcwy8Eu/C4kLdAwBBYrI/9XjlPssX2nzEsbKHawDQlK/5xFH5OPnV6d4VOH0dbE
xZigBZ6sD6vp2FSsxG6Xnz8pJCi18emmNlgtawgNxIUoLHgH+7I1UxQLqZ4vK7ny
polANJjNlX9QFiNRmNRdF463w4DEKcD8/S8o51YX0ol8LvxEnGykLSjE5SvnitFe
xnzTeWolFnh8QVtMMFDH
=9xV+
-----END PGP SIGNATURE-----

--------------enigA1ABF5C2C4D33DEED76377B1--
