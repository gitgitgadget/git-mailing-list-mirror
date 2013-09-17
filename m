From: martin f krafft <madduck-JX/+c5DPh7vR7s880joybQ@public.gmane.org>
Subject: Re: cdgit: cd relative to git workdir root
Date: Tue, 17 Sep 2013 07:33:04 +0200
Message-ID: <20130917053303.GF5390@fishbowl>
References: <201309162101.14879.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7372697505596608324=="
To: "git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	vcs-home <vcs-home-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>
X-From: vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org Tue Sep 17 07:35:39 2013
Return-path: <vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>
Envelope-to: gcvh-vcs-home@m.gmane.org
Received: from domine.madduck.net ([77.109.139.90])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>)
	id 1VLnwo-0001QB-IN
	for gcvh-vcs-home@m.gmane.org; Tue, 17 Sep 2013 07:35:38 +0200
Received: from domine.madduck.net (localhost [IPv6:::1])
	by domine.madduck.net (Postfix) with ESMTP id B68FA20CA2
	for <gcvh-vcs-home@m.gmane.org>; Tue, 17 Sep 2013 07:35:36 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.97.8 at domine
Received: from fishbowl.rw.madduck.net (ip-109-43-3-223.web.vodafone.de
	[109.43.3.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by domine.madduck.net (Postfix-submission) with ESMTPS id B7DEE20C94;
	Tue, 17 Sep 2013 07:33:05 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.97.8 at domine
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 28587204CA; Tue, 17 Sep 2013 07:33:04 +0200 (CEST)
In-Reply-To: <201309162101.14879.thomas-5j3myg3OO4w@public.gmane.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux jessie/sid kernel 3.11-rc4-amd64 x86_64
X-Spamtrap: madduck.bogus-JX/+c5DPh7vR7s880joybQ@public.gmane.org
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-BeenThere: vcs-home-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: Discussion list for storing ~ under VCS control
	<vcs-home.lists.madduck.net>
List-Unsubscribe: <http://lists.madduck.net/options/vcs-home>,
	<mailto:vcs-home-request-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.madduck.net/pipermail/vcs-home>
List-Post: <mailto:vcs-home-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>
List-Help: <mailto:vcs-home-request-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org?subject=help>
List-Subscribe: <http://lists.madduck.net/listinfo/vcs-home>,
	<mailto:vcs-home-request-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org?subject=subscribe>
Sender: vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org
Errors-To: vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234851>


--===============7372697505596608324==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Thomas Koch <thomas-5j3myg3OO4w@public.gmane.org> [2013.09.16.2101 +0200]:
> shell alias cdgit =3D cd $(git root)

I've tried to make this happen many years ago, but I never finished
the ZLE widget that did it. The idea was to bind 'tab' to a function
that would replace an occurrence of ~g in $LBUFFER with the output
of rev-parse--show-toplevel and then delegate to normal tab
expansion.

So now I just have

  hash -d g=3D$(git rev-parse --show-toplevel)

in a pre-prompt function and get the same effect.

  fishbowl:~/code/salt|develop|debian% ls ~g/debi<tab>

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i am not in favour of long engagements. they give people the
 opportunity of finding out each other's character before marriage,
 which i think is never advisable."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus-JX/+c5DPh7vR7s880joybQ@public.gmane.org

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQLvBAEBCgDZBQJSN+mPwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xHdQ
D/4gN7Iy2zW43+N7heT1caSd57IKKwT2l5+tv1i0sb7fMj/w4x2/Qp3Lmm8rARKD
ytIipU4hzLPrKeDwhf+P/wO7DMhMQaMnuLo/ooPzC1rg9oS8JtHaC3Vl6pzQJG5b
4DYEC4mStNN3L7FADjTG2jrOXV6ty76RfgjOQeJO0zcFofWh7M6wb1qyEEchc3gd
EdcB+azJza/2btrOKqsBQc5CSZbEyYQiguiSM2KxwoDdGwnMJoblpCYnrtutJPO5
2Rwe+kBS+z1Rq1exUHafa4Fyetq8fsL0JC/NlUaBU3SxoYNBLxrV+Y1EnPGoN1lC
kbKZMW6u/t3Kk6gwFOy3ZFkbC+tW2N0VQ+atabhBRFcCCX3LuslG+XrdhL2GuM+6
cBdyvqifwwJYrBOkl3QkH0p2jgU4RB1U4vN+MW130K+KtLcgOEmjNaFCACZV+7iq
6aDVmjtjMAIcu1h7LPc6pBX1SmN7VVPZsVIsrlJ3tfhtJkpjua99ZTdAf4UgeRKv
oEjWkZU/8iDsZeL/zfZMZfjs5BVlyfulUbgEAvTI30nD5RrI3JjzzNodNQ6zbcCn
mHn3NhPayp7dngGVw8LbQ4nXvSUQ7VBxDwD5SsDrxuvvcwOb7V2h4NEFOk4aMpm0
DgZAI5VB1www758ZNKAJVyGTukiWd9gR7fNjz4U4Aqowow==
=upnh
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--


--===============7372697505596608324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
