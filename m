From: William Giokas <1007380@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 13:48:00 -0500
Message-ID: <20140513184800.GF9051@wst420>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
 <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
 <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
 <537233CC.3050904@web.de>
 <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 20:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHkf-00050U-QG
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbaEMSsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:48:30 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64329 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbaEMSs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:48:29 -0400
Received: by mail-ie0-f173.google.com with SMTP id rp18so764997iec.32
        for <git@vger.kernel.org>; Tue, 13 May 2014 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zf8gjS8ThXq9D7XZFk5isGL/cUE8xydLVMB1Ysfw6IE=;
        b=qxPxdRX13KGb0jk/ce7ZzOOm+slequwm7/GlAD3RHHWtHTV33TLkuAE5SjsFvJOHkO
         AztJmNGMXk2KmmXaTMJrBMvUxxCmS4s0dlsia+1yTwsLW1TeymgtsAKGk0sYEQVmMoiK
         Zh9I8akHlAEGKuTkJ/YaRYQSHFnthod6zcu0U2sj7d6nq3v+JiTXDtHs2qU3gj1X94TI
         sv9I5UEAoSm8FPYTD4VTkOEVo/7Xb4nC1hM5RbDRMylhc6fFKb2QGJ0W5/7JayiUQueW
         si2KdqmG/TJO6ALmfe+eeNBJ20Y6ty9gjEH3TNhTgLf/vy/tn60k2ItRmiiGU+MX1gD4
         Fvgg==
X-Received: by 10.42.120.15 with SMTP id d15mr1113160icr.35.1400006908912;
        Tue, 13 May 2014 11:48:28 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id nj14sm31900692igb.18.2014.05.13.11.48.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 11:48:27 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248803>


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2014 at 10:30:26AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
> > I did some testing with Git 2.0-rc3 + 58aee0864adeeb5363f.
> > The remote-helper tests for hg-git worked OK
> > with both hg version 2.9 and 3.0 under both Mac OS and Linux.
> >
> > Should we consider 58aee086 to be included in Git 2.0 ?
>=20
> So the answer to your question is an unambiguous "no".
>=20
> It is a different matter if we want a change to allow us to operate
> with both older and newer version of mercurial in a release of Git
> in near future.  The answer is a resounding "yes", even if the
> solution may not be the exact 58aee0864 commit [*2*].  I think an
> update should eventurally go to the maintenance tracks of even older
> releases, perhaps maint-1.8.5 and upwards, after we merge it to
> 'master' in preparation for the feature release that comes after Git
> 2.0, which probably will be called 2.1 but do not quote me on that.
>=20
> Regarding the commit in question, I asked Felipe a question and
> never got a straight answer.
>=20
>     Why do we "import changegroup" unconditionally, even though it
>     is only used in the new codepath meant only for version 3.0 or
>     higher, not inside the "if" block that decides if we need that
>     module?

It should not be, as it is not used outside of hg 3.0. In fact, what
would be even better would be to test whether changegroup.getbundle is
available, and then set a function like `getbundl()` to run either
`changegroup.getbundl()` with the correct args, or `repo.getbundle()` as
a fallback.

changegroup is prefectly /okay/ to import unconditionally, though as you
say it will never be used.

We can also be even more explicit with what we import by doing something
like::

  try:
      from mercurial.changegroup import getbundle

  except ImportError:
      def getbundle(__empty__, **kwargs):
          return repo.getbundle(**kwargs)

and then just calling::

  cg =3D getbundle(repo, 'push', heads=3Dlist(p_revs), common=3Dcommon)

The `__empty__` arg is there because repo.getbundle uses a different
number of arguments than the changegroup.getbundle function. It's a much
cleaner solution than assuming that that will stay in changegroup, and
not get moved back to repo in the future. Seems to be what you described
in the second bit, though. If you would like I can submit a patch once
I've finished running the tests on it, and possibly after having Felipe
run it through his tests to be sure thta the 2.[7-9] series works as
well, and maybe you would want to test it on other versions of
mercurial that you are running alongside git.

Just my 2 cents.

>=20
> I had a few more questions in mind that I didn't have a chance to
> ask, and the commit log message did not explain.
>=20
>     Is the reason why this fix is needed is because "repo" stopped
>     being a way to ask ".getbundle()" and in the new world order
>     "changegroup" is the new way to ask ".getbundle()"?
>=20
>     If the answer is "yes", then asking "are we with 3.0 or
>     later---if so ask changegroup for ".getbundle()?", which is this
>     patch does, may not be the right condition to trigger the new
>     codepath.  "Does repo know how to do .getbundle()?  If not,
>     import changegroup and ask that module to perform .getbundle()
>     instead" may be a way to base the decision on a more directly
>     relevant condition.
>=20
> Answers to these questions, if they came, were meant to convince
> myself that the patch 58aee0864 is the best solution to the problem,
> but because I only got "Of course it is not a mistake" [*1*], seeing
> it did not lead to a productive discussion, I gave up.  So I haven't
> even managed to convince myself that that commit is the best
> solution to the problem.

I was really sad to see that, and didn't have time to really look at it
because of work and other projects, but I hope this presents a better
solution than the current patch.

Thanks,

--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcmjgAAoJEGkCBthzzQnP2+UP/1cFG2xiWZaKWdx3bFk/4g4d
zSTS7aK+eFUkwYvrqQaCuKdQ3WL+dn07eej2HkbRn5qOkxUH1s+JJlaf+Z6xhL1Y
ribQaFAZ9hGxB8nCH5ipHneKcj+ZyDAi3qi07FiMRAs9htGH7uUoN1cMQY66bi6K
FH2jy7uYcFLMwUfzfKvSdN6mdyqB/FdKkSohN6IdhE6O9gEtz1fhyhh6eN8mkSnH
W3sGIPJK6WdIjQ8VE2qpdyZzgJe2nDPJi2r8zkaL3b8fFbM43sTMN2mryd3SF7Jt
55xLDuRPlHF6VCPYcslgIP9SYPESn9TzDgIk45t7ZQ35Y81hO5MWzjXRv9c78VL4
CpfAiXWOgL33VpfUjVcAStlNsUEPW8VVl3hn+eVJ68ItJwVv6P9v4UdNgSygyt/n
nt25cg0q3rTy35FwZwoNydvspueY7/Pe995bWHuKGwFJvBWtNvr7/JLWZ6sWtNzf
gNykSGmEZubAsSeXf5abFOejjVaYpyV30e8O8zC7j1RGUVGW94k5vkwOMyS61e6O
T5fVMlBVhc4GHxBOWy3E1NSVxMjcKuX1iuuLW5Dw37RTKejXNHkqNqhl1vfESCDU
s5cir2MaqVPjRZGaHhEu/24pEo2Fu28f+9sd8XUCEErI0UYx1u4XJgBilYDcxE1+
VcBDKGoJHDpd35U2GUNX
=2pD9
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
