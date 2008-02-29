From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: '.git file' alternative, native (cross-platform)
 workdir support.
Date: Fri, 29 Feb 2008 22:32:30 +0100
Message-ID: <47C879EE.2000808@trolltech.com>
References: <47C7FA49.9010001@trolltech.com> <alpine.LSU.1.00.0802291248510.22527@racer.site> <7vabljcyzh.fsf@gitster.siamese.dyndns.org>
Reply-To: marius@trolltech.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enigBD3F483546B9DDA5A6C95E58"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Feb 29 22:33:32 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCrB-000313-3f
	for gcvm-msysgit@m.gmane.org; Fri, 29 Feb 2008 22:33:29 +0100
Received: by yw-out-2122.google.com with SMTP id 4so1284892ywc.37
        for <gcvm-msysgit@m.gmane.org>; Fri, 29 Feb 2008 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:face:content-type:x-virus-scanned:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=RorrcNKYiYpNT/6gVjZuxK6O+QugKZMvjjDe+E5YOsE=;
        b=L8Igd263ld0rgRY5gjl9ansNNxy5h8KFqAp1kftN8Qy6X2XGstjiPSc7yPwEZZXtpYNaxgMl2h4qgVwU4RJO1raXEGsnaqxqnvm0/KSYKujxGLXYZ0oRQ3X6vZx8I9gEyxh9PZUVjtvID8TwXkxa+Gsvekf9oruV9SpemX4mnfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:face:content-type:x-virus-scanned:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=q35qGgTAhhzVfHZ4OCvxwMywOrSq3dJ013EyG54q+QqSXHN2GnqG6ANoJmL65Z4Nqh4hjsVqL666Bk/8Rpbp2cpWWn1l8xyuJ8JcRXMkXlRAU5sgqPW9dnFM5cvZNZPhK+Kmqw/EuinhQ9a64Q+tZn9E3vydTOBKk5MTu+OUw54=
Received: by 10.100.137.11 with SMTP id k11mr889239and.15.1204320772729;
        Fri, 29 Feb 2008 13:32:52 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1862pro.0;
	Fri, 29 Feb 2008 13:32:52 -0800 (PST)
X-Sender: marius@trolltech.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.115.91.2 with SMTP id t2mr7621207wal.24.1204320771740; Fri, 29 Feb 2008 13:32:51 -0800 (PST)
Received: from hoat.troll.no (hoat.troll.no [62.70.27.150]) by mx.google.com with ESMTP id k36si439841waf.0.2008.02.29.13.32.47; Fri, 29 Feb 2008 13:32:51 -0800 (PST)
Received-SPF: neutral (google.com: 62.70.27.150 is neither permitted nor denied by best guess record for domain of marius@trolltech.com) client-ip=62.70.27.150;
Authentication-Results: mx.google.com; spf=neutral (google.com: 62.70.27.150 is neither permitted nor denied by best guess record for domain of marius@trolltech.com) smtp.mail=marius@trolltech.com
Received: from localhost (localhost [127.0.0.1]) by hoat.troll.no (Postfix) with ESMTP id 100B1581CA; Fri, 29 Feb 2008 22:32:03 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1]) by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP id 30935-07; Fri, 29 Feb 2008 22:32:02 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78]) by hoat.troll.no (Postfix) with ESMTP id 6AA81581C5; Fri, 29 Feb 2008 22:32:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <7vabljcyzh.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=34EB4437
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1 KOEmUlJISdYPgEgehw+cTZEf6xeF
 yoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75567>


This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD3F483546B9DDA5A6C95E58
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> The primary reason we may want to do the ".git file" thing is to
> sanely support switching between branches (or checking out a
> different revision, which amounts to the same thing) when one has a
> submodule and the other one either does not have that submodule
> anywhere or have it in a different location in its tree.
=2E..
> One way to solve this would be to add .git/submodules/paulus.git=20
> repository inside the controlling reopsitory of the toplevel project,
> and point that with the ".git file" installed at gitk-git/.git, when
> we are on HEAD.  We can lose gitk-git directory and everything below
> it when switching away from the revision, but when we come back, we
> can recreate gitk-git directory, point gitk-git/.git back to
> .git/submodules/paulus.git kept in the toplevel repository, and check
> the appropriate commit out there.
>=20
> After switching to an old revision that did not have the submodule,=20
> further switching to a branch that has the submodule at modules/gitk
> would be the same deal.  Instead of creating gitk-git directory and
> installing the ".git file" there (which is what we did when we came
> back to the original HEAD), create modules/gitk and install the ".git
> file" there, to point at the same .git/submodules/paulus.git/.

Ahh, ok, this makes sense. *Then* you need to point all of .git to a=20
specific location. But, in this case you're not interested in keeping=20
n-different states, as we are in a multiple workdir situation. So, it's=20
a much easier case.

The question is, is this also the appropriate basis for solving the=20
multiple workdir case? If so, we need to come up with a scheme that lets =

us keep n number of states inside one single .git structure. Is this=20
reasonable? It's not like it's too hard, just a bit messy.

The reason I ask is to evaluate if I should cleanup the patch I did for=20
the native workdir support that started out this thread, or just lay it=20
dead for the '.git file' solution which still would need a lot of work=20
before it's finished. (Though, as I said before, my redirection way=20
could certainly migrate into a '.git file' solution over time)

I basically just need a certain amount of knowledgeable people to either =

say 'drop it' or 'roll with it'.. I'm ambivalent, though I want workdirs =

on Windows yesterday. :-)
So, I guess I have Dscho's -1, and my own +1 =3D 0 :-p

> We should be able to do this today without ".git file" using
> symlinks. It's just a Porcelain hackery, so I'll leave it to
> interested parties as an exercise.

Symlinks wouldn't really work, unless you force people to always keep=20
their full .git next to the workdir. So, multiple workdirs with=20
submodules would then fail, as would FS without symlink support (duh).
This seems to be the issue with the current '.git file' implementation=20
as well. If the repo is not located next to the workdir, it will fail.=20
Or am I reading the code incorrectly? And what happens with recursive=20
submodules?

--
=2Emarius



--------------enigBD3F483546B9DDA5A6C95E58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFHyHnyKzzXl/njVP8RAlPVAJ45nVYOrl/ihS1MdBK4HaNcuoEdSACfUjEG
9AvNXSvAm1mYrmdf4ciBJx0=
=FSkx
-----END PGP SIGNATURE-----

--------------enigBD3F483546B9DDA5A6C95E58--
