From: Stanislav Karchebny <berkus@gmail.com>
Subject: Re: [ANNOUNCE] qgit, another git GUI viewer
Date: Wed, 1 Jun 2005 02:48:39 +0300
Message-ID: <200506010248.45844.berkus@gmail.com>
References: <20050531170445.38748.qmail@web26305.mail.ukl.yahoo.com> <20050531181109.GH11774@osuosl.org>
Reply-To: berkus@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2532309.P39uI8KB9K";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 01:51:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdGVZ-0004Dd-Pg
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 01:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVEaXxG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 19:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVEaXxG
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 19:53:06 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:28135 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261211AbVEaXvH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 19:51:07 -0400
Received: by wproxy.gmail.com with SMTP id 68so194584wra
        for <git@vger.kernel.org>; Tue, 31 May 2005 16:51:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:references:in-reply-to:x-face:cc:mime-version:content-type:content-transfer-encoding:message-id;
        b=pZEGYM6g/PaANxQtZN2Uvvg5DwVF5LznSEpLsgcnAWehgLXusoLWKQXJESF2v1WmYowF9mScgWox+H73aaJge6MXUSalWky0vLlC7MGMRrx4zxBZZYFYehHP70eoluo12T9VK1FJDdxhkVKMNBBiZix0srOXGa6XSPj2spyd8yg=
Received: by 10.54.8.41 with SMTP id 41mr7054154wrh;
        Tue, 31 May 2005 16:51:07 -0700 (PDT)
Received: from mindprobe ([195.50.194.24])
        by mx.gmail.com with ESMTP id d6sm1435366wra.2005.05.31.16.51.06;
        Tue, 31 May 2005 16:51:07 -0700 (PDT)
To: Marco Costalba <mcostalba@yahoo.it>
User-Agent: KMail/1.8.1
In-Reply-To: <20050531181109.GH11774@osuosl.org>
X-Face: )=NoCUhB<yQ9E_sf[!%i~Afu{CgA*1R,*{W~6rwab08b!*c.N-)=?koi8-r?q?9!a3=7BL0+=24=3D7N=7CTiA0=24m=0A=09xayEA7A=3Af?=>~s#1u)J=xNTtjj?;R["\Bh%]jy]i9EV$"48!Y*>=?koi8-r?q?+xw=7ET=26=3D5zk=26=3Al9gtUepOS=0A=095dKjn?=>"'=";T3.$WjpRf!9fSns!$8N0J`2,6,hqE"G.#`W@=?koi8-r?q?=27j2v=7Dn8E=27U=60SMThA5R/deaZ=0A=09m=5DTkBY=3FN5e?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--nextPart2532309.P39uI8KB9K
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 31 May 2005 21:11, you wrote:

> Obligatory screenshot:
> http://ifup.org/~philips/qgit.png

This looks like very bad athena widget set. Not qtish =3D)

> Out of the box it wouldn't compile for several reasons on my own
> computer.  I have attached a diff but the only real solution is to use
> autotools as my diff will now only work on Gentoo systems.

If you could, please do not use autotools. qmake or better scons is the way=
 to=20
go. With scons (even if you distribute together with program) overhead does=
=20
not exceed 60kb and i guess everyone has python installed these days (if no=
t=20
=2D qmake can handle it just right).

If you need a patch for scons, drop me a mail.

=2D-=20
Best regards,
Stanislav Karchebny

Skype name: berkus
Get skype for free from www.skype.com

--nextPart2532309.P39uI8KB9K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCnPfd8v4MNv5cuDkRAgj9AJ9G6+lvUogwlEoKhB02HEBkjaU5TgCbBJIZ
LcX6MGSXKGerVqcANE8nGCo=
=x2Q7
-----END PGP SIGNATURE-----

--nextPart2532309.P39uI8KB9K--
