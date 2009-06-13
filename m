From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [bug] git cannot find "git pull"?
Date: Sat, 13 Jun 2009 11:04:51 -0400
Message-ID: <20090613150451.GK5076@inocybe.localdomain>
References: <4A319CE1.6040201@garzik.org>
 <20090612011737.GB5076@inocybe.localdomain> <4A323C56.1090703@garzik.org>
 <4A32A814.5050802@garzik.org> <20090612202642.GI5076@inocybe.localdomain>
 <4A32BF52.50603@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 17:05:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFUn7-0000dp-Ft
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 17:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbZFMPE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbZFMPEz
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 11:04:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbZFMPEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 11:04:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BAFE8BB1A7;
	Sat, 13 Jun 2009 11:04:55 -0400 (EDT)
Received: from inocybe.localdomain (unknown [173.67.155.244]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D0E8FBB1A6; Sat,
 13 Jun 2009 11:04:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4A32BF52.50603@garzik.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 8E06C8C6-582B-11DE-884E-97731A10BFE7-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121501>


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> FWIW, to reproduce my Fedora install, this is the setup I always use
> for my lab computers:
>
> * perform a fresh format + install, not an upgrade
> * uncheck 'office' category
> * check 'software development' category
> * do not select 'customize now', thus using Fedora's default package
> selection

Stranger and stranger.  I followed the above steps with an F-11/x86
network install and then ran:

    $ git clone git://repo.or.cz/git.git
    ...
    $ cd git ; git pull
    Already up-to-date.

    $ rpm -q git
    git-1.6.2.2-1.fc11.i586

    $ rpm -ql git | grep git-pull$
    /usr/libexec/git-core/git-pull

Does git --exec-path report something other than /usr/libexec/git-core
on your installs?  Is git-pull located in /usr/libexec/git-core?  Does
'rpm -V git' return anything?

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Few things are harder to put up with than a good example.
    -- Mark Twain (1835-1910)


--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKM8ALJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjp6QH/3K3QCHU4cyAPfSYjkKzTDc6ThVE3mfvH4Wt
6zOxmWg9wcyH7tUithyzMNgsINR2LkthSKBl/ARQRrrBRg8dWr02MUA6Ef05JT+t
sBUrvzQhRzdCueGRr81duEBH9GzCcnUn83a5ImmI7IQbJBfx7+jKy01xVvSTnp8I
XqTjWzrou0Uk9psXEuWgA9/vp+gAV5jEar6gcb5rt5W2TLMNJo+AaBqfUFlx4eDb
COv/AFP8tA5vY4z9ZV2N+1OVTjkXx2dbulEKfIioJHy3stoxeeUZEY8xFX1Y5tSS
gd8Nl5JZLLUt7w7Z9Vuc0HQBI3GR6ImxsMBca+yZfyUmOYFy6Vw=
=NJzz
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--
