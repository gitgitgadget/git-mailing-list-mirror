From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 22:02:53 +0100
Message-ID: <43DFD07D.7000903@gorzow.mm.pl>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>	<1138446030.9919.112.camel@evo.keithp.com>	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>	<1138529385.9919.185.camel@evo.keithp.com>	<43DCA495.9040301@gorzow.mm.pl> <20060129181240.GA11721@kroah.com>	<43DFAD91.4080105@gorzow.mm.pl> <43DFBF9A.2020409@gorzow.mm.pl> <7v8xsww2kt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9606BEF6A5DD31BE08C250E5"
Cc: Greg KH <greg@kroah.com>, Keith Packard <keithp@keithp.com>,
	cworth@cworth.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 22:03:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42ey-0004fS-Sx
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 22:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWAaVDD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 16:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWAaVDC
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 16:03:02 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:63900 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1751485AbWAaVDA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 16:03:00 -0500
Received: (qmail 1045 invoked from network); 31 Jan 2006 21:02:58 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 31 Jan 2006 21:02:58 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 19732A81AE;
	Tue, 31 Jan 2006 22:02:58 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsww2kt.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15347>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9606BEF6A5DD31BE08C250E5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> writes:
>=20
>> Radoslaw Szkodzinski wrote:
>>> Cloning without -l option is much slower - some minutes vs below a mi=
nute.
>>> I could have time(8)d it, but it's no use.
>>>
>> Make that time(1)d.
>>
>> Results for the kernel follow. Disc cache has been preheated with find=
=2E
>=20
> While you are at it, "git clone -l -s -n" might be more interesting.
>=20
>=20

Sure:

time git clone -l -s -n linux-2.6.git linux-2.6.git.lsn

real    0m0.458s
user    0m0.020s
sys     0m0.027s

Speed demon. I'd use it, but I often need a checkout anyway, so...

time git clone -l -s linux-2.6.git linux-2.6.git.ls

real    0m35.752s
user    0m2.661s
sys     0m2.374s

Not really better than git clone -l and relies on the tools more.
However, it should make for easier repacking and pruning. I'll keep it.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig9606BEF6A5DD31BE08C250E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD39CBlUMEU9HxC6IRAnjnAJ9iFUsS7aCSX5wRm1SKvkbu+iZ3pQCeJqa4
FRKWu2QbpPDO6SgvfSw82pw=
=WEOC
-----END PGP SIGNATURE-----

--------------enig9606BEF6A5DD31BE08C250E5--
