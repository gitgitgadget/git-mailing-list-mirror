From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Possible regression in master? (submodules without a
 "master" branch)
Date: Thu, 27 Mar 2014 20:05:56 -0700
Message-ID: <20140328030556.GD25485@odin.tremily.us>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
 <xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
 <5334606F.5010109@web.de>
 <20140327185405.GS4008@odin.tremily.us>
 <xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
 <20140327202702.GA3984@sandbox-ub>
 <CALKQrgdAhe0AKk51=__fDWX9QqFH=WVCO=gU+mtO6sb250==0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:06:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTN7N-0003zu-T9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 04:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485AbaC1DGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 23:06:00 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:51511
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757211AbaC1DF7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 23:05:59 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id ir4m1n00227AodY54r5ztV; Fri, 28 Mar 2014 03:05:59 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id ir5x1n00E152l3L3fr5yCr; Fri, 28 Mar 2014 03:05:59 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id F074310DE218; Thu, 27 Mar 2014 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395975956; bh=qKbujaBdL3Cic1pyAefFzlMY8ikcesuSKhAshd+I/9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J0kKckJiBcNF01XGsy7z4KuakNIiNAWDsTy5mf2fT4SHzpnub+4NRpcP7DPAUCey/
	 G0wiI96nVm3WA2akup8NulFdcx7AE64f3+j9f1sp+CoRJN2malNX10dpMikA4lxso3
	 BnaHX5Ub5ZcQM0L3oYiEYKqTx4ysqqJQnEad+BYk=
Content-Disposition: inline
In-Reply-To: <CALKQrgdAhe0AKk51=__fDWX9QqFH=WVCO=gU+mtO6sb250==0A@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395975959;
	bh=Q15RRYs2O7JA3kkQS+2eyuw/0PbsewahtX+9ef34RL8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=psnAtpSW0SW1wZUR1aYmHz9Ddj1RPgECYSkurc+IwnL/DnZa2wPSmmDz2hoB3KtaV
	 lvFpCC8QMwwiVOzbk7EDFL+UYX+MmhIihbd5ESI9HDlpbBiNlPcy4p2PbQezYFdJBp
	 EWGpuYYMptbpSdenndyDNQ3hVaen8jxQhZlq14GAS4wW2ZwtgP776NZpxqCskb1MUD
	 FALTttheTMQ+CFioArtQux2YCE9L/Z2SzBnFDrIAFNMuCy/oflTSufCd248PUOKMlS
	 1+5JTAhIviOH1yvO2K18BUpBgyVfFei5zi6YZHAFzdF/BhAtQCF3avWIjNDmF0E+7T
	 WXqeiS6gxOKGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245355>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 12:21:23AM +0100, Johan Herland wrote:
> On Thu, Mar 27, 2014 at 9:27 PM, Heiko Voigt wrote:
> > On Thu, Mar 27, 2014 at 12:39:03PM -0700, Junio C Hamano wrote:
> >> There is this bit for "update" in git-submodule.txt:
> >>
> >>   For updates that clone missing submodules, checkout-mode
> >>   updates will create submodules with detached HEADs; all other
> >>   modes will create submodules with a local branch named after
> >>   submodule.<path>.branch.
> >>
> >> =E2=80=A6
> >> So the proposed change is to make the part before semicolon true?
> >> If we are not newly cloning (because we already have it), if the
> >> submodule.<name>.branch is not set *OR* refers to a branch that
> >> does not even exist, shouldn't we either (1) abort as an error,
> >> or (2) do the same and detach?
> >
> > I would expect "(1) abort as an error" since the user is not
> > getting what he would expect.

Branch-attachment is mostly a function of submodule.<name>.update, not
a function of submodule.<name>.branch.  We could certainly interpret a
missing submodule.<name>.branch as:

* Use the subproject's HEAD for the initial clone (clear start_point
  in cmd_update if submodule."$name".branch is not set).
* Don't change the branch name on subsequent local updates (what we
  already do).
* Do $something if the user tries a --remote update.

I just don't know what that $something should be.

> FWIW, here is the behaviour I would expect from "git submodule
> update":
>=20
>  - In checkout-mode, if submodule.<name>.branch is not set, we
> should _always_ detach. Whether or not the submodule is already
> cloned does not matter.

Agreed, checkout-mode should *always* detach the submodule's HEAD.

>  - In rebase/merge-mode, if submodule.<name>.branch is not set, we
> should _always_ abort with an error.

Why?  Can't we mimic clone and use the remote's HEAD (for --remote
updates)?  That seems more intuitive to me.  For local updates, we're
just integrating the gitlinked commit with the submodule's HEAD, and
you don't need submodule.<name>.branch for that at all.

>  - If submodule.<name>.branch is set - but the branch it refers to
> does not exist - we should _always_ abort with an error. The current
> checkout/rebase/merge-mode does not matter.

Sounds good to me, and should match the current functionality.

> In other words, submodule.<name>.branch is _necessary_ in
> rebase/merge mode, but _optional_ in checkout-mode (its absence
> indicating that we should detach).

The main trigger for =E2=80=9Cwe should detach=E2=80=9D is the update mode
(checkout-mode detaches, all others integrate with the submodule's
HEAD (without changing submodule branches).  You only need
submodule.<name>.branch for determining which *remote* commit you're
trying to integrate (or clone from).  HEAD, master, and =E2=80=9Cdie
screaming=E2=80=9D all sound like reasonable defaults in that case.  Decidi=
ng
between them is a policy/UI decision, not a technical decision.

> >> > gitmodules(5) is pretty clear that 'submodule.<name>.branch'
> >> > defaults to master (and not upstream's HEAD), do we want to
> >> > adjust this at the same time?
> >>
> >> That may be likely.  If the value set to a configuration variable
> >> causes an established behaviour of a program change a lot,
> >> silently defaulting that variable to something many people are
> >> expected to have (e.g. 'master') would likely to cause a
> >> usability regression.
> >
> > IMO this branch configuration should completely ignored in the
> > default, non --remote, usage. Since we simply checkout a specific
> > SHA1 in this case, that should be possible.
>=20
> Yes. Checkout-mode with no submodule.<name>.branch configured should
> always detach.

Except for the initial clone (where it's easy to fix),
submodule.<name>.branch *is* ignored in non --remote updates.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNOcSAAoJEKKfehoaNkbt2awP/j4FfylEoO1Ar5xNEjMNLFxn
dMo3ABz6RfIy5q1JeMZYxcDECpmBx5regGOtTJvCExXu3mhn5bOdoitxhQFo0aua
idhQEZi1Ch/0pj56LxM2jRBWtLshYP8AOhdbxlNzRfOK2EV7pSaw6jX6mOpjEhhg
c6m8V/PJ4btdJ3iy3pn3/Q/jNUtpKLyzahZMSQVRhmyO61aJ+zZ6WC2kSbh/qPdV
LumRw+3of5D6Q7W7Uq36wn0+w7I9JkNIpKRKlSNSC+AgV4xATEmpxH4GB5OCufeY
5HUWtyoBBYsbBzuG1v3BPIUUchwJWvYAte/inH9bGhuAVcf2yCYsxSkUdyr1yKZf
4iwMFa4JRWTNbvDJg6J0UZYD4SL9Na46LKhxl3vLSE4zGvhT7iIif+nzibOkcXFf
KlsK77h3s901guY/1wGx+9kwifvX/Hvza0vkomCJbwm/RWbQYU/kgcBD6+ovpSik
41a2jGYvh84/IaQpx154UjNfcMIraL+ZakeMswdOrnAC9yUyNqe7Q/K7NKKfrZOT
/3IZlvDCsIWN4vVtKBHxbXGhws65ixY2kCaj/3ul03Ov8iepT3SetqFuca8nZySI
j4cPOjEk3EPZ3UdwrAX1QNsRNaTnXgKe77MWW1UO5EXaxJxBejMxofuI/Ebrn66N
9qtcCIP2NRIjRdnHg1U/
=1JpK
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
